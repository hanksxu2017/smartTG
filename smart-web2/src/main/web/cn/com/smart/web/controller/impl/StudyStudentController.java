package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.constant.enumEntity.CourseStudentStatusEnum;
import cn.com.smart.constant.enumEntity.SystemMessageEnum;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.UserInfo;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.StudentCourseRelSearch;
import cn.com.smart.web.bean.search.StudentSearch;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.constant.enums.SelectedEventType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import cn.com.smart.web.tag.bean.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.*;

@Slf4j
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
     * @param searchParam 查询参数对象
     * @param page        分页参数对象
     * @return JSP页面对象
     */
    @RequestMapping("/list")
    public ModelAndView list(StudentSearch searchParam, RequestPage page) {
        String queryStatus = searchParam.getStatus();
        if (StringUtils.isBlank(queryStatus)) {
            searchParam.setStatus(IConstant.STATUS_NORMAL);
            queryStatus = IConstant.STATUS_NORMAL;
        } else if (StringUtils.equals(queryStatus, "ALL")) {
            searchParam.setStatus("");
        }
        SmartResponse<Object> smartResp = opService.getDatas("student_list", searchParam, page.getStartNum(), page.getPageSize());
        // 恢复查询条件
        searchParam.setStatus(queryStatus);

        ModelAndView modelView = new ModelAndView();
        Map<String, Object> modelMap = modelView.getModelMap();
        addBtn = new EditBtn("add", this.getUriPath() + "add", null, "新增", "800");
        editBtn = new EditBtn("edit", this.getUriPath() + "edit", null, "修改", "800");

        delBtn = new DelBtn(this.getUriPath() + "delete", "确定进行退学操作吗？", this.getUriPath() + "list", null, null);
        delBtn.setName("退学");
        delBtn.setSelectedType(BtnPropType.SelectType.MULTI.getValue());

        refreshBtn = new RefreshBtn(this.getUriPath() + "list", null, null);

        CustomBtn customBtnReport = new CustomBtn("increaseRemainCourse", "课时续费", "续费",
                this.getUriPath() + "increaseRemainCourse?studentId=" + searchParam.getId(), "glyphicon-plus", BtnPropType.SelectType.ONE.getValue());
        customBtnReport.setWidth("600");

        CustomBtn customBtnTempLeave = new CustomBtn("tempLeave", "休学", "休学",
                this.getUriPath() + "tempLeave?studentId=" + searchParam.getId(), "glyphicon-pause", BtnPropType.SelectType.ONE.getValue());
        customBtnTempLeave.setWidth("600");

        CustomBtn customBtnCourseInfo = new CustomBtn("courseInfo", "班级信息", "班级",
                this.getUriPath() + "courseInfo", "glyphicon-align-justify", BtnPropType.SelectType.ONE.getValue());
        customBtnCourseInfo.setWidth("800");
        customBtnCourseInfo.setModalBodyId("student-course-list-dialog");

        CustomBtn customBtnUploadBatch = new CustomBtn("uploadBatch", "信息导入", "导入",
                this.getUriPath() + "uploadBatch", "glyphicon-save", BtnPropType.SelectType.NONE.getValue());
        customBtnUploadBatch.setWidth("600");

        CustomBtn customBtnExport = new CustomBtn("exportStudent", "信息导出", "导出",
                this.getUriPath() + "exportStudent", "glyphicon-open", BtnPropType.SelectType.NONE.getValue());
        customBtnExport.setOpenStyle(BtnPropType.OpenStyle.NONE);
        customBtnExport.setWidth("600");

        customBtns = new ArrayList<>(5);
        customBtns.add(customBtnReport);
        customBtns.add(customBtnTempLeave);
        customBtns.add(customBtnCourseInfo);
        customBtns.add(customBtnUploadBatch);
        customBtns.add(customBtnExport);
        modelMap.put("customBtns", customBtns);

        pageParam = new PageParam(this.getUriPath() + "list", null, page.getPage(), page.getPageSize());

        modelMap.put("addBtn", addBtn);
        modelMap.put("editBtn", editBtn);
        modelMap.put("delBtn", delBtn);
        modelMap.put("pageParam", pageParam);
        modelMap.put("refreshBtn", refreshBtn);
        modelMap.put("smartResp", smartResp);
        modelMap.put("searchParam", searchParam);

        modelView.setViewName(this.getPageDir() + "list");
        return modelView;
    }

    /**
     * @return JSP页面对象
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getPageDir() + "add");

        modelView.getModelMap().put("levels", getLevels());

        return modelView;
    }

    private List<String> getLevels() {
        List<String> levels = new ArrayList<>();
        for(int index = 1; index <= 25; index++) {
            levels.add(String.valueOf(index) + "级");
        }
        for(int index = 1; index <= 5; index++) {
            levels.add(String.valueOf(index) + "段");
        }
        return levels;
    }

    /**
     * @param studyStudent 学生信息
     * @return 保存结果
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> save(TGStudyStudent studyStudent) {

        studyStudent.setCreateTime(new Date());

        studyStudent.setRemainCourse(studyStudent.getTotalCourse());

        studyStudent.setAge(this.getAge(studyStudent.getBirthday()));

        return studentService.save(studyStudent);
    }


    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> delete(String id) {

        TGStudyStudent studyStudentDb = this.studentService.find(id).getData();
        studyStudentDb.setStatus(IConstant.STATUS_DROP_OUT);
        studyStudentDb.setUpdateTime(new Date());
        // 退学操作时清零剩余课时
        studyStudentDb.setRemainCourse(0);
        SmartResponse<String> smartResponse = studentService.update(studyStudentDb);
        if (!smartResponse.isSuccess()) {
            return smartResponse;
        }

        // 取消课时关联
        Map<String, Object> params = new HashMap<>();
        params.put("studentId", id);
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyStudentCourseRel> courseRelList = this.studentCourseRelService.findByParam(params).getDatas();
        if (CollectionUtils.isNotEmpty(courseRelList)) {
            for (TGStudyStudentCourseRel courseRel : courseRelList) {
                courseRel.setStatus(IConstant.STATUS_DROP_OUT);
                courseRel.setUpdateTime(new Date());
            }
            this.studentCourseRelService.update(courseRelList);
        }

        // 取消课时记录
        List<TGStudyCourseStudentRecord> courseStudentRecordList = this.courseStudentRecordService.findByParam(params).getDatas();
        if (CollectionUtils.isNotEmpty(courseStudentRecordList)) {
            for (TGStudyCourseStudentRecord courseStudentRecord : courseStudentRecordList) {
                courseStudentRecord.setStatus(IConstant.STATUS_COURSE_CANCEL_AS_EXIT);
                courseStudentRecord.setUpdateTime(new Date());
            }
            this.studentCourseRelService.update(courseRelList);
        }

        return smartResponse;
    }

    /**
     * 根据出生日期计算年龄
     *
     * @param birthday 出生日期
     * @return 年龄
     */
    private int getAge(String birthday) {
        Date birthDate = DateUtil.parseDate(birthday, "yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        int curYear = cal.get(Calendar.YEAR);

        assert birthDate != null;
        cal.setTime(birthDate);
        int birthYear = cal.get(Calendar.YEAR);//获取年份

        return curYear - birthYear;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if (StringUtils.isNotBlank(id)) {
            TGStudyStudent studyStudent = studentService.find(id).getData();
            if (null != studyStudent) {
                modelView.getModelMap().put("objBean", studyStudent);
            }
        }
        modelView.getModelMap().put("levels", getLevels());

        modelView.setViewName(getPageDir() + "edit");
        return modelView;
    }


    @RequestMapping(value = "/courseInfo")
    public ModelAndView courseInfo(StudentCourseRelSearch searchParam, RequestPage page) {
        ModelAndView modelView = new ModelAndView();

        SmartResponse<Object> smartResp = this.opService.getDatas("student_course_list", searchParam, page.getStartNum(), page.getPageSize());
        modelView.getModelMap().put("smartResp", smartResp);

        pageParam = new PageParam(this.getUriPath() + "courseInfo", "#student-course-list-dialog", page.getPage(), page.getPageSize());
        modelView.getModelMap().put("pageParam", pageParam);

        modelView.setViewName(getPageDir() + "courseInfo");

        refreshBtn = new RefreshBtn(this.getUriPath() + "courseInfo?id=" + searchParam.getId(), null,"#student-course-list-dialog");
        modelView.getModelMap().put("refreshBtn", refreshBtn);

        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studyStudent 学生信息对象
     * @return 修改结果
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyStudent studyStudent) {
        TGStudyStudent studyStudentDb = this.studentService.find(studyStudent.getId()).getData();
        studyStudent.setCreateTime(studyStudentDb.getCreateTime());
        studyStudent.setUpdateTime(new Date());
        return studentService.update(studyStudent);
    }

    @Autowired
    private StudyStudentCourseRelService studentCourseRelService;

    /**
     * 简单列表
     *
     * @return JSP页面对象
     */
    @RequestMapping("/simpList")
    public ModelAndView simpList(StudentSearch searchParam,
                                 ModelAndView modelView, RequestPage page) {
        String uri = this.getUriPath() + "simpList";
        SmartResponse<Object> smartResp = this.opService.getDatas("student_simp_list", searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, "#student-tab", page.getPage(), page.getPageSize());
        selectedEventProp = new SelectedEventProp(SelectedEventType.OPEN_TO_TARGET.getValue(), "studyCourse/studentHas", "#has-class-list", "id");

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
     * @return JSP页面对象
     */
    @RequestMapping("/courseList")
    public ModelAndView classList(StudentCourseRelSearch searchParam, ModelAndView modelView, RequestPage page) {
        String uri = this.getUriPath() + "courseList";
        if (StringUtils.isBlank(searchParam.getStatus())) {
            searchParam.setStatus(IConstant.STATUS_NORMAL);
        }
        if (StringUtils.equals(searchParam.getStatus(), "ALL")) {
            searchParam.setStatus(null);
        }
        SmartResponse<Object> smartResp = this.opService.getDatas("student_course_list", searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, null, page.getPage(), page.getPageSize());
        uri = uri + "?id=" + searchParam.getId();
        delBtn = new DelBtn(this.getUriPath() + "exitCourse?studentId=" + searchParam.getId(), "确定要从该班中退出吗？", uri, "#student-course-tab", null);
        delBtn.setName("退班");
        refreshBtn = new RefreshBtn(uri, null, "#student-course-tab");

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);
        modelMap.put("delBtn", delBtn);
//        modelMap.put("refreshBtn", refreshBtn);
        pageParam = null;

        CustomBtn customBtnReport = new CustomBtn("reportCourse", "报班", "报班", this.getUriPath() + "reportCourse?studentId=" + searchParam.getId(), "glyphicon-list-alt", BtnPropType.SelectType.NONE.getValue());
        customBtnReport.setWidth("600");
        customBtns = new ArrayList<>(1);
        customBtns.add(customBtnReport);
        modelMap.put("customBtns", customBtns);


        modelView.setViewName(this.getPageDir() + "courseList");
        return modelView;
    }

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

    @RequestMapping(value = "/exitCourse", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public SmartResponse<String> exitClass(String id, String studentId) {

        SmartResponse<String> smartResp;
        smartResp = new SmartResponse<>();

        // 从班级中退出
        Map<String, Object> params = new HashMap<>();
        params.put("courseId", id);
        params.put("studentId", studentId);
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyStudentCourseRel> relList = this.studentCourseRelService.findByParam(params).getDatas();
        if (CollectionUtils.isNotEmpty(relList)) {
            TGStudyStudentCourseRel rel = relList.get(0);
            if (null != rel && !StringUtils.equals(rel.getStatus(), IConstant.STATUS_EXIT_COURSE)) {
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
        if (CollectionUtils.isNotEmpty(courseStudentRecordList)) {
            for (TGStudyCourseStudentRecord record : courseStudentRecordList) {
                record.setStatus(IConstant.STATUS_COURSE_CANCEL_AS_EXIT);
                record.setUpdateTime(new Date());
            }
            this.courseStudentRecordService.update(courseStudentRecordList);
        }

        smartResp.setResult(IConstant.OP_SUCCESS);
        smartResp.setMsg("已完成退班!");
        return smartResp;
    }


    /**
     * @return JSP页面对象
     */
    @RequestMapping(value = "/increaseRemainCourse")
    public ModelAndView increaseRemainCourse(String id) {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getPageDir() + "increaseRemainCourse");

        modelView.getModelMap().put("student", this.studentService.find(id).getData());

        return modelView;
    }

    @Autowired
    private StudyRenewRecordService renewRecordService;

    /**
     * 增加课时
     *
     * @param renewRecord   续费记录对象
     * @return 修改结果
     */
    @RequestMapping(value = "/subIncreaseRemainCourse", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> subIncreaseRemainCourse(TGStudyRenewRecord renewRecord, HttpServletRequest request) {

        SmartResponse<String> smartResponse = new SmartResponse<>();

        UserInfo userInfo = this.getUserInfoFromSession(request);
        if(null != userInfo) {
            renewRecord.setOperatorId(userInfo.getId());
            renewRecord.setOperatorFullName(userInfo.getFullName());
            renewRecord.setCreateTime(new Date());

            TGStudyStudent studyStudentDb = this.studentService.find(renewRecord.getStudentId()).getData();
            if(null != studyStudentDb) {
                renewRecord.setStudentName(studyStudentDb.getName());

                studyStudentDb.setCreateTime(studyStudentDb.getCreateTime());
                studyStudentDb.setUpdateTime(new Date());
                studyStudentDb.setRemainCourse(studyStudentDb.getRemainCourse() + renewRecord.getCourseCount());
                studyStudentDb.setTotalCourse(studyStudentDb.getTotalCourse() + renewRecord.getCourseCount());
                smartResponse = studentService.update(studyStudentDb);
                if(smartResponse.isSuccess()) {
                    smartResponse = renewRecordService.save(renewRecord);
                }
            }
        }

        return smartResponse;
    }


    /**
     * @return JSP页面对象
     */
    @RequestMapping(value = "/tempLeave")
    public ModelAndView tempLeave(String id) {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getPageDir() + "tempLeave");

        modelView.getModelMap().put("student", this.studentService.find(id).getData());

        return modelView;
    }


    /**
     * 提交休学更改
     *
     * @param studentId 学生编号
     * @param status    状态
     * @return 修改结果
     */
    @RequestMapping(value = "/subTempLeave", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> subTempLeave(String studentId, String status) {
        SmartResponse<String> smartResponse = new SmartResponse<>();
        TGStudyStudent studyStudentDb = this.studentService.find(studentId).getData();
        if (!StringUtils.equals(status, studyStudentDb.getStatus())) {
            if (StringUtils.equals(status, IConstant.STATUS_TEMP_LEAVE)) {
                // 休学
                // 休学操作不对课时进行清零操作
                studyStudentDb.setStatus(IConstant.STATUS_TEMP_LEAVE);
                studyStudentDb.setUpdateTime(new Date());
                studentService.update(studyStudentDb);
                // 删除所有班级信息
                Map<String, Object> params = new HashMap<>();
                params.put("status", IConstant.STATUS_NORMAL);
                params.put("studentId", studentId);
                this.studentCourseRelService.deleteByField(params);
                // 删除所有未结课的课时信息
                this.courseStudentRecordService.deleteByField(params);
            } else if (StringUtils.equals(status, IConstant.STATUS_BACK_STUDY)) {
                if(StringUtils.equals(studyStudentDb.getStatus(), IConstant.STATUS_TEMP_LEAVE)) {
                    // 仅允许休学状态的可以进行返校操作
                    studyStudentDb.setStatus(IConstant.STATUS_NORMAL);
                    studyStudentDb.setUpdateTime(new Date());
                    studentService.update(studyStudentDb);
                }
            }
        }

        smartResponse.setResult(IConstant.OP_SUCCESS);
        smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
        return smartResponse;
    }

    @Autowired
    private StudyTeacherService teacherService;

    /**
     * @return JSP页面对象
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
     * @param modelView JSP页面对象
     * @param id        课时记录序号
     * @return JSP页面对象
     */
    @RequestMapping("/courseRecHas")
    public ModelAndView courseRecHas(ModelAndView modelView, String id) {
        if (StringUtils.isNotBlank(id)) {
            SmartResponse<Object> smartResp = this.opService.find(TGStudyCourseRecord.class, id);
            ModelMap modelMap = modelView.getModelMap();
            modelMap.put("courseRecordId", id);
            if (smartResp.getResult().equals(OP_SUCCESS)) {
                TGStudyCourseRecord courseRecord = (TGStudyCourseRecord) smartResp.getData();
                if (null != courseRecord) {
                    modelMap.put("name", courseRecord.getCourseName());
                    if (IConstant.STATUS_COURSE_END.equals(courseRecord.getStatus())) {
                        modelMap.put("studentSignStatistics", concatSignStatistics(courseRecord));
                    }
                }
            }
        }
        modelView.setViewName(this.getPageDir() + "courseRecHas");
        return modelView;
    }

    private String concatSignStatistics(TGStudyCourseRecord courseRecord) {
        return "应到" + courseRecord.getStudentQuantityPlan() +
                "/实到" + courseRecord.getStudentQuantityActual() +
                "/事假" + courseRecord.getStudentPersonalLeave() +
                "/旷课" + courseRecord.getStudentPlayTruant() +
                "/其他缺席" + courseRecord.getStudentOtherAbsent();
    }

    /**
     * 该课时拥有的学生列表信息
     *
     * @return JSP页面对象
     */
    @RequestMapping("/studentList")
    public ModelAndView studentList(StudentCourseRelSearch searchParam, ModelAndView modelView, RequestPage page) {
        String uri = this.getUriPath() + "studentList";
        SmartResponse<Object> smartResp = this.opService.getDatas("courseRecord_student_list", searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, null, page.getPage(), page.getPageSize());
        uri = uri + "?courseRecordId=" + searchParam.getCourseRecordId();
        refreshBtn = new RefreshBtn(uri, null, "#courseRecord-student-tab");

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);

        CustomBtn customBtnAllSign = new CustomBtn("allSign", "全部签到",
                "全部签到", this.getUriPath() + "allSign?courseRecordId=" + searchParam.getCourseRecordId(), "glyphicon-list-alt", BtnPropType.SelectType.NONE.getValue());
        customBtnAllSign.setWidth("600");

        CustomBtn customBtnSign = new CustomBtn("studentSign", "上课点名",
                "上课点名", this.getUriPath() + "studentSign?courseRecordId=" + searchParam.getCourseRecordId(), "glyphicon-list-alt", BtnPropType.SelectType.MULTI.getValue());
        customBtnSign.setWidth("600");

        CustomBtn customBtnMakeUp = new CustomBtn("makeUpStudent", "学员补课",
                "学员补课", this.getUriPath() + "makeUpStudent?courseRecordId=" + searchParam.getCourseRecordId(), "glyphicon-paperclip", BtnPropType.SelectType.NONE.getValue());
        customBtnSign.setWidth("600");


        customBtns = new ArrayList<>(3);
        customBtns.add(customBtnAllSign);
        customBtns.add(customBtnSign);
        customBtns.add(customBtnMakeUp);

        modelMap.put("customBtns", customBtns);


        modelView.setViewName(this.getPageDir() + "studentList");
        return modelView;
    }

    @Autowired
    private StudyCourseRecordService courseRecordService;

    /**
     * @return JSP页面对象
     */
    @RequestMapping(value = "/allSign")
    public ModelAndView allSign(String courseRecordId) {
        ModelAndView modelView = new ModelAndView();

        TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseRecordId).getData();
        modelView.getModelMap().put("courseRecord", courseRecord);

        if (!this.checkCourseCanSign(courseRecord)) {
            modelView.getModelMap().put("disableSign", "yes");
        }


        modelView.setViewName(this.getPageDir() + "allSign");
        return modelView;
    }

    /**
     * 全部签到
     *
     * @param courseRecordId 课时记录序号
     * @return 签到结果
     */
    @RequestMapping(value = "/subAllSign", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> subAllSign(String courseRecordId) {
        SmartResponse<String> response = new SmartResponse<>();
        SmartResponse<TGStudyCourseRecord> smartResponse = this.courseRecordService.find(courseRecordId);
        if (!smartResponse.isSuccess() || null == smartResponse.getData()) {
            response.setMsg(smartResponse.getMsg());
            return response;
        }
        TGStudyCourseRecord courseRecord = smartResponse.getData();

        if (!this.checkCourseCanSign(courseRecord)) {
            response.setMsg("课时目前无法进行签到操作,请稍后再试!");
            return response;
        }

        Date updateDate = new Date();
        Map<String, Object> params = new HashMap<>();
        params.put("courseRecordId", courseRecordId);
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyCourseStudentRecord> courseStudentRecordList =
                this.courseStudentRecordService.findByParam(params).getDatas();
        if (CollectionUtils.isNotEmpty(courseStudentRecordList)) {
            courseRecord.setStudentQuantityPlan(courseStudentRecordList.size());
            courseRecord.setStudentQuantityActual(courseStudentRecordList.size());
            courseRecord.setStudentPersonalLeave(0);
            courseRecord.setStudentPlayTruant(0);
            courseRecord.setStudentOtherAbsent(0);

            TGStudyStudent student;
            for (TGStudyCourseStudentRecord courseStudentRecord : courseStudentRecordList) {
                courseStudentRecord.setStatus(CourseStudentStatusEnum.SIGNED.name());
                courseRecord.setUpdateTime(updateDate);
                this.courseStudentRecordService.update(courseStudentRecord);

                // 学生课时-1
                student = this.studentService.find(courseStudentRecord.getStudentId()).getData();
                student.setRemainCourse(student.getRemainCourse() - 1);
                student.setUpdateTime(updateDate);
                student.setCourseSeriesUnSigned(0);
                this.studentService.update(student);
                if (student.getRemainCourse() < 3) {
                    // 课时不足
                    String content = "学生[" + student.getName() + "]仅剩余 " + student.getRemainCourse() + "课时!";
                    this.broadSystemMessage(SystemMessageEnum.STUDENT_REMAIN_COURSE_NOTE, content);
                }
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
        if (StringUtils.equals(IConstant.STATUS_NORMAL, courseRecord.getStatus()) && null != courseDate) {
            return courseDate.before(new Date());
        }
        return false;
    }

    /**
     * @return JSP页面对象
     */
    @RequestMapping(value = "/studentSign")
    public ModelAndView studentSign(String id, String courseRecordId) {
        ModelAndView modelView = new ModelAndView();
        modelView.getModelMap().put("studentId", id);
        TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseRecordId).getData();
        modelView.getModelMap().put("courseRecord", courseRecord);

        if (!this.checkCourseCanSign(courseRecord)) {
            modelView.getModelMap().put("disableSign", "yes");
        }

        String[] ids = id.split(",");
        StringBuilder nameBuilder = new StringBuilder();
        TGStudyStudent student;
        for (String studentId : ids) {
            student = this.studentService.find(studentId).getData();
            if (null != student) {
                nameBuilder.append(",").append(student.getName());
            }
        }
        String names = nameBuilder.toString();
        if (names.startsWith(",")) {
            names = names.substring(1);
        }
        modelView.getModelMap().put("studentName", names);

        modelView.setViewName(this.getPageDir() + "studentSign");
        return modelView;
    }

    @RequestMapping(value = "/subSign", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> subSign(String courseRecordId, String studentId, String status, String description) {
        SmartResponse<String> smartResponse = new SmartResponse<>();

        CourseStudentStatusEnum statusEnum = CourseStudentStatusEnum.valueOf(status);
        if (StringUtils.isBlank(courseRecordId) ||
                StringUtils.isBlank(studentId) ||
                CourseStudentStatusEnum.NORMAL == statusEnum) {
            smartResponse.setMsg("请求无效!");
            return smartResponse;
        }

        String[] studentIds = studentId.split(",");
        for (String sid : studentIds) {
            smartResponse = processSingleStudentSign(courseRecordId, sid, description, statusEnum);
            if (!smartResponse.isSuccess()) {
                return smartResponse;
            }
        }

        smartResponse.setResult(IConstant.OP_SUCCESS);
        return smartResponse;
    }

    private SmartResponse<String> processSingleStudentSign(String courseRecordId, String studentId, String description, CourseStudentStatusEnum statusEnum) {
        SmartResponse<String> smartResponse = new SmartResponse<>();
        Map<String, Object> params = new HashMap<>();
        params.put("courseRecordId", courseRecordId);
        params.put("studentId", studentId);
        SmartResponse<TGStudyCourseStudentRecord> recordSmartResponse = this.courseStudentRecordService.findByParam(params);
        if (!recordSmartResponse.isSuccess()) {
            smartResponse.setMsg(recordSmartResponse.getMsg());
            return smartResponse;
        }
        TGStudyCourseStudentRecord courseStudentRecord = recordSmartResponse.getDatas().get(0);

        if (null == courseStudentRecord) {
            smartResponse.setMsg("学生课时数据不存在!");
            return smartResponse;
        }
        if (StringUtils.equals(courseStudentRecord.getStatus(), IConstant.STATUS_NORMAL)) {
            // 进行签到操作
            if (!this.checkCourseStudentRecordCanSign(courseStudentRecord)) {
                smartResponse.setMsg("课时目前无法进行签到操作,请稍后再试!");
                return smartResponse;
            }
            // 更新学生课时的签到信息
            courseStudentRecord.setStatus(statusEnum.name());
            courseStudentRecord.setDescription(description);
            courseStudentRecord.setUpdateTime(new Date());
            final SmartResponse<String> updateSmartResponse = this.courseStudentRecordService.update(courseStudentRecord);
            if (!updateSmartResponse.isSuccess()) {
                smartResponse.setMsg("学生课时更新失败!");
                return smartResponse;
            }

            // 学生课时-1
            TGStudyStudent student = this.studentService.find(courseStudentRecord.getStudentId()).getData();
            student.setRemainCourse(student.getRemainCourse() - 1);
            student.setUpdateTime(new Date());
            if (CourseStudentStatusEnum.SIGNED.equals(statusEnum)) {
                student.setCourseSeriesUnSigned(0);
            } else {
                // 非正常签到,生成异常签到记录
                student.setCourseSeriesUnSigned(student.getCourseSeriesUnSigned() + 1);
            }
            this.studentService.update(student);
            if (student.getCourseSeriesUnSigned() >= 3) {
                // 连续未签到,系统提示
                String content = "学生[" + student.getName() + "]已连续 " + student.getCourseSeriesUnSigned() + "次缺席!";
                this.broadSystemMessage(SystemMessageEnum.STUDENT_ABSENT_NOTE, content);
            }
            if (student.getRemainCourse() < 3) {
                // 课时不足
                String content = "学生[" + student.getName() + "]仅剩余 " + student.getRemainCourse() + "课时!";
                this.broadSystemMessage(SystemMessageEnum.STUDENT_REMAIN_COURSE_NOTE, content);
            }
        }

        // 检查课时的学生列表是否已经全部签到
        this.updateCourseRecordToEndIfAllSigned(courseStudentRecord.getCourseRecordId());

        smartResponse.setResult(IConstant.OP_SUCCESS);
        return smartResponse;
    }

    /**
     * 查看课时是否支持签到操作
     *
     * @param courseStudentRecord 学生课时信息对象
     * @return 可以执行签到时返回true, 否则返回false
     */
    private boolean checkCourseStudentRecordCanSign(TGStudyCourseStudentRecord courseStudentRecord) {
        TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseStudentRecord.getCourseRecordId()).getData();
        return this.checkCourseCanSign(courseRecord);
    }

    /**
     * 检查课时的学生是否已经全部进行了签到操作
     *
     * @param courseRecordId 课时记录序号
     */
    private void updateCourseRecordToEndIfAllSigned(String courseRecordId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseRecordId", courseRecordId);
        params.put("status!", CourseStudentStatusEnum.CANCEL_AS_EXIT.name());
        List<TGStudyCourseStudentRecord> courseStudentRecordList = this.courseStudentRecordService.findByParam(params).getDatas();
        if (!CollectionUtils.isEmpty(courseStudentRecordList)) {
            // 所有学生课时记录已处理
            boolean isAllSigned = true;

            int actual = 0;
            int personalLeave = 0;
            int playTruant = 0;
            int otherAbsent = 0;

            for (TGStudyCourseStudentRecord courseStudentRecord : courseStudentRecordList) {
                if (StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.NORMAL.name())) {
                    isAllSigned = false;
                    break;
                }
                if (StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.SIGNED.name())) {
                    actual++;
                } else if (StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.PERSONAL_LEAVE.name())) {
                    personalLeave++;
                } else if (StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.PLAY_TRUANT.name())) {
                    playTruant++;
                } else if (StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.OTHER_ABSENT.name())) {
                    otherAbsent++;
                }
            }

            if (isAllSigned) {
                TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseRecordId).getData();
                courseRecord.setStudentQuantityPlan(courseStudentRecordList.size());
                courseRecord.setStudentQuantityActual(actual);
                courseRecord.setStudentPersonalLeave(personalLeave);
                courseRecord.setStudentPlayTruant(playTruant);
                courseRecord.setStudentOtherAbsent(otherAbsent);

                courseRecord.setUpdateTime(new Date());
                courseRecord.setStatus(IConstant.STATUS_COURSE_END);
            }
        }
    }

    @Autowired
    private StudySystemMessageService systemMessageService;

    private void broadSystemMessage(SystemMessageEnum systemMessageEnum, String content) {
        TGStudySystemMessage systemMessage = new TGStudySystemMessage();
        systemMessage.setMessageType(systemMessageEnum.name());
        systemMessage.setMessageContent(content);
        systemMessage.setLevel(systemMessageEnum.getLevel());
        systemMessage.setCreateTime(new Date());
        this.systemMessageService.save(systemMessage);
    }


    @RequestMapping(value = "/exportStudent")
    public void exportStudent(HttpServletResponse response) {
        List<TGStudyStudent> studentList = this.studentService.findNormal().getDatas();
        if(CollectionUtils.isNotEmpty(studentList)) {
            this.backExcelFile(this.getExcelTitle(), response, "学生信息", studentList);
        }
    }

    /**
     * 获取导出EXCEL的标题
     * @return  标题名称列表
     */
    private List<String> getExcelTitle() {
        List<String> titleList = new ArrayList<>();
        titleList.add("姓名");
        titleList.add("性别");
        titleList.add("出生日期");
        titleList.add("就读学校");
        titleList.add("联系方式");
        titleList.add("等级");
        titleList.add("剩余课时");
        titleList.add("是否已注册");
        titleList.add("入学时间");
        return titleList;
    }

    /**
     * 学生信息写入EXCEL文件并返回给请求客户端
     * @param titleList     标题列表
     * @param response      HTTP响应对象
     * @param title         文件名称
     */
    public void backExcelFile(List<String> titleList, HttpServletResponse response, String title, List<TGStudyStudent> studentList) {

        HSSFWorkbook wb = new HSSFWorkbook();

        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet

        HSSFSheet sheet = wb.createSheet(title);

        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short

        HSSFRow row = sheet.createRow(0);

        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER);
        HSSFCell cell = null;
        int size = titleList.size();
        for (int i = 0; i < size; i++) {
            sheet.setDefaultColumnStyle(i, style);
            sheet.setColumnWidth(i, 5000);
            cell = row.createCell(i);
            cell.setCellValue(new HSSFRichTextString(titleList.get(i)));
        }

        this.fillDataToExcel(sheet, style, studentList);

        String sFileName = title + ".xls";
        try {
            response.setContentType("application/msexcel;charset=UTF-8");
            response.setHeader("Content-Disposition",
                    "attachment;filename=".concat(String.valueOf(URLEncoder.encode(sFileName, "UTF-8"))));
            response.setHeader("Connection", "close");
            response.setHeader("Content-Type", "application/vnd.ms-excel");

            wb.write(response.getOutputStream());
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private void fillDataToExcel(HSSFSheet sheet, HSSFCellStyle style, List<TGStudyStudent> studentList) {

        TGStudyStudent student = null;
        HSSFRow row = null;
        HSSFCell cell = null;
        // 记录行索引
        for(int index = 0; index < studentList.size(); index++) {
            student = studentList.get(index);

            row = sheet.createRow(index + 1);

            // 姓名
            cell = row.createCell(0);
            cell.setCellStyle(style);
            cell.setCellValue(new HSSFRichTextString(student.getName()));

            // 性别
            cell = row.createCell(1);
            cell.setCellStyle(style);
            cell.setCellValue(new HSSFRichTextString(student.getSex() == 1 ? "男生" : "女生"));

            // 出生日期
            cell = row.createCell(2);
            cell.setCellStyle(style);
            cell.setCellValue(new HSSFRichTextString(student.getBirthday()));

            // 就读学校
            cell = row.createCell(3);
            cell.setCellStyle(style);
            cell.setCellValue(new HSSFRichTextString(student.getSchoolName()));

            // 联系方式
            cell = row.createCell(4);
            cell.setCellStyle(style);
            cell.setCellValue(new HSSFRichTextString(student.getParentPhone()));

            // 等级
            cell = row.createCell(5);
            cell.setCellStyle(style);
            cell.setCellValue(new HSSFRichTextString(student.getLevel()));

            // 剩余课时
            cell = row.createCell(6);
            cell.setCellStyle(style);
            cell.setCellValue(new HSSFRichTextString(String.valueOf(student.getRemainCourse())));

            // 是否已注册
            cell = row.createCell(7);
            cell.setCellStyle(style);
            cell.setCellValue(new HSSFRichTextString(StringUtils.equals(IConstant.IS_PROCESS_YES, student.getIsRegister()) ? "已注册" : "未注册"));

            // 入学时间
            cell = row.createCell(8);
            cell.setCellStyle(style);
            cell.setCellValue(new HSSFRichTextString(DateUtil.dateToStr(student.getCreateTime(), "yyyy-MM-dd")));
        }

    }

    /**
     * @return JSP页面对象
     */
    @RequestMapping(value = "/uploadBatch")
    public ModelAndView uploadBatch() {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getPageDir() + "uploadBatch");

        return modelView;
    }

    /**
     * 提交
     *
     * @return 修改结果
     */
    @RequestMapping(value = "/subUploadStudent", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> subUploadStudent(HttpServletRequest request) {
        SmartResponse<String> smartResponse = new SmartResponse<>();

        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());
        //检查form中是否有enctype="multipart/form-data"
        if (multipartResolver.isMultipart(request)) {
            //将request变成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            //获取multiRequest 中所有的文件名
            Iterator iterator = multiRequest.getFileNames();

            while (iterator.hasNext()) {
                //一次遍历所有文件
                MultipartFile file = multiRequest.getFile(iterator.next().toString());
                if (file != null && (file.getOriginalFilename().endsWith(".xls") || file.getOriginalFilename().endsWith(".xlsx"))) {

                    List<Map<String, String>> dataMap = this.getResultList(file, this.getUploadTitles());
                    // 学生信息写入数据库
                    if (CollectionUtils.isNotEmpty(dataMap)) {
                        this.syncDataToDb(dataMap);
                    }
                } else {
                    smartResponse.setMsg("导入文件格式不正确");
                    return smartResponse;
                }
            }

        }

        smartResponse.setResult(IConstant.OP_SUCCESS);
        smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
        return smartResponse;
    }


    private List<Map<String, String>> getResultList(MultipartFile userInfoFile, List<String> titleList) {
        List<Map<String, String>> relist = new LinkedList<>();
        // 读取
        HSSFWorkbook wb;
        try {
            wb = new HSSFWorkbook(userInfoFile.getInputStream());
            HSSFSheet sheet = wb.getSheetAt(0);
            int size = titleList.size();
            for (int j = 0; j < sheet.getLastRowNum() + 1; j++) {
                HSSFRow row = sheet.getRow(j);
                Map<String, String> tempMap = new HashMap<>();
                for (int i1 = 0; i1 < row.getLastCellNum() && i1 < size; i1++) {
                    HSSFCell cell = row.getCell(i1);
                    if (null == cell) {
                        continue;
                    }
                    CellType cellType = cell.getCellTypeEnum();
                    String msg = "";
                    if (cellType == CellType.STRING) {
                        msg = cell.getStringCellValue();
                    } else if (cellType == CellType.NUMERIC) {
                        msg = new DecimalFormat("#.##").format(cell.getNumericCellValue());
                    }

                    tempMap.put(titleList.get(i1), msg);

/*					// 排除文件头部标题行
					if(j!=0) {
						tempMap.put(titleList.get(i1), msg);
					}*/
                }

                relist.add(tempMap);
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return relist;
    }

    /**
     * @return 数据项列表
     */
    private List<String> getUploadTitles() {
        List<String> titleList = new ArrayList<>();
        titleList.add("name");
        titleList.add("sex");
        // 格式: yyyy.MM.dd
        titleList.add("birthday");
        titleList.add("schoolName");
        titleList.add("idCard");
        titleList.add("studySchoolName");
        titleList.add("level");
        titleList.add("phone");

        return titleList;
    }

    /**
     * @param dataMap 数据列表
     */
    private void syncDataToDb(List<Map<String, String>> dataMap) {

        TGStudyStudent student;

        for (Map<String, String> data : dataMap) {
            student = new TGStudyStudent();
            student.setName(data.get("name"));
            student.setSex(StringUtils.equals("男", data.get("sex")) ? (short) 1 : (short) 2);
            student.setBirthday(DateUtil.dateToStr(DateUtil.parseDate(data.get("birthday"), "yyyy.MM.dd"), "yyyy-MM-dd"));
            student.setSchoolName(data.get("schoolName"));
            student.setLevel(data.get("level"));
            student.setParentPhone(this.parsePhone(data.get("phone")));

            if (StringUtils.isNotBlank(student.getName()) && StringUtils.isNotBlank(student.getParentPhone())) {
                Map<String, Object> params = new HashMap<>();
                params.put("parentPhone", student.getParentPhone());
                params.put("name", student.getName());
                if (this.studentService.findByParam(params).getTotalNum() <= 0) {
                    // 避免重复导入
                    this.studentService.save(student);
                }
            }
        }
    }

    private String parsePhone(String phone) {
        if (StringUtils.isNotBlank(phone)) {
            if (phone.length() > 11) {
                return phone.substring(0, 11);
            }
        }
        return phone;
    }


    /**
     * @param searchParam 查询参数对象
     * @param page        分页参数对象
     * @return JSP页面对象
     */
    @RequestMapping("/makeUpStudent")
    public ModelAndView makeUpStudent(StudentSearch searchParam, RequestPage page) {

        SmartResponse<Object> smartResp = opService.getDatas("student_has_absent_course_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelView = new ModelAndView();
        Map<String, Object> modelMap = modelView.getModelMap();
        refreshBtn = new RefreshBtn(this.getUriPath() + "makeUpStudent", null, null);

        pageParam = new PageParam(this.getUriPath() + "makeUpStudent", null, page.getPage(), page.getPageSize());

        modelMap.put("pageParam", pageParam);
        modelMap.put("refreshBtn", refreshBtn);
        modelMap.put("smartResp", smartResp);
        modelMap.put("searchParam", searchParam);

        modelView.setViewName(this.getPageDir() + "makeUpStudent");
        return modelView;
    }


    @RequestMapping(value = "/subMakeUpStudent", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> subMakeUpStudent() {
        SmartResponse<String> smartResponse = new SmartResponse<>();



        smartResponse.setResult(IConstant.OP_SUCCESS);
        return smartResponse;
    }









}
