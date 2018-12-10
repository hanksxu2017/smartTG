package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.constant.enumEntity.CourseStudentRecordStatusEnum;
import cn.com.smart.constant.enumEntity.SystemMessageEnum;
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

        smartResponse.setResult(IConstant.OP_SUCCESS);
        smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
        return smartResponse;
    }

}
