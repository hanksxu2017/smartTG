package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudyCourseService;
import cn.com.smart.web.service.StudyTeacherService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/studyCourse")
public class StudyCourseController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyCourseService courseService;

    public StudyCourseController() {
        super.setSubDir("/studyCourse/");
    }

    @RequestMapping("/index")
    public ModelAndView index(ModelAndView modelView) throws Exception {
        modelView.setViewName(this.getPageDir() + "/index");
        return modelView;
    }

    @RequestMapping("/studentHas")
    public ModelAndView roleHas(ModelAndView modelView,String id) throws Exception {
        if(StringUtils.isNotEmpty(id)) {
            SmartResponse<Object> smartResp = this.opService.find(TGStudyStudent.class, id);
            ModelMap modelMap = modelView.getModelMap();
            modelMap.put("id", id);
            if(smartResp.getResult().equals(OP_SUCCESS)) {
                TGStudyStudent student = (TGStudyStudent) smartResp.getData();
                String name = (null != student)?student.getName():null;
                modelMap.put("name", name);
            }
        }
        modelView.setViewName(this.getPageDir() + "studentHas");
        return modelView;
    }

    @RequestMapping("/teacherHas")
    public ModelAndView teacherHas(ModelAndView modelView,String id) throws Exception {
        if(StringUtils.isNotEmpty(id)) {
            SmartResponse<Object> smartResp = this.opService.find(TGStudyTeacher.class, id);
            ModelMap modelMap = modelView.getModelMap();
            modelMap.put("id", id);
            if(smartResp.getResult().equals(OP_SUCCESS)) {
                TGStudyTeacher teacher = (TGStudyTeacher) smartResp.getData();
                String name = (null != teacher)?teacher.getName():null;
                modelMap.put("name", name);
            }
        }
        modelView.setViewName(this.getPageDir() + "teacherHas");
        return modelView;
    }

    @RequestMapping(value = "/queryCourse", method = RequestMethod.GET)
    @ResponseBody
    public SmartResponse<TGStudyCourse> queryCourse(String teacherId, Short weekInfo, String courseId) {
        Map<String, Object> params = new HashMap<>();
        if(StringUtils.isNotBlank(teacherId)) {
            params.put("teacherId", teacherId);
        }
        if(null != weekInfo) {
            params.put("weekInfo", weekInfo);
        }
        if(StringUtils.isNotBlank(courseId)) {
            params.put("id", courseId);
        }
        SmartResponse<TGStudyCourse> smartResp = this.courseService.findByParam(params, "weekInfo");
        return smartResp;
    }

    @RequestMapping(value = "/queryWeeks", method = RequestMethod.GET)
    @ResponseBody
    public SmartResponse<Object> queryWeeks(String teacherId) {
        Map<String, Object> params = new HashMap<>();
        if(StringUtils.isNotBlank(teacherId)) {
            params.put("teacherId", teacherId);
        }
        SmartResponse<Object> weeks = this.opService.getDatas("teacher_course_weeks", params);

        return weeks;
    }

    /**
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/saveCourse",method=RequestMethod.POST)
    public @ResponseBody SmartResponse<String> saveCourse(TGStudyCourse course) throws Exception {
        SmartResponse<String> smartResp = new SmartResponse<String>();
        String checkRes = this.checkCourseConflict(course);
        if(StringUtils.isNotBlank(checkRes)) {
            smartResp.setMsg(checkRes);
            return smartResp;
        }

        course.setCreateTime(new Date());
        this.packTeacherInfo(course);

        smartResp = this.courseService.save(course);
        // 老师课时增加成功后,进行本周内的时安排
        // TODO
        return smartResp;
    }

    /**
     * 检查课程安排是否存在冲突
     * @param course
     * @return
     */
    private String checkCourseConflict(TGStudyCourse course) {
        String checkRes = this.checkTeacherCourse(course.getCourseTime(), course.getWeekInfo(), course.getTeacherId());
        if(StringUtils.isNotBlank(checkRes)) {
            return checkRes;
        }
        checkRes = this.checkClassroom(course.getCourseTime(), course.getWeekInfo(), course.getClassroomId());
        if(StringUtils.isNotBlank(checkRes)) {
            return checkRes;
        }
        return "";
    }

    private String checkTeacherCourse(String courseTime, short weekInfo, String teacherId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseTime", courseTime);
        params.put("weekInfo", weekInfo);
        params.put("teacherId", teacherId);
        SmartResponse<TGStudyCourse> courseSmartResponse = this.courseService.findByParam(params);
        if(courseSmartResponse.isSuccess() && courseSmartResponse.getTotalNum() > 0) {
            return "课程冲突:同时间点,教师存在其他课程";
        }
        return "";
    }

    private String checkClassroom(String courseTime, short weekInfo, String classroomId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseTime", courseTime);
        params.put("weekInfo", weekInfo);
        params.put("classroomId", classroomId);
        SmartResponse<TGStudyCourse> courseSmartResponse = this.courseService.findByParam(params);
        if(courseSmartResponse.isSuccess() && courseSmartResponse.getTotalNum() > 0) {
            return "课程冲突:同时间点,教室已被其他课程占用.";
        }
        return "";
    }


    @Autowired
    private StudyTeacherService teacherService;

    private void packTeacherInfo(TGStudyCourse course) {
        TGStudyTeacher teacher = this.teacherService.find(course.getTeacherId()).getData();
        if(null != teacher) {
            course.setTeacherName(teacher.getName());
        }
    }


}
