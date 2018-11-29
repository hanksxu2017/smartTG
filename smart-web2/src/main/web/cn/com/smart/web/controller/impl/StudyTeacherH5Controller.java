package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.constant.enumEntity.CourseStudentStatusEnum;
import cn.com.smart.constant.enumEntity.SystemMessageEnum;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.CourseSearch;
import cn.com.smart.web.bean.search.CourseStudentRecordSearch;
import cn.com.smart.web.constant.enums.IconType;
import cn.com.smart.web.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/studyTeacherH5")
public class StudyTeacherH5Controller {

    private final String pathDir = "h5/teacher/";

    @Autowired
    private StudySystemMessageService systemMessageService;
    @Autowired
    private StudyCourseRecordService courseRecordService;

    @RequestMapping(value = "/index")
    public ModelAndView index(String phone) {
        ModelAndView modelView = new ModelAndView();

        TGStudyTeacher teacher = this.getTeacherByPhone(phone);
        if(null == teacher) {
            modelView.setViewName(this.pathDir + "unBind");
            return modelView;
        }

        Map<String, Object> params = new HashMap<>();
        params.put("status", IConstant.STATUS_NORMAL);
        params.put("teacherId", teacher.getId());
        List<TGStudyCourseRecord> courseRecordList = courseRecordService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseRecordList)) {
            List<TGStudyCourseRecord> unSignedCourseRecordList = new ArrayList<>();
            Date curDate = new Date();
            Date courseDate;
            for(TGStudyCourseRecord courseRecord : courseRecordList) {
                courseDate = this.parseCourseDate(courseRecord);
                if(null != courseDate && courseDate.before(curDate)) {
                    // 课时已结束当未结课的课时
                    unSignedCourseRecordList.add(courseRecord);
                }
            }
            Collections.sort(unSignedCourseRecordList);
            modelView.getModelMap().put("courseRecordList", unSignedCourseRecordList);
        }

        modelView.setViewName(this.pathDir + "studentSign");
        return modelView;
    }

    @Autowired
    private StudyTeacherService teacherService;

    private TGStudyTeacher getTeacherByPhone(String phone) {
        Map<String, Object> params = new HashMap<>();
        params.put("status", IConstant.STATUS_NORMAL);
        params.put("phone", phone);
        List<TGStudyTeacher> teacherList = this.teacherService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(teacherList)) {
            return teacherList.get(0);
        }
        return null;
    }

    private Date parseCourseDate(TGStudyCourseRecord courseRecord) {
        String courseEndTime = courseRecord.getCourseTime().substring(courseRecord.getCourseTime().indexOf('-') + 1);
        return DateUtil.parseDate(courseRecord.getCourseDate() + " " + courseEndTime, "yyyy-MM-dd HH:mm");
    }

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

    @RequestMapping(value = "/queryStudent")
    @ResponseBody
    public SmartResponse<TGStudyCourseStudentRecord> queryStudent(String courseRecordId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseRecordId", courseRecordId);
        params.put("status", this.courseStudentRecordService.getQueryStatus().toArray());
        return courseStudentRecordService.findByParam(params);
    }

    @RequestMapping(value = "/queryCourseRecord")
    @ResponseBody
    public SmartResponse<TGStudyCourseRecord> queryCourseRecord(String courseRecordId) {
        return courseRecordService.find(courseRecordId);
    }

    @Autowired
    private StudyStudentService studentService;

    @RequestMapping(value = "/subStudentSign")
    @ResponseBody
    public SmartResponse<String> subStudentSign(String courseRecordId, String studentId, String status) {
        SmartResponse<String> smartResponse = new SmartResponse<>();

        CourseStudentStatusEnum statusEnum = CourseStudentStatusEnum.valueOf(status);
        if (StringUtils.isBlank(courseRecordId) ||
                StringUtils.isBlank(studentId) || CourseStudentStatusEnum.NORMAL == statusEnum) {
            smartResponse.setMsg("请求参数无效!");
            return smartResponse;
        }

        Map<String, Object> params = new HashMap<>();
        params.put("courseRecordId", courseRecordId);
        params.put("studentId", studentId);
        params.put("status", CourseStudentStatusEnum.NORMAL.name());
        List<TGStudyCourseStudentRecord> courseStudentRecordList = this.courseStudentRecordService.findByParam(params).getDatas();
        if(CollectionUtils.isEmpty(courseStudentRecordList)) {
            smartResponse.setMsg("未找到可进行签到的课时记录!");
            return smartResponse;
        }
        if(courseStudentRecordList.size() > 1) {
            smartResponse.setMsg("学生课时数据异常");
            return smartResponse;
        }
        TGStudyCourseStudentRecord courseStudentRecord = courseStudentRecordList.get(0);
        TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseStudentRecord.getCourseRecordId()).getData();
        if(null == courseRecord || !courseRecord.canSign()) {
            smartResponse.setMsg("课时数据异常");
            return smartResponse;
        }

        // 更新学生课时的签到信息
        courseStudentRecord.setStatus(statusEnum.name());
        courseStudentRecord.setUpdateTime(new Date());
        final SmartResponse<String> updateSmartResponse = this.courseStudentRecordService.update(courseStudentRecord);
        if (!updateSmartResponse.isSuccess()) {
            smartResponse.setMsg("学生课时更新失败!");
            return smartResponse;
        }

        // 学生课时-1
        TGStudyStudent student = this.studentService.find(courseStudentRecord.getStudentId()).getData();
        student.setRemainCourse(student.getRemainCourse() - 1);
        student.setUpdateTime(new Date());
        if (CourseStudentStatusEnum.SIGNED.equals(statusEnum)) {
            student.setCourseSeriesUnSigned(0);
        } else {
            // 非正常签到,生成异常签到记录
            student.setCourseSeriesUnSigned(student.getCourseSeriesUnSigned() + 1);
        }
        this.studentService.update(student);

        if (student.getCourseSeriesUnSigned() >= 3) {
            // 连续未签到,系统提示
            String content = "学生[" + student.getName() + "]已连续 " + student.getCourseSeriesUnSigned() + "次缺席!";
            this.systemMessageService.broadSystemMessage(SystemMessageEnum.STUDENT_ABSENT_NOTE, content);
        }
        if (student.getRemainCourse() < 3) {
            // 课时不足
            String content = "学生[" + student.getName() + "]仅剩余 " + student.getRemainCourse() + "课时!";
            this.systemMessageService.broadSystemMessage(SystemMessageEnum.STUDENT_REMAIN_COURSE_NOTE, content);
        }

        // 检查课时的学生列表是否已经全部签到
        params = new HashMap<>();
        params.put("courseRecordId", courseRecordId);
        params.put("status", this.courseStudentRecordService.getQueryStatus().toArray());
        this.courseRecordService.updateCourseRecordToEndIfAllSigned(courseRecordId, this.courseStudentRecordService.findByParam(params).getDatas());

        smartResponse.setResult(IConstant.OP_SUCCESS);
        smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
        return smartResponse;
    }

}
