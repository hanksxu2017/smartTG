package cn.com.smart.web.service;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.constant.enums.tg.CourseStudentRecordStatusEnum;
import cn.com.smart.web.constant.enums.tg.StudentCourseSignTypeEnum;
import cn.com.smart.web.constant.enums.tg.SystemMessageEnum;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.entity.TGStudyCourseStudentRecord;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.entity.TGStudyStudentCourseRel;
import cn.com.smart.web.utils.DataUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * 课时签到服务
 */
@Service
public class StudyCourseRecordSignService {

	/**
	 * 提交学生点名</br>
	 * 执行失败时,抛出运行时异常
	 * @param courseRecordId    课时编号
	 * @param studentIdList     学生编号列表
	 * @param statusEnum        点名结果
	 * @param description       描述信息
	 * @return                  执行结果
	 */
    public SmartResponse<String> subStudentSign(String courseRecordId,
                                                List<String> studentIdList,
                                                CourseStudentRecordStatusEnum statusEnum,
                                                String description) throws Exception{
	    SmartResponse<String> smartResponse = new SmartResponse<>();

	    for(String studentId : studentIdList) {
			smartResponse = this.doStudentSign(courseRecordId, studentId, statusEnum, description);
			if(!smartResponse.isSuccess()) {
				throw new RuntimeException("学生点名处理失败:" + smartResponse.getMsg());
			}
		}
	    return smartResponse;

    }

	/**
	 * 提交学生点名<br>
	 * 执行失败时,抛出运行时异常
	 * @param courseRecordId    课时编号
	 * @param studentId         学生编号
	 * @param statusEnum        点名结果
	 * @param description       描述信息
	 * @return                  执行结果
	 */
	public SmartResponse<String> subStudentSign(String courseRecordId,
	                                             String studentId,
	                                             CourseStudentRecordStatusEnum statusEnum,
	                                             String description) throws Exception{
		SmartResponse<String> smartResponse = this.doStudentSign(courseRecordId, studentId, statusEnum, description);
		if(!smartResponse.isSuccess()) {
			throw new RuntimeException("学生点名处理失败:" + smartResponse.getMsg());
		}
		return smartResponse;
	}

    /**
     * 提交学生的点名结果</br>
     * 执行顺序不得错乱
     * @param courseRecordId    课时编号
     * @param studentId         学生编号
     * @param statusEnum        点名状态
     * @param description       备注
     * @return                  执行结果
     */
    private SmartResponse<String> doStudentSign(String courseRecordId,
                                                      String studentId,
                                                      CourseStudentRecordStatusEnum statusEnum,
                                                String description) {
        SmartResponse<String> smartResponse = new SmartResponse<>();
        if(StringUtils.isBlank(courseRecordId) || StringUtils.isBlank(studentId) || null == statusEnum) {
            smartResponse.setMsg("参数无效");
            return smartResponse;
        }

        // 1. 课时检查
        SmartResponse<TGStudyCourseRecord> checkCourseRecordRes = this.checkCourseRecord(courseRecordId);
        if(!checkCourseRecordRes.isSuccess()) {
            smartResponse.setMsg(checkCourseRecordRes.getMsg());
            return smartResponse;
        }
	    TGStudyCourseRecord courseRecord = checkCourseRecordRes.getData();

        // 2. 学生检查
        SmartResponse<TGStudyStudent> checkStudentRes = this.checkStudent(studentId);
        if(!checkStudentRes.isSuccess()) {
            smartResponse.setMsg(checkStudentRes.getMsg());
            return smartResponse;
        }
	    TGStudyStudent student = checkStudentRes.getData();

        // 3. 学生课时检查
        SmartResponse<TGStudyCourseStudentRecord> checkCourseStudentRecordRes = this.checkCourseStudentRecord(studentId, courseRecordId);
        if(!checkCourseStudentRecordRes.isSuccess()) {
            smartResponse.setMsg(checkCourseStudentRecordRes.getMsg());
            return smartResponse;
        }
        TGStudyCourseStudentRecord courseStudentRecord = checkCourseStudentRecordRes.getData();

	    // 4. 更新学生信息(剩余课时,连续缺课)
	    smartResponse = this.updateStudent(student, courseStudentRecord, statusEnum);
	    if(!smartResponse.isSuccess()) {
		    return smartResponse;
	    }

        // 5. 更新学生课时为点名结果
        smartResponse = this.updateCourseStudentRecord(courseStudentRecord, statusEnum, description);
        if(!smartResponse.isSuccess()) {
            return smartResponse;
        }

        // 6. 检查所有课时是否全部操作完毕
        this.checkIfAllSign(courseStudentRecord);

        smartResponse.setResult(IConstant.OP_SUCCESS);
        smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
        return smartResponse;
    }

    @Autowired
    private StudyCourseRecordService courseRecordService;

