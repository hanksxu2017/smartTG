package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.bean.search.StudentCourseRelSearch;
import cn.com.smart.web.bean.search.TeacherCourseSearch;
import cn.com.smart.web.bean.search.TeacherSearch;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.constant.enums.SelectedEventType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.filter.bean.UserSearchParam;
import cn.com.smart.web.service.*;
import cn.com.smart.web.tag.bean.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/studyTeacher")
public class StudyTeacherController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyTeacherService studyTeacherService;

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
        SmartResponse<String> smartResp = studyTeacherService.save(studyTeacher);
        return smartResp;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotEmpty(id)) {
            TGStudyTeacher studyTeacher = studyTeacherService.find(id).getData();
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
        TGStudyTeacher studyTeacherDb = this.studyTeacherService.find(studyTeacher.getId()).getData();
        studyTeacher.setCreateTime(studyTeacherDb.getCreateTime());
        studyTeacher.setUpdateTime(new Date());
        SmartResponse<String> smartResp = studyTeacherService.update(studyTeacher);
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
        String uri = this.getUriPath() + "courseList";
        SmartResponse<Object> smartResp = this.opService.getDatas("teacher_course_list", searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, null, page.getPage(), page.getPageSize());
        uri = uri + "?id=" + searchParam.getId();
        addBtn = new EditBtn("add",this.getUriPath() + "addCourse?teacherId=" + searchParam.getId(), "教师增设课时", "800");
        refreshBtn = new RefreshBtn(uri, null,"#teacher-course-tab");

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);
        modelMap.put("addBtn", addBtn);
        modelMap.put("refreshBtn", refreshBtn);
        pageParam = null;

	    CustomBtn customBtnStudentList = new CustomBtn("studentList", "学生列表",
			    "学生列表", this.getUriPath() + "studentList","glyphicon-list-alt", BtnPropType.SelectType.ONE.getValue());
	    customBtnStudentList.setWidth("600");
	    customBtnStudentList.setModalBodyId("course-student-list-dialog");

	    customBtns = new ArrayList<>(1);
	    customBtns.add(customBtnStudentList);
	    modelMap.put("customBtns", customBtns);


        modelView.setViewName(this.getPageDir() + "courseList");
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
		pageParam = new PageParam(uri, null, page.getPage(), page.getPageSize());
		uri = uri + "?id=" + searchParam.getId();
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

    /**
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/addCourse")
    public ModelAndView addClass(String teacherId, ModelAndView modelView) throws Exception {

        ModelMap modelMap = modelView.getModelMap();
        // 携带教师id
        modelMap.put("teacherId", teacherId);

        Map<String, Object> params = new HashMap<>();
        params.put("status", "NORMAL");
        modelView.getModelMap().put("schools", schoolService.findByParam(params).getDatas());

        modelView.setViewName(this.getPageDir() + "addCourse");
        return modelView;
    }

}
