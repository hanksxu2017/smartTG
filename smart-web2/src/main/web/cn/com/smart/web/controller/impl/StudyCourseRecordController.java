package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.CourseRecordSearch;
import cn.com.smart.web.bean.search.CourseStudentRecordSearch;
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
@RequestMapping("/studyCourse/record")
public class StudyCourseRecordController extends BaseController {

    @Autowired
    private OPService opService;

    @Autowired
    private StudyCourseRecordService courseRecordService;

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

    public StudyCourseRecordController() {
        super.setSubDir("/studyCourse/record/");
    }

	@RequestMapping("/index")
	public ModelAndView index(ModelAndView modelView) throws Exception {
		modelView.setViewName(this.getPageDir() + "index");
		return modelView;
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
		SmartResponse<Object> smartResp = this.opService.getDatas("courseRecord_simp_list",searchParam, page.getStartNum(), page.getPageSize());
		pageParam = new PageParam(uri, "#courseRecord-tab", page.getPage(), page.getPageSize());
		selectedEventProp = new SelectedEventProp(SelectedEventType.OPEN_TO_TARGET.getValue(),"studyStudent/courseRecHas?courseRecHas=" + searchParam.getId(),"#has-student-list","id");

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
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(CourseRecordSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("course_record_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelAndView = this.packListModelView(searchParam, smartResp);

        // 增加自定义按钮
        this.addCustomBtn(modelAndView.getModelMap());
        return modelAndView;
    }

    /**
     *
     * @param modelMap
     */
    private void addCustomBtn(Map<String, Object> modelMap) {

        CustomBtn customBtnStudent = new CustomBtn("queryStudent", "学生列表", "学生列表", "showPage/base_studyCourse_record_queryStudent","glyphicon-list-alt", BtnPropType.SelectType.ONE.getValue());
        customBtnStudent.setWidth("500");

        customBtns = new ArrayList<>(2);
        customBtns.add(customBtnStudent);
        modelMap.put("customBtns", customBtns);
    }

    @RequestMapping(value = "/generateCourseRecord")
    public ModelAndView generateCourseRecord() {
        ModelAndView modelView = new ModelAndView();

        modelView.getModelMap().put("startDate", DateUtil.dateToStr(DateUtil.getNextMonday(new Date()), "yyyy-MM-dd"));
        modelView.getModelMap().put("endDate", DateUtil.dateToStr(DateUtil.getNextSunday(new Date()), "yyyy-MM-dd"));

        modelView.setViewName(getPageDir() + "generateCourseRecord");
        return modelView;
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/generate", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> generate(String startDate, String endDate) {
        SmartResponse<String> smartResponse = this.generateCourseRecord(startDate, endDate);
        return smartResponse;
    }

    /**
     *
     * @param startDateStr
     * @param endDateStr
     * @return
     */
    private SmartResponse<String> generateCourseRecord(String startDateStr, String endDateStr) {
        SmartResponse<String> fsResp = new SmartResponse<String>();
        Date startDate = DateUtil.parseDate(startDateStr, "yyyy-MM-dd");
        int startDateWeek = DateUtil.getWeek(startDate);
        if(1 != startDateWeek) {
            fsResp.setMsg("开始日期非星期一,拒绝生成!");
            return fsResp;
        }

        Date endDate = DateUtil.parseDate(endDateStr, "yyyy-MM-dd");
        int endDateWeek = DateUtil.getWeek(endDate);
        if(0 != endDateWeek) {
            fsResp.setMsg("开始日期非星期天,拒绝生成!");
            return fsResp;
        }

        List<TGStudyCourse> courseList = this.findAllValidCourse();
        if(CollectionUtils.isEmpty(courseList)) {
            fsResp.setMsg("空的课程表,无课时生成!");
            return fsResp;
        }

        int count = 0;
        TGStudyCourseRecord courseRecord;
        for(TGStudyCourse course : courseList) {
            courseRecord = this.initCourseRecord(course, startDate);
            if(null != courseRecord) {
                if(StringUtils.isBlank(courseRecord.getId())) {
                    this.courseRecordService.save(courseRecord);
                }
                this.createCourseStudentRecord(courseRecord);
                count++;
            }
        }

        fsResp.setResult(IConstant.OP_SUCCESS);
        fsResp.setMsg("课时已生成!");
        fsResp.setSize(count);
        return fsResp;
    }

    @Autowired
    private StudyCourseService courseService;

    /**
     *
     * @return
     */
    private List<TGStudyCourse> findAllValidCourse() {
        Map<String, Object> params = new HashMap<>();
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyCourse> courseList = courseService.findByParam(params).getDatas();
        return courseList;
    }

    @Autowired
    private StudyStudentCourseRelService studyStudentCourseRelService;

    /**
     *
     * @param course
     * @return
     */
    private TGStudyCourseRecord initCourseRecord(TGStudyCourse course, Date startDate) {

        String courseDate =
                DateUtil.dateToStr(this.getWeekDate(course.getWeekInfo(), startDate), "yyyy-MM-dd");

        Map<String, Object> params = new HashMap<>();
        params.put("courseDate", courseDate);
        params.put("courseId", course.getId());
        List<TGStudyCourseRecord> courseRecords = this.courseRecordService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseRecords)) {
            return courseRecords.get(0);
        }

        TGStudyCourseRecord courseRecord = new TGStudyCourseRecord();

        courseRecord.setCourseId(course.getId());
        courseRecord.setCourseDate(courseDate);
        courseRecord.setCourseTime(course.getCourseTime());

        courseRecord.setClassroomId(course.getClassroomId());
        courseRecord.setClassroomName(course.getClassroomName());

        courseRecord.setTeacherId(course.getTeacherId());
        courseRecord.setTeacherName(course.getTeacherName());

        params = new HashMap<>();
        params.put("courseId", course.getId());
        Long count = studyStudentCourseRelService.getCount(params);
        courseRecord.setStudentQuantityPlan(count.intValue());

        courseRecord.setCreateTime(new Date());

        return courseRecord;
    }