    /**
     * 检查课时是否可以进行点名操作
     * @param courseRecordId    课时编号
     * @return                  检查结果,成功时携带课时对象
     */
    private SmartResponse<TGStudyCourseRecord> checkCourseRecord(String courseRecordId) {
        SmartResponse<TGStudyCourseRecord> smartResponse = this.courseRecordService.find(courseRecordId);
        if(smartResponse.isSuccess()) {
            TGStudyCourseRecord courseRecord = smartResponse.getData();
            if(null == courseRecord) {
                smartResponse.setResult(IConstant.OP_FAIL);
                smartResponse.setMsg("课时[" + courseRecordId + "]不存在");
                return smartResponse;
            }
            if(!courseRecord.canSign()) {
                smartResponse.setResult(IConstant.OP_FAIL);
                smartResponse.setMsg("课时[" + courseRecord.getCourseName() + "]不可进行点名操作");
                return smartResponse;
            }
        }
        return smartResponse;
    }

    @Autowired
    private StudyStudentService studentService;

    /**
     * 检查学生是否可以进行点名操作
     * @param studentId 学生编号
     * @return          检查结果,成功时携带学生对象
     */
    private SmartResponse<TGStudyStudent> checkStudent(String studentId) {
        SmartResponse<TGStudyStudent> smartResponse = this.studentService.find(studentId);
        if(smartResponse.isSuccess()) {
            TGStudyStudent student = smartResponse.getData();
            if(null == student) {
                smartResponse.setResult(IConstant.OP_FAIL);
                smartResponse.setMsg("学生[" + studentId + "]不存在");
                return smartResponse;
            }
            if(!StringUtils.equals(student.getStatus(), IConstant.STATUS_NORMAL)) {
                smartResponse.setResult(IConstant.OP_FAIL);
                smartResponse.setMsg("学生[" + student.getName() + "]无法进行点名操作");
                return smartResponse;
            }
        }

        return smartResponse;
    }

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

    private SmartResponse<TGStudyCourseStudentRecord> checkCourseStudentRecord(String studentId, String courseRecordId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseRecordId", courseRecordId);
        params.put("studentId", studentId);
        SmartResponse<TGStudyCourseStudentRecord> res = this.courseStudentRecordService.findByParam(params);
        if(res.isSuccess()) {
            if(CollectionUtils.isEmpty(res.getDatas()) || 1 != res.getDatas().size()) {
                res.setResult(IConstant.OP_FAIL);
                res.setMsg("数据异常");
                return res;
            }
            TGStudyCourseStudentRecord courseStudentRecord = res.getDatas().get(0);
            if(StringUtils.equals(IConstant.SIGNED_TYPE_MAKEUP, courseStudentRecord.getSignType())) {
                res.setResult(IConstant.OP_FAIL);
                res.setMsg("补课签到类型不可修改");
                return res;
            }
            res.setData(courseStudentRecord);
        }
        return res;
    }

    /**
     * 更新学生的课时信息
     * @param courseStudentRecord   学生课时信息
     * @param statusEnum            点名结果
     * @param description           备注
     * @return                      更新结果
     */
    private SmartResponse<String> updateCourseStudentRecord(TGStudyCourseStudentRecord courseStudentRecord,
        CourseStudentRecordStatusEnum statusEnum, String description) {

	    TGStudyCourseStudentRecord preMakeUpRecord = this.getPreMakeUpRecord(courseStudentRecord.getStudentId());

    	if(!CourseStudentRecordStatusEnum.SIGNED.equals(statusEnum) && null != preMakeUpRecord) {

			// 学生存在预补课
		    // 当前课时设置为签到
		    courseStudentRecord.setStatus(CourseStudentRecordStatusEnum.SIGNED.name());
		    courseStudentRecord.setSignType(IConstant.SIGNED_TYPE_PRE_MAKEUP);

		    // 预补课设置为已处理
		    preMakeUpRecord.setIsProcess(IConstant.IS_PROCESS_YES);
		    preMakeUpRecord.setMakeUpTargetId(courseStudentRecord.getId());
		    this.courseStudentRecordService.update(preMakeUpRecord);
	    } else {
		    // 更新学生课时的签到信息
		    courseStudentRecord.setStatus(statusEnum.name());
	    }

        courseStudentRecord.setDescription(DataUtil.handleNull(description));
        courseStudentRecord.setUpdateTime(new Date());
        courseStudentRecord.setIsProcess(IConstant.IS_PROCESS_YES);
        return this.courseStudentRecordService.update(courseStudentRecord);
    }

    @Autowired
    private StudySystemMessageService systemMessageService;

