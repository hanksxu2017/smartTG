package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.entity.TGStudyStudentCourseRel;
import cn.com.smart.web.bean.search.StudentCourseRelSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 分班信息管理
 */
@Controller
@RequestMapping("/studyStudent/course")
public class StudyStudentCourseRelController extends BaseController {

    @Autowired
    private OPService opService;

    @Autowired
    private StudyStudentCourseRelService studentCourseRelService;
    @Autowired
    private StudyTeacherService teacherService;

    public StudyStudentCourseRelController() {
        super.setSubDir("/studyStudent/course/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(StudentCourseRelSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_course_rel_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelAndView = this.packListModelView(searchParam, smartResp);
        return modelAndView;
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method= RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> delete(String id) {
        SmartResponse<String> smartResp = new SmartResponse<String>();
        if(StringUtils.isNotEmpty(id)) {
            smartResp = studentCourseRelService.delete(id);
        }
        return smartResp;
    }


    /**
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/subReportCourse",method=RequestMethod.POST)
    public @ResponseBody SmartResponse<String> saveClass(String courseId, String studentId) throws Exception {
        SmartResponse<String> smartResp = new SmartResponse<String>();
        String checkRes = this.checkStudentCourseConflict(courseId, studentId);
        if(StringUtils.isNotBlank(checkRes)) {
            smartResp.setResult(IConstant.OP_FAIL);
            smartResp.setMsg(checkRes);
        } else {
            TGStudyStudentCourseRel studentCourseRel = this.initStudentCourseRel(courseId, studentId);
            smartResp = this.studentCourseRelService.save(studentCourseRel);
            // 学生报课成功后续进行本周类的课时安排
            // TODO
        }
        return smartResp;
    }

    @Autowired
    private StudyStudentService studentService;

    @Autowired
    private StudyCourseService courseService;

    /**
     *
     * @param courseId
     * @param studentId
     * @return
     */
    private String checkStudentCourseConflict(String courseId, String studentId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseId", courseId);
        params.put("studentId", studentId);
        params.put("status", IConstant.STATUS_NORMAL);
        SmartResponse<TGStudyStudentCourseRel> smartResponse = this.studentCourseRelService.findByParam(params);
        if(smartResponse.isSuccess() && smartResponse.getTotalNum() > 0) {
            return "课时冲突,请重新选择";
        }
        return "";
    }

    private TGStudyStudentCourseRel initStudentCourseRel(String courseId, String studentId) {

        TGStudyStudentCourseRel rel = new TGStudyStudentCourseRel();

        TGStudyStudent student = this.studentService.find(studentId).getData();
        TGStudyCourse course = this.courseService.find(courseId).getData();

        rel.setCourseId(courseId);
        rel.setCourseName(course.getName());
        rel.setCourseWeekInfo(course.getWeekInfo());
        rel.setCourseTime(course.getCourseTime());
        rel.setClassroomId(course.getClassroomId());
        rel.setClassroomName(course.getClassroomName());
        rel.setTeacherId(course.getTeacherId());
        rel.setTeacherName(course.getTeacherName());

        rel.setStudentId(studentId);
        rel.setStudentName(student.getName());

        rel.setCreateTime(new Date());

        return rel;
    }

}