    private Date getWeekDate(short weekInfo, Date startDate) {
        if(weekInfo >= 1 && weekInfo <= 7) {
            return DateUtil.addDay(startDate, weekInfo - 1);
        }
        return null;
    }

    @Autowired
    private StudyStudentCourseRelService studentCourseRelService;

    /**
     * 生成课时对应的学生课时记录
     * @param courseRecord
     */
    private void createCourseStudentRecord(TGStudyCourseRecord courseRecord) {

        Map<String, Object> params = new HashMap<>();
        params.put("status", IConstant.STATUS_NORMAL);
        params.put("courseId", courseRecord.getCourseId());
        List<TGStudyStudentCourseRel> studentCourseRelList = studentCourseRelService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(studentCourseRelList)) {
            TGStudyCourseStudentRecord courseStudentRecord;
            for(TGStudyStudentCourseRel rel : studentCourseRelList) {
                courseStudentRecord = this.initCourseStudentRecord(courseRecord, rel);
                if(StringUtils.isBlank(courseStudentRecord.getId())) {
                    this.courseStudentRecordService.save(courseStudentRecord);
                }
            }
        }
    }

    /**
     *
     * @param courseRecord
     * @param rel
     * @return
     */
    private TGStudyCourseStudentRecord initCourseStudentRecord(TGStudyCourseRecord courseRecord, TGStudyStudentCourseRel rel) {

        Map<String, Object> params = new HashMap<>();
        params.put("courseRecId", courseRecord.getId());
        params.put("studentId", rel.getStudentId());
        List<TGStudyCourseStudentRecord> courseStudentRecords = this.courseStudentRecordService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseStudentRecords)) {
            return courseStudentRecords.get(0);
        }

        TGStudyCourseStudentRecord record = new TGStudyCourseStudentRecord();
        record.setCourseRecId(courseRecord.getId());
        record.setStudentId(rel.getStudentId());
        record.setStudentName(rel.getStudentName());
        record.setCreateTime(new Date());
        return record;
    }

}
