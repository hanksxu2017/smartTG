package cn.com.smart.web.service;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.entity.TGStudyCourseStudentRecord;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.search.StudentSearch;
import cn.com.smart.web.constant.enums.tg.CourseStudentRecordStatusEnum;
import cn.com.smart.web.constant.enums.tg.SystemMessageEnum;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.*;

@Slf4j
@Service
public class StudyMakeUpService {

    @Autowired
    private StudyCourseRecordService courseRecordService;

    @Autowired
    private OPService opService;

    /**
     * 查询存在缺课的学生
     * @param searchParam       查询参数
     * @param pageNum           页码
     * @param pageSize          页大小
     * @return                  学生信息
     */
    public SmartResponse<Object> findStudentHasAbsent(StudentSearch searchParam, int pageNum, int pageSize) {
        TGStudyCourseRecord studyCourseRecord = this.courseRecordService.find(searchParam.getCourseRecordId()).getData();
        searchParam.setCourseId(studyCourseRecord.getCourseId());
        SmartResponse<Object> smartResp =
                opService.getDatas("student_has_absent_course_list", searchParam, (pageNum - 1) * pageSize, pageSize);
        this.packageAbsentCount(smartResp);

        return smartResp;
    }

    private void packageAbsentCount(SmartResponse<Object> smartResp) {
        List<Object> objectList = smartResp.getDatas();
        if(CollectionUtils.isEmpty(objectList)) {
            return;
        }
        List<Object> resObjectList = new ArrayList<>();
        Object[] objectArr;
        Object[] resObjectArr;
        for (Object anObjectList : objectList) {
            // 每个object是一个object数组
            objectArr = (Object[]) anObjectList;
            resObjectArr = new Object[objectArr.length + 1];
            System.arraycopy(objectArr, 0, resObjectArr, 0, objectArr.length);
            resObjectArr[3] = this.getCountByOpService("student_has_absent_count", objectArr[0].toString());
            resObjectList.add(resObjectArr);
        }
        smartResp.setDatas(resObjectList);
    }

    private int getCountByOpService(String resId, String studentId) {
        Map<String,Object> params = new HashMap<>();
        params.put("studentId", studentId);
        List<Object> studentCountList = this.opService.getDatas(resId, params).getDatas();
        BigInteger intValue = (BigInteger)studentCountList.get(0);
        return intValue.intValue();
    }

    public SmartResponse<String> doMakeUp(String studentId, String courseRecordId) {
        SmartResponse<String> smartResponse = new SmartResponse<>();
        if(StringUtils.isBlank(studentId) || StringUtils.isBlank(courseRecordId)) {
            smartResponse.setMsg("请求无效");
            return smartResponse;
        }
        TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseRecordId).getData();
        if(null == courseRecord || !courseRecord.canSign()) {
            smartResponse.setMsg("课时无法进行补课操作");
            return smartResponse;
        }
        String[] sId = studentId.split(",");
        for (String aSId : sId) {
            doSubMakeUp(aSId, courseRecord);
        }

