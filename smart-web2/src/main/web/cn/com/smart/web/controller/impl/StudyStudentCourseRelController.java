package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.StudentCourseRelSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.filter.bean.UserSearchParam;
import cn.com.smart.web.service.*;
import cn.com.smart.web.tag.bean.EditBtn;
import cn.com.smart.web.tag.bean.PageParam;
import cn.com.smart.web.tag.bean.RefreshBtn;
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
            generateCurWeekCourseRecIfNecessary(studentCourseRel);
        }
        return smartResp;
    }

    @Autowired
    private StudyCourseRecordService courseRecordService;

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

    private void generateCurWeekCourseRecIfNecessary(TGStudyStudentCourseRel studentCourseRel) {
        TGStudyCourse course = this.courseService.find(studentCourseRel.getCourseId()).getData();
        Date curDate = new Date();
        int curWeek = DateUtil.getWeek(curDate);
        if(0 == curWeek) {
            curWeek = 7;
        }

        Date courseDate = null;
        if(course.getWeekInfo() > curWeek) {
            courseDate = DateUtil.addDay(curDate, course.getWeekInfo() - curWeek);
        }
        if(course.getWeekInfo() == curWeek) {
            // 又是同一天,下次说吧,或者增加该项功能
        }
        if(null != courseDate) {
            // 需要生成本周内的学生课时记录对象
            String courseDateStr = DateUtil.dateToStr(courseDate, "yyyy-MM-dd");
            Map<String, Object> params = new HashMap<>();
            params.put("courseDate", courseDateStr);
            params.put("courseId", studentCourseRel.getCourseId());
            SmartResponse<TGStudyCourseRecord> smartResponse = this.courseRecordService.findByParam(params);
            if(smartResponse.isSuccess()) {
	            TGStudyCourseRecord courseRecord = smartResponse.getDatas().get(0);
	            if(null != courseRecord) {
		            this.courseStudentRecordService.save(this.initCourseStudentRecord(courseRecord, studentCourseRel.getStudentId()));
	            }
            }
        }
    }

    /**
     * 初始化学生的每日课时记录
     * @param courseRecord  每日课时记录对象
     * @param studentId     学生编号
     * @return              学生每日课时记录对象
     */
    private TGStudyCourseStudentRecord initCourseStudentRecord(TGStudyCourseRecord courseRecord, String studentId) {
        TGStudyCourseStudentRecord courseStudentRecord = new TGStudyCourseStudentRecord();
        courseStudentRecord.setCourseRecordId(courseRecord.getId());
        courseStudentRecord.setCourseId(courseRecord.getCourseId());

        TGStudyStudent student = this.studentService.find(studentId).getData();
        courseStudentRecord.setStudentId(student.getId());
        courseStudentRecord.setStudentName(student.getName());

        courseStudentRecord.setCreateTime(new Date());

        return courseStudentRecord;
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
