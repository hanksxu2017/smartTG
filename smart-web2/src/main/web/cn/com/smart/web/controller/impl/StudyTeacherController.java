package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.StudentCourseRelSearch;
import cn.com.smart.web.bean.search.TeacherCourseSearch;
import cn.com.smart.web.bean.search.TeacherSearch;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.constant.enums.SelectedEventType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.filter.bean.UserSearchParam;
import cn.com.smart.web.service.*;
import cn.com.smart.web.tag.bean.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import javax.swing.*;
import java.util.*;

@Controller
@RequestMapping("/studyTeacher")
public class StudyTeacherController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyTeacherService teacherService;

    public StudyTeacherController() {
        super.setSubDir("/studyTeacher/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(TeacherSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_teacher_list", searchParam, page.getStartNum(), page.getPageSize());
        return this.packListModelView(searchParam, smartResp);
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getPageDir() + "add");
        return modelView;
    }

    /**
     * 提交新增
     *
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> save(TGStudyTeacher studyTeacher) {
        studyTeacher.setCreateTime(new Date());
        SmartResponse<String> smartResp = teacherService.save(studyTeacher);
        return smartResp;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotEmpty(id)) {
            TGStudyTeacher studyTeacher = teacherService.find(id).getData();
            if(null != studyTeacher) {
                modelView.getModelMap().put("objBean", studyTeacher);
            }
        }
        modelView.setViewName(getPageDir() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studyTeacher
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyTeacher studyTeacher) {
        TGStudyTeacher studyTeacherDb = this.teacherService.find(studyTeacher.getId()).getData();
        studyTeacher.setCreateTime(studyTeacherDb.getCreateTime());
        studyTeacher.setUpdateTime(new Date());
        SmartResponse<String> smartResp = teacherService.update(studyTeacher);
        return smartResp;
    }

    /**
     * 简单列表
     * @return
     * @throws Exception
     */
    @RequestMapping("/simpList")
    public ModelAndView simpList(HttpSession session, UserSearchParam searchParam,
                                 ModelAndView modelView, RequestPage page) throws Exception {
        String uri = this.getUriPath() + "simpList";
        SmartResponse<Object> smartResp = this.opService.getDatas("teacher_simp_list",searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, "#teacher-tab", page.getPage(), page.getPageSize());
        selectedEventProp = new SelectedEventProp(SelectedEventType.OPEN_TO_TARGET.getValue(),"studyCourse/teacherHas","#has-class-list","id");

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);
        modelMap.put("selectedEventProp", selectedEventProp);
        pageParam = null;

        modelView.setViewName(this.getPageDir() + "simpList");
        return modelView;
    }

    /**
     * 该教师拥有的课时信息
     * @return
     * @throws Exception
     */
    @RequestMapping("/courseList")
    public ModelAndView classList(TeacherCourseSearch searchParam, ModelAndView modelView, RequestPage page) throws Exception {
        String uri = this.getUriPath() + "courseList" + "?id=" + searchParam.getId();;
        SmartResponse<Object> smartResp = this.opService.getDatas("teacher_course_list", searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, null, page.getPage(), page.getPageSize());
        addBtn = new EditBtn("add",this.getUriPath() + "addCourse?teacherId=" + searchParam.getId(), "教师增设课时", "800");
	    editBtn = new EditBtn("edit",this.getUriPath() + "editCourse", "班级修改", "800");
		editBtn.setSelectedType(BtnPropType.SelectType.ONE.getValue());
        refreshBtn = new RefreshBtn(uri, null,"#teacher-course-tab");

	    delBtn = new DelBtn(this.getUriPath() + "deleteCourse", "确定删除班级吗？", uri, "#teacher-course-tab", null);

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);
        modelMap.put("addBtn", addBtn);
        modelMap.put("editBtn", editBtn);
        modelMap.put("refreshBtn", refreshBtn);
        modelMap.put("delBtn", delBtn);
        pageParam = null;

	    CustomBtn customBtnStudentList = new CustomBtn("studentList", "学生列表",
			    "学生列表", this.getUriPath() + "studentList","glyphicon-list-alt", BtnPropType.SelectType.ONE.getValue());
	    customBtnStudentList.setWidth("600");
	    customBtnStudentList.setModalBodyId("course-student-list-dialog");

	    customBtns = new ArrayList<>(2);
	    customBtns.add(customBtnStudentList);
	    modelMap.put("customBtns", customBtns);


        modelView.setViewName(this.getPageDir() + "courseList");
        return modelView;
    }

    @Autowired
    private StudyCourseService courseService;
    @Autowired
    private StudyClassroomService classroomService;

	@RequestMapping(value = "/editCourse")
	public ModelAndView editCourse(String id) {
		ModelAndView modelView = new ModelAndView();
		if(StringUtils.isNotEmpty(id)) {
			TGStudyCourse course = this.courseService.find(id).getData();
			if(null != course) {
				modelView.getModelMap().put("course", course);

				Map<String, Object> params = new HashMap<>();
				params.put("schoolId", course.getSchoolId());
				params.put("status", IConstant.STATUS_NORMAL);
				modelView.getModelMap().put("classrooms", classroomService.findByParam(params).getDatas());
			}
		}

		modelView.getModelMap().put("schools", schoolService.findNormal().getDatas());

		modelView.getModelMap().put("courseTimes", dictService.getItems("COURSE_TIMES").getDatas());

		modelView.getModelMap().put("weekInfoList", dictService.getItems("WEEK_INFO_LIST").getDatas());

		modelView.setViewName(getPageDir() + "editCourse");
		return modelView;
	}

	/**
	 *  页面显示: 课时所包含的学生信息
	 * @param searchParam   查询参数
	 * @return  JSP页面对象
	 */
	@RequestMapping(value = "/studentList")
	public ModelAndView studentList(StudentCourseRelSearch searchParam, ModelAndView modelView, RequestPage page) {
		String uri = this.getUriPath() + "studentList";
		String nextStatus = searchParam.getStatus();
		if(StringUtils.isBlank(searchParam.getStatus())) {
			searchParam.setStatus(IConstant.STATUS_NORMAL);
			nextStatus = IConstant.STATUS_NORMAL;
		} else if(StringUtils.equals("ALL", searchParam.getStatus())) {
			searchParam.setStatus(null);
			nextStatus = "ALL";
		}
		SmartResponse<Object> smartResp = this.opService.getDatas("course_student_list", searchParam, page.getStartNum(), page.getPageSize());

		uri = uri + "?id=" + searchParam.getId();
		pageParam = new PageParam(uri, "#course-student-list-dialog", page.getPage(), page.getPageSize());
		refreshBtn = new RefreshBtn(uri, null,"#course-student-list-dialog");

		ModelMap modelMap = modelView.getModelMap();
		modelMap.put("smartResp", smartResp);
		modelMap.put("pageParam", pageParam);

		searchParam.setStatus(nextStatus);
		modelMap.put("searchParam", searchParam);
		modelMap.put("refreshBtn", refreshBtn);


		modelView.setViewName(this.getPageDir() + "studentList");
		return modelView;
	}

    @Autowired
    private StudySchoolService schoolService;
	@Autowired
	private DictService dictService;

    /**
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/addCourse")
    public ModelAndView addClass(String teacherId, ModelAndView modelView) throws Exception {

        ModelMap modelMap = modelView.getModelMap();

	    TGStudyTeacher teacher = this.teacherService.find(teacherId).getData();
        modelMap.put("teacher", teacher);

        Map<String, Object> params = new HashMap<>();
        params.put("status", "NORMAL");
        modelView.getModelMap().put("schools", schoolService.findByParam(params).getDatas());

	    modelView.getModelMap().put("courseTimes", dictService.getItems("COURSE_TIMES").getDatas());

	    modelView.getModelMap().put("weekInfoList", dictService.getItems("WEEK_INFO_LIST").getDatas());

        modelView.setViewName(this.getPageDir() + "addCourse");
        return modelView;
    }

	@Autowired
	private StudyStudentCourseRelService studentCourseRelService;

    @Autowired
    private StudyCourseRecordService courseRecordService;

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

	@RequestMapping(value = "/deleteCourse", method = RequestMethod.POST)
	@ResponseBody
	public SmartResponse<String> deleteCourse(String id) {
		SmartResponse<String> smartResp = new SmartResponse<>();

		TGStudyCourse course = this.courseService.find(id).getData();
		if(null == course || StringUtils.equals(IConstant.STATUS_DELETE, course.getStatus())){
			smartResp.setResult(IConstant.OP_SUCCESS);
			smartResp.setMsg(IConstant.OP_SUCCESS_MSG);
			return smartResp;
		}

		// 查看报班学生是否都已退出
		Map<String, Object> params = new HashMap<>();
		params.put("courseId", id);
		params.put("status", IConstant.STATUS_NORMAL);
		List<TGStudyStudentCourseRel> studentCourseRelList = studentCourseRelService.findByParam(params).getDatas();
		if (CollectionUtils.isNotEmpty(studentCourseRelList)) {
			smartResp.setMsg("班级中仍有学生 " + studentCourseRelList.size() + "名,不可删除");
			return smartResp;
		}

		// 查看未结课的课时记录信息
		List<TGStudyCourseRecord> courseRecordList = courseRecordService.findByParam(params).getDatas();
		if(CollectionUtils.isNotEmpty(courseRecordList)) {
			//
			smartResp.setMsg("班级仍有 " + courseRecordList.size() + "个课时,不可删除");
			return smartResp;
		}

		List<TGStudyCourseStudentRecord> courseStudentRecordList = courseStudentRecordService.findByParam(params).getDatas();
		if(CollectionUtils.isNotEmpty(courseStudentRecordList)) {
			//
			smartResp.setMsg("班级仍有 " + courseStudentRecordList.size() + "个学生课时,不可删除");
			return smartResp;
		}

		course.setStatus(IConstant.STATUS_DELETE);
		course.setUpdateTime(new Date());
		smartResp = this.courseService.update(course);

		return smartResp;
	}
}