        smartResponse.setResult(IConstant.OP_SUCCESS);
        smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
        return smartResponse;
    }

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

    @Autowired
    private StudyStudentService studentService;

    @Autowired
    private StudySystemMessageService systemMessageService;

    private void doSubMakeUp(String studentId, TGStudyCourseRecord courseRecord) {

        Map<String,Object> params = new HashMap<>();
        params.put("studentId", studentId);
        List<Object> studentAbsentRecordList = this.opService.getDatas("student_absent_course_record_list", params).getDatas();
        if(CollectionUtils.isNotEmpty(studentAbsentRecordList)) {
            log.info("缺课记录:{}", studentAbsentRecordList);
            Object[] objects = (Object[])studentAbsentRecordList.get(0);
            Map<String, Object> map = new HashMap<>();
            map.put("studentId", studentId);
            map.put("courseRecordId", objects[0]);
            List<TGStudyCourseStudentRecord> previousAbsentRecordList = this.courseStudentRecordService.findByParam(map).getDatas();
            if(CollectionUtils.isEmpty(previousAbsentRecordList)) {
                return;
            }
            TGStudyCourseStudentRecord previousAbsentRecord = previousAbsentRecordList.get(0);
            if (null != previousAbsentRecord && !StringUtils.equals(previousAbsentRecord.getStatus(), CourseStudentRecordStatusEnum.NORMAL.name())) {
                // 新增一个补课类型的学生课时
                TGStudyCourseStudentRecord courseStudentRecord = new TGStudyCourseStudentRecord();
                TGStudyStudent student = this.studentService.find(studentId).getData();
                courseStudentRecord.setCourseRecordId(courseRecord.getId());
                courseStudentRecord.setCourseId(courseRecord.getCourseId());
                courseStudentRecord.setStudentId(student.getId());
                courseStudentRecord.setStudentName(student.getName());
                courseStudentRecord.setStatus(CourseStudentRecordStatusEnum.X_MAKE_UP.name());
                courseStudentRecord.setCreateTime(new Date());
                courseStudentRecord.setMakeUpTargetId(previousAbsentRecord.getId());
                this.courseStudentRecordService.save(courseStudentRecord);
                // 修改补课目标课时为已签到
                previousAbsentRecord.setStatus(CourseStudentRecordStatusEnum.SIGNED.name());
                previousAbsentRecord.setSignType(IConstant.SIGNED_TYPE_MAKEUP);
                previousAbsentRecord.setUpdateTime(new Date());
                this.courseStudentRecordService.update(previousAbsentRecord);
                // 更新签到统计信息
                this.updateSignCount(previousAbsentRecord.getCourseRecordId());
                // 取消学生连续签退计数器
                if(student.getCourseSeriesUnSigned() != 0) {
                    student.setCourseSeriesUnSigned(0);
                    student.setUpdateTime(new Date());
                    this.studentService.update(student);
                }
                // 取消学生连续缺课的系统提醒
                this.systemMessageService.processSystemMessageBySystem(SystemMessageEnum.STUDENT_ABSENT_NOTE, student.getId());
            }
        }
    }

    /**
     * 更新课时的签到信息
     * @param courseRecordId    课时编号
     */
    private void updateSignCount(String courseRecordId) {
        // 修改签到统计信息
        TGStudyCourseRecord previousCourseRecord = this.courseRecordService.find(courseRecordId).getData();

        Map<String, Object> params = new HashMap<>();
        params.put("courseRecordId", courseRecordId);
        params.put("status", CourseStudentRecordStatusEnum.SIGNED.name());
        List<TGStudyCourseStudentRecord> normalList = this.courseStudentRecordService.findByParam(params).getDatas();
        previousCourseRecord.setStudentQuantityActual(CollectionUtils.isNotEmpty(normalList) ? normalList.size() : 0);

        params.put("status", CourseStudentRecordStatusEnum.PLAY_TRUANT.name());
        List<TGStudyCourseStudentRecord> playTruantList = this.courseStudentRecordService.findByParam(params).getDatas();
        previousCourseRecord.setStudentPlayTruant(CollectionUtils.isNotEmpty(playTruantList) ? playTruantList.size() : 0);

        params.put("status", CourseStudentRecordStatusEnum.PERSONAL_LEAVE.name());
        List<TGStudyCourseStudentRecord> personalLeaveList = this.courseStudentRecordService.findByParam(params).getDatas();
        previousCourseRecord.setStudentPersonalLeave(CollectionUtils.isNotEmpty(personalLeaveList) ? personalLeaveList.size() : 0);

        this.courseRecordService.update(previousCourseRecord);
    }

    public SmartResponse<String> removeMakeUpStudent(String studentId, String courseRecordId) {
        SmartResponse<String> smartResponse = new SmartResponse<>();
        Map<String, Object> params = new HashMap<>();
        params.put("studentId", studentId);
        params.put("courseRecordId", courseRecordId);
        params.put("status", CourseStudentRecordStatusEnum.X_MAKE_UP.name());
        List<TGStudyCourseStudentRecord> courseStudentRecordList = this.courseStudentRecordService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseStudentRecordList)) {
            TGStudyCourseStudentRecord targetCourseStudentRecord = this.courseStudentRecordService.find(courseStudentRecordList.get(0).getMakeUpTargetId()).getData();
            if(null != targetCourseStudentRecord) {
                targetCourseStudentRecord.setStatus(CourseStudentRecordStatusEnum.PLAY_TRUANT.name());
                this.courseStudentRecordService.update(targetCourseStudentRecord);

                this.updateSignCount(targetCourseStudentRecord.getCourseRecordId());
            }

            this.courseStudentRecordService.deleteByField(params);
        }

        smartResponse.setResult(IConstant.OP_SUCCESS);
        smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
        return smartResponse;
    }
}