    /**
     * 更新学生的课时点名信息
     * @param student               学生信息
     * @param courseStudentRecord   学生的课时信息
     * @param statusEnum            点名结果
     * @return                      更新结果
     */
    private SmartResponse<String> updateStudent(TGStudyStudent student,
                                                TGStudyCourseStudentRecord courseStudentRecord,
                                                CourseStudentRecordStatusEnum statusEnum) {
    	// 第一次签到
        boolean isFirstSign = StringUtils.equals(courseStudentRecord.getIsProcess(), IConstant.IS_PROCESS_NO);
        student.setUpdateTime(new Date());

        if (CourseStudentRecordStatusEnum.SIGNED.equals(statusEnum)) {
            // 学生课时-1
            if(isFirstSign) {
                student.setRemainCourse(student.getRemainCourse() - 1);
            }
            student.setCourseSeriesUnSigned(0);
            this.systemMessageService.processSystemMessageBySystem(SystemMessageEnum.STUDENT_ABSENT_NOTE, student.getId());
        } else {
            if (!isSignAsHasCome(student.getId(), courseStudentRecord.getCourseId())) {
            	// 对于正常签到类型,需要处理签退
            	if(isFirstSign) {
					// 第一次点名操作
		            TGStudyCourseStudentRecord preMakeUpRecord = this.getPreMakeUpRecord(student.getId());
		            if(null != preMakeUpRecord) {
			            // 已存在预补课,本次签退不进行课时扣除，连续签退处理
		            } else {
			            student.setRemainCourse(student.getRemainCourse() - 1);
			            // 非正常签到,生成异常签到记录
			            student.setCourseSeriesUnSigned(student.getCourseSeriesUnSigned() + 1);
		            }
	            }
            }
        }
        SmartResponse<String> smartResponse = this.studentService.update(student);

        if (student.getCourseSeriesUnSigned() >= IConstant.NOTIFY_COURSE_SERIES_UNSIGNED) {
            // 连续未签到,系统提示
            String content = "学生[" + student.getName() + "]已连续 " + student.getCourseSeriesUnSigned() + "次缺席!";
            this.systemMessageService.broadSystemMessage(SystemMessageEnum.STUDENT_ABSENT_NOTE, content, student.getId());
        }
        if (student.getRemainCourse() <= IConstant.NOTIFY_COURSE_RENEW) {
            // 课时不足
            String content = "学生[" + student.getName() + "]仅剩余 " + student.getRemainCourse() + "课时!";
            this.systemMessageService.broadSystemMessage(SystemMessageEnum.STUDENT_REMAIN_COURSE_NOTE, content, student.getId());
        }

        return smartResponse;
    }

	/**
	 * 查看学生是否存在预习补课的情况
	 * @param studentId
	 * @return
	 */
	private TGStudyCourseStudentRecord getPreMakeUpRecord(String studentId) {

		Map<String, Object> map = new HashMap<>();
		map.put("studentId", studentId);
		map.put("status", CourseStudentRecordStatusEnum.Y_PRE_MAKE_UP.name());
		List<TGStudyCourseStudentRecord> courseStudentRecordList = this.courseStudentRecordService.findByParam(map, "create_time").getDatas();
		if(CollectionUtils.isNotEmpty(courseStudentRecordList)) {
			for(TGStudyCourseStudentRecord courseStudentRecord : courseStudentRecordList) {
				if(StringUtils.equals(IConstant.IS_PROCESS_NO, courseStudentRecord.getIsProcess())) {
					return courseStudentRecord;
				}
			}
		}

    	return null;
    }

    @Autowired
    private StudyStudentCourseRelService studentCourseRelService;

    /**
     * 判断学生课时的签到类型是否为到班签到
     *
     * @param studentId 学生编号
     * @param courseId  课时编号
     * @return 到班签到时返回true, 否则返回false
     */
    private boolean isSignAsHasCome(String studentId, String courseId) {
        Map<String, Object> params = new HashMap<>();
        params.put("studentId", studentId);
        params.put("courseId", courseId);
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyStudentCourseRel> studentCourseRelList = this.studentCourseRelService.findByParam(params).getDatas();
        if (CollectionUtils.isNotEmpty(studentCourseRelList)) {
            return StringUtils.equals(StudentCourseSignTypeEnum.SIGN_AS_HAS.name(), studentCourseRelList.get(0).getSignType());
        }
        return false;
    }

    /**
     * 检查课时的所有学生是否已经全部签到
     * @param courseStudentRecord   学生课时信息
     */
    private void checkIfAllSign(TGStudyCourseStudentRecord courseStudentRecord) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseRecordId", courseStudentRecord.getCourseRecordId());
        params.put("status", getQueryStatus().toArray());
        this.courseRecordService.updateCourseRecordToEndIfAllSigned(courseStudentRecord.getCourseRecordId(),
                this.courseStudentRecordService.findByParam(params).getDatas());

    }

	public List<String> getQueryStatus() {
		List<String> statusList = new ArrayList<>();
		for(CourseStudentRecordStatusEnum statusEnum : CourseStudentRecordStatusEnum.values()) {
			if(!CourseStudentRecordStatusEnum.X_MAKE_UP.equals(statusEnum)) {
				statusList.add(statusEnum.name());
			}
		}
		return statusList;
	}

}
