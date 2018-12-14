package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.constant.enums.tg.CourseStudentRecordStatusEnum;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/studyTeacherH5")
public class StudyTeacherH5Controller {

    private final String pathDir = "h5/teacher/";

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

	    modelView.getModelMap().put("courseRecordList", this.findCourseRecordAtToday(teacher));

        modelView.setViewName(this.pathDir + "studentSign");
        return modelView;
    }

	/**
	 * 查找教师在今日的所有课时
	 * @param teacher
	 * @return
	 */
	private List<TGStudyCourseRecord> findCourseRecordAtToday(TGStudyTeacher teacher) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("status", IConstant.STATUS_NORMAL);
	    params.put("teacherId", teacher.getId());
	    params.put("courseDate", DateUtil.dateToStr(new Date(), "yyyy-MM-dd"));
	    List<TGStudyCourseRecord> courseRecordList = courseRecordService.findByParam(params).getDatas();
	    if(CollectionUtils.isNotEmpty(courseRecordList)) {
		    Collections.sort(courseRecordList);
	    }
	    return courseRecordList;
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

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

    @RequestMapping(value = "/queryStudent")
    @ResponseBody
    public SmartResponse<TGStudyCourseStudentRecord> queryStudent(String courseRecordId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseRecordId", courseRecordId);
        params.put("status", this.courseStudentRecordService.getQueryStatus().toArray());
	    SmartResponse<TGStudyCourseStudentRecord> smartResponse = courseStudentRecordService.findByParam(params);

	    TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseRecordId).getData();
	    if(null != courseRecord && !courseRecord.canSign()) {
		    smartResponse.setSize(-1);
	    }

	    return smartResponse;
    }

    @RequestMapping(value = "/queryCourseRecord")
    @ResponseBody
    public SmartResponse<TGStudyCourseRecord> queryCourseRecord(String courseRecordId) {
        return courseRecordService.find(courseRecordId);
    }


    @Autowired
    private StudyCourseRecordSignService courseRecordSignService;

    @RequestMapping(value = "/subStudentSign")
    @ResponseBody
    public SmartResponse<String> subStudentSign(String courseRecordId, String studentId, String status) {
        SmartResponse<String> smartResponse = new SmartResponse<>();

        CourseStudentRecordStatusEnum statusEnum = this.parseStatus(status);
        if(StringUtils.isBlank(courseRecordId) || StringUtils.isBlank(studentId) ||
                null == statusEnum) {
            smartResponse.setMsg("请求无效");
            return smartResponse;
        }

        smartResponse = this.courseRecordSignService.subStudentSign(courseRecordId, studentId, statusEnum);

        return smartResponse;
    }

    private CourseStudentRecordStatusEnum parseStatus(String status) {
        if(StringUtils.equals(status, "signed")) {
            return CourseStudentRecordStatusEnum.SIGNED;
        } else if (StringUtils.equals(status, "leave")) {
            return CourseStudentRecordStatusEnum.PERSONAL_LEAVE;
        } else if (StringUtils.equals(status, "truant")) {
            return CourseStudentRecordStatusEnum.PLAY_TRUANT;
        }
        return null;
    }

}
