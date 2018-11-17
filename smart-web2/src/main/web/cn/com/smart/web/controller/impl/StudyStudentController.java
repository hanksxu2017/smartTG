package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
    private StudyStudentService studyStudentService;
    @Autowired
    private StudyClassService studyClassService;
    @Autowired
    private StudyStudentClassRelService studentClassRelService;

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

        // 增加自定义按钮
        this.addChooseClassBtn(modelAndView.getModelMap());
        return modelAndView;
    }

    /**
     * 增加报班按钮
     * @param modelMap
     */
    private void addChooseClassBtn(Map<String, Object> modelMap) {
        CustomBtn customBtn = new CustomBtn("chooseClass", "报班", "报班", this.getUriPath() + "chooseClass","glyphicon-list-alt", BtnPropType.SelectType.ONE.getValue());
        customBtn.setWidth("500");
        customBtns = new ArrayList<>(1);
        customBtns.add(customBtn);
        modelMap.put("customBtns", customBtns);
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

        SmartResponse<String> smartResp = studyStudentService.save(studyStudent);
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
            TGStudyStudent studyStudent = studyStudentService.find(id).getData();
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
        TGStudyStudent studyStudentDb = this.studyStudentService.find(studyStudent.getId()).getData();
        studyStudent.setCreateTime(studyStudentDb.getCreateTime());
        studyStudent.setUpdateTime(new Date());
        SmartResponse<String> smartResp = studyStudentService.update(studyStudent);
        return smartResp;
    }


    /**
     *
     * @return
     */
    @RequestMapping(value = "/chooseClass")
    public ModelAndView chooseClass(String id) {
        ModelAndView modelView = new ModelAndView();

        TGStudyStudent studyStudent = studyStudentService.find(id).getData();
        modelView.getModelMap().put("student", studyStudent);

        Map<String, Object> params = new HashMap<>();
        params.put("status", "NORMAL");
        modelView.getModelMap().put("classes", studyClassService.findByParam(params).getDatas());

        modelView.setViewName(getPageDir() + "chooseClass");
        return modelView;
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/submitChooseClass")
    @ResponseBody
    public SmartResponse<String> submitChooseClass(TGStudyStudentClassRel studentClassRel) {
        studentClassRel.setCreateTime(new Date());
        SmartResponse<String> smartResponse = studentClassRelService.save(studentClassRel);
        if(smartResponse.isSuccess()) {
            // 创建学生-班级-课程
            this.createStudentCourseRel(studentClassRel);
        }

        return smartResponse;
    }

    @Autowired
    private StudyStudentCourseRelService studentCourseRelService;
    @Autowired
    private StudyCourseService courseService;

    private void createStudentCourseRel(TGStudyStudentClassRel studentClassRel) {


        Map<String, Object> params = new HashMap<>();
        params.put("classId", studentClassRel.getClassId());
        List<TGStudyCourse> courseList = this.courseService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseList)) {
            TGStudyStudentCourseRel rel = null;
            for(TGStudyCourse course : courseList) {
                rel = initStudentCourseRel(course, studentClassRel);
                studentCourseRelService.save(rel);
            }

        }
    }

    /**
     * 初始化学生的课程关系
     * @param course
     * @param studentClassRel
     * @return
     */
    private TGStudyStudentCourseRel initStudentCourseRel(TGStudyCourse course, TGStudyStudentClassRel studentClassRel) {
        TGStudyStudentCourseRel rel = new TGStudyStudentCourseRel();

        rel.setCourseId(course.getId());
        rel.setCourseWeekInfo(course.getWeekInfo());
        rel.setCourseTime(course.getCourseTime());

        rel.setClassId(studentClassRel.getClassId());
        rel.setClassName(studentClassRel.getClassName());

        rel.setClassroomId(course.getClassroomId());
        rel.setClassroomName(course.getClassroomName());

        rel.setTeacherId(course.getTeacherId());
        rel.setTeacherName(course.getTeacherName());

        rel.setStudentId(studentClassRel.getStudentId());
        rel.setStudentName(studentClassRel.getStudentName());

        rel.setCreateTime(new Date());
        return rel;
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
        SmartResponse<Object> smartResp = this.opService.getDatas("student_simp_list",searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, "#student-tab", page.getPage(), page.getPageSize());
        selectedEventProp = new SelectedEventProp(SelectedEventType.OPEN_TO_TARGET.getValue(),"studyClass/studentHas","#has-class-list","id");

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
    @RequestMapping("/classList")
    public ModelAndView classList(UserSearchParam searchParam,ModelAndView modelView,RequestPage page) throws Exception {
        String uri = this.getUriPath() + "classList";
        SmartResponse<Object> smartResp = this.opService.getDatas("student_class_list", searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, null, page.getPage(), page.getPageSize());
        uri = uri + "?id=" + searchParam.getId();
        delBtn = new DelBtn(this.getUriPath() + "exitClass?studentId=" + searchParam.getId(), "确定要从该班中退出吗？",uri,"#student-class-tab", null);
        delBtn.setName("退班");
        refreshBtn = new RefreshBtn(uri, null,"#student-class-tab");

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);
        modelMap.put("delBtn", delBtn);
        modelMap.put("refreshBtn", refreshBtn);
        pageParam = null;

        CustomBtn customBtnReport = new CustomBtn("reportCourse", "报班", "报班", this.getUriPath() + "reportCourse?studentId=" + searchParam.getId(),"glyphicon-list-alt", BtnPropType.SelectType.NONE.getValue());
        customBtnReport.setWidth("600");

        customBtns = new ArrayList<>(1);
        customBtns.add(customBtnReport);
        modelMap.put("customBtns", customBtns);


        modelView.setViewName(this.getPageDir() + "classList");
        return modelView;
    }

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

    @RequestMapping(value="/exitClass", produces="application/json;charset=UTF-8")
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

    @Override
    protected MgrServiceImpl getMgrService() {
        return this.studentCourseRelService;
    }

    /**
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/subReportCourse",method=RequestMethod.POST)
    public @ResponseBody SmartResponse<String> saveClass(TGStudyStudentCourseRel studentCourseRel) throws Exception {
        String checkRes = this.checkStudentCourseConflict(studentCourseRel);
        studentCourseRel.setCreateTime(new Date());
        SmartResponse<String> smartResp = getSmartResponse(studentCourseRel, checkRes);

        return smartResp;
    }

    /**
     *
     * @param studentCourseRel
     * @return
     */
    private String checkStudentCourseConflict(TGStudyStudentCourseRel studentCourseRel) {

        return null;
    }



}
