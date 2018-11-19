package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.StudentCourseRelSearch;
import cn.com.smart.web.bean.search.StudentSearch;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.constant.enums.SelectedEventType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.filter.bean.UserSearchParam;
import cn.com.smart.web.service.*;
import cn.com.smart.web.tag.bean.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/studyStudent")
public class StudyStudentController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyStudentService studentService;

    public StudyStudentController() {
        super.setSubDir("/studyStudent/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(StudentSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_student_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelAndView = this.packListModelView(searchParam, smartResp);
        return modelAndView;
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
    public SmartResponse<String> save(TGStudyStudent studyStudent) {
        studyStudent.setCreateTime(new Date());

        short parentType = studyStudent.getParentType();
        if(1 == parentType) {
            studyStudent.setParentName(studyStudent.getParentName() + "(父亲)");
        } else if(2 == parentType) {
            studyStudent.setParentName(studyStudent.getParentName() + "(母亲)");
        }

        studyStudent.setRemainCourse(studyStudent.getTotalCourse());

        studyStudent.setAge(this.getAge(studyStudent.getBirthday()));

        SmartResponse<String> smartResp = studentService.save(studyStudent);
        return smartResp;
    }

    private int getAge(String birthday) {
        Date birthDate = DateUtil.parseDate(birthday, "yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        int curYear = cal.get(Calendar.YEAR);

        cal.setTime(birthDate);
        int birthYear = cal.get(Calendar.YEAR);//获取年份

        return curYear - birthYear;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotBlank(id)) {
            TGStudyStudent studyStudent = studentService.find(id).getData();
            if(null != studyStudent) {
                modelView.getModelMap().put("objBean", studyStudent);
            }
        }
        modelView.setViewName(getPageDir() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studyStudent
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyStudent studyStudent) {
        TGStudyStudent studyStudentDb = this.studentService.find(studyStudent.getId()).getData();
        studyStudent.setCreateTime(studyStudentDb.getCreateTime());
        studyStudent.setUpdateTime(new Date());
        SmartResponse<String> smartResp = studentService.update(studyStudent);
        return smartResp;
    }

    @Autowired
    private StudyStudentCourseRelService studentCourseRelService;
    @Autowired
    private StudyCourseService courseService;

    /**
     * 简单列表
     * @return
     * @throws Exception
     */
    @RequestMapping("/simpList")
    public ModelAndView simpList(HttpSession session, UserSearchParam searchParam,
                                 ModelAndView modelView, RequestPage page) throws Exception {
        String uri = this.getUriPath() + "simpList";
        SmartResponse<Object> smartResp = this.opService.getDatas("student_simp_list",searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, "#student-tab", page.getPage(), page.getPageSize());
        selectedEventProp = new SelectedEventProp(SelectedEventType.OPEN_TO_TARGET.getValue(),"studyCourse/studentHas","#has-class-list","id");

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
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/courseList")
    public ModelAndView classList(UserSearchParam searchParam,ModelAndView modelView,RequestPage page) throws Exception {
        String uri = this.getUriPath() + "courseList";
        SmartResponse<Object> smartResp = this.opService.getDatas("student_course_list", searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, null, page.getPage(), page.getPageSize());
        uri = uri + "?id=" + searchParam.getId();
        delBtn = new DelBtn(this.getUriPath() + "exitCourse?studentId=" + searchParam.getId(), "确定要从该班中退出吗？",uri,"#student-course-tab", null);
        delBtn.setName("退班");
        refreshBtn = new RefreshBtn(uri, null,"#student-course-tab");

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);
        modelMap.put("delBtn", delBtn);
//        modelMap.put("refreshBtn", refreshBtn);
        pageParam = null;

        CustomBtn customBtnReport = new CustomBtn("reportCourse", "报班", "报班", this.getUriPath() + "reportCourse?studentId=" + searchParam.getId(),"glyphicon-list-alt", BtnPropType.SelectType.NONE.getValue());
        customBtnReport.setWidth("600");
        customBtns = new ArrayList<>(1);
        customBtns.add(customBtnReport);
        modelMap.put("customBtns", customBtns);


        modelView.setViewName(this.getPageDir() + "courseList");
        return modelView;
    }

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

    @RequestMapping(value="/exitCourse", produces="application/json;charset=UTF-8")
    @ResponseBody
    public SmartResponse<String> exitClass(String id, String studentId) {

        SmartResponse<String> smartResp = new SmartResponse<String>();

        // 从班级中退出
        Map<String, Object> params = new HashMap<>();
        params.put("courseId", id);
        params.put("studentId", studentId);
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyStudentCourseRel> relList = this.studentCourseRelService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(relList)) {
            TGStudyStudentCourseRel rel = relList.get(0);
            if(null != rel && !StringUtils.equals(rel.getStatus(), IConstant.STATUS_EXIT_COURSE)) {
                rel.setStatus(IConstant.STATUS_EXIT_COURSE);
                rel.setUpdateTime(new Date());
                this.studentCourseRelService.update(rel);
            }
        }

        // 本周内未结束的课时需要结束掉
        params = new HashMap<>();
        params.put("courseId", id);
        params.put("studentId", studentId);
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyCourseStudentRecord> courseStudentRecordList =
                this.courseStudentRecordService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseStudentRecordList)) {
            for(TGStudyCourseStudentRecord record : courseStudentRecordList) {
                record.setStatus(IConstant.STATUS_COURSE_CANCEL_AS_EXIT);
                record.setUpdateTime(new Date());
            }
            this.courseStudentRecordService.update(courseStudentRecordList);
        }

        smartResp.setResult(IConstant.OP_SUCCESS);
        smartResp.setMsg("已完成退班!");
        return smartResp;
    }

    @Autowired
    private StudyTeacherService teacherService;

    /**
     *
     * @return
     */
    @RequestMapping(value = "/reportCourse")
    public ModelAndView reportCourse(String studentId) {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getPageDir() + "reportCourse");

        modelView.getModelMap().put("studentId", studentId);

        Map<String, Object> params = new HashMap<>();
        params.put("status", IConstant.STATUS_NORMAL);
        modelView.getModelMap().put("teachers", this.teacherService.findByParam(params).getDatas());

        return modelView;
    }



	/**
	 *
	 * @param modelView
	 * @param id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/courseRecHas")
	public ModelAndView courseRecHas(ModelAndView modelView,String id) throws Exception {
		if(StringUtils.isNotBlank(id)) {
			SmartResponse<Object> smartResp = this.opService.find(TGStudyCourseRecord.class, id);
			ModelMap modelMap = modelView.getModelMap();
			modelMap.put("courseRecordId", id);
			if(smartResp.getResult().equals(OP_SUCCESS)) {
				TGStudyCourseRecord courseRecord = (TGStudyCourseRecord) smartResp.getData();
				String name = (null != courseRecord)?courseRecord.getCourseName():null;
				modelMap.put("name", name);
			}
		}
		modelView.setViewName(this.getPageDir() + "courseRecHas");
		return modelView;
	}

    /**
     * 该课时拥有的学生列表信息
     * @return
     * @throws Exception
     */
    @RequestMapping("/studentList")
    public ModelAndView studentList(StudentCourseRelSearch searchParam, ModelAndView modelView, RequestPage page) throws Exception {
        String uri = this.getUriPath() + "studentList";
        SmartResponse<Object> smartResp = this.opService.getDatas("courseRecord_student_list", searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, null, page.getPage(), page.getPageSize());
        uri = uri + "?courseRecordId=" + searchParam.getCourseRecordId();
        refreshBtn = new RefreshBtn(uri, null,"#courseRecord-student-tab");

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);
        modelMap.put("refreshBtn", refreshBtn);

        CustomBtn customBtnAllSign = new CustomBtn("allSign", "全部签到",
                "全部签到", this.getUriPath() + "allSign?courseRecordId=" + searchParam.getCourseRecordId(),"glyphicon-list-alt", BtnPropType.SelectType.NONE.getValue());
        customBtnAllSign.setWidth("600");

        CustomBtn customBtnSign = new CustomBtn("studentSign", "上课点名",
                "上课点名", this.getUriPath() + "studentSign?courseRecordId=" + searchParam.getCourseRecordId(),"glyphicon-list-alt", BtnPropType.SelectType.MULTI.getValue());
        customBtnSign.setWidth("600");


        customBtns = new ArrayList<>(2);
        customBtns.add(customBtnAllSign);
        customBtns.add(customBtnSign);
        modelMap.put("customBtns", customBtns);


        modelView.setViewName(this.getPageDir() + "studentList");
        return modelView;
    }

    @Autowired
    private StudyCourseRecordService courseRecordService;

    /**
     *
     * @return
     */
    @RequestMapping(value = "/allSign")
    public ModelAndView allSign(String courseRecordId) {
        ModelAndView modelView = new ModelAndView();

        TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseRecordId).getData();
        modelView.getModelMap().put("courseRecord", courseRecord);

        if(!this.checkCourseCanSign(courseRecord)) {
            modelView.getModelMap().put("disableSign", "yes");
        }


        modelView.setViewName(this.getPageDir() + "allSign");
        return modelView;
    }

    /**
     *
     * 全部签到
     * @param courseRecordId
     * @return
     */
    @RequestMapping(value = "/subAllSign", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> subAllSign(String courseRecordId) {
        SmartResponse<String> response = new SmartResponse<>();
        SmartResponse<TGStudyCourseRecord> smartResponse = this.courseRecordService.find(courseRecordId);
        if(!smartResponse.isSuccess() || null == smartResponse.getData()) {
            response.setMsg(smartResponse.getMsg());
            return response;
        }
        TGStudyCourseRecord courseRecord = smartResponse.getData();

        if(!this.checkCourseCanSign(courseRecord)) {
            response.setMsg("课时目前无法进行签到操作,请稍后再试!");
            return response;
        }

        Date updateDate = new Date();
        Map<String, Object> params = new HashMap<>();
        params.put("courseRecId", courseRecordId);
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyCourseStudentRecord> courseStudentRecordList =
                this.courseStudentRecordService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseStudentRecordList)) {
            courseRecord.setStudentQuantityPlan(courseStudentRecordList.size());
            courseRecord.setStudentQuantityActual(courseStudentRecordList.size());
            courseRecord.setStudentPersonalLeave(0);
            courseRecord.setStudentPlayTruant(0);
            courseRecord.setStudentOtherAbsent(0);

            TGStudyStudent student;
            for(TGStudyCourseStudentRecord courseStudentRecord : courseStudentRecordList) {
                courseStudentRecord.setStatus(IConstant.STATUS_COURSE_END);
                courseRecord.setUpdateTime(updateDate);
                this.courseStudentRecordService.update(courseStudentRecord);

                // 学生课时-1
                student = this.studentService.find(courseStudentRecord.getStudentId()).getData();
                student.setRemainCourse(student.getRemainCourse() - 1);
                student.setUpdateTime(updateDate);
                this.studentService.update(student);

                // TODO
                // 学生课时小于3时,进行系统提醒
            }
        }

        courseRecord.setUpdateTime(updateDate);
        courseRecord.setStatus(IConstant.STATUS_COURSE_END);
        response = courseRecordService.update(courseRecord);
        return response;
    }

    private boolean checkCourseCanSign(TGStudyCourseRecord courseRecord) {
        Date courseDate =
                DateUtil.parseDate(courseRecord.getCourseDate() + " " + courseRecord.getCourseTime(),
                        "yyyy-MM-dd HH:mm");
        if(null != courseDate) {
            return courseDate.before(new Date());
        }
        return false;
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/studentSign")
    public ModelAndView studentSign(String id) {
        ModelAndView modelView = new ModelAndView();
        System.out.println(id);

        modelView.setViewName(this.getPageDir() + "studentSign");
        return modelView;
    }

    @RequestMapping(value = "/subSign", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> subSign(String courseRecordId, String id) {

        return null;
    }
}
