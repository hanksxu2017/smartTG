package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.search.ClassSearch;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudyCourseRecordService;
import cn.com.smart.web.service.StudyCourseService;
import cn.com.smart.web.service.StudyStudentCourseRelService;
import cn.com.smart.web.tag.bean.CustomBtn;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/studyCourse/record")
public class StudyCourseRecordController extends BaseController {

    @Autowired
    private OPService opService;

    @Autowired
    private StudyCourseRecordService courseRecordService;


    public StudyCourseRecordController() {
        super.setSubDir("/studyCourse/record/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(ClassSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_course_record_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelAndView = this.packListModelView(searchParam, smartResp);

        // 增加自定义按钮
        this.addChooseUnitBtn(modelAndView.getModelMap());
        return modelAndView;
    }

    /**
     *
     * @param modelMap
     */
    private void addChooseUnitBtn(Map<String, Object> modelMap) {
        CustomBtn customBtn = new CustomBtn("generateCourseRecord", "生成每日课时", "生成每日课时", this.getSubDir() + "generateCourseRecord","glyphicon-list-alt", BtnPropType.SelectType.NONE.getValue());
        customBtn.setWidth("500");
        customBtns = new ArrayList<>(1);
        customBtns.add(customBtn);
        modelMap.put("customBtns", customBtns);
    }

    @RequestMapping(value = "/generateCourseRecord")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();

        modelView.getModelMap().put("startDate", "2018-11-19");
        modelView.getModelMap().put("endDate", "2018-11-25");

        modelView.setViewName(getURI() + "generateCourseRecord");
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
                this.courseRecordService.save(courseRecord);
                count++;
            }
        }

        fsResp.setResult(IConstant.OP_SUCCESS);
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
            return null;
        }

        TGStudyCourseRecord courseRecord = new TGStudyCourseRecord();

        courseRecord.setCourseId(course.getId());
        courseRecord.setCourseDate(courseDate);
        courseRecord.setCourseTime(course.getCourseTime());

        courseRecord.setClassId(course.getClassId());
        courseRecord.setClassName(course.getClassName());
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

    private Date getWeekDate(String weekInfo, Date startDate) {

        if(StringUtils.equals("星期一", weekInfo)) {
            return startDate;
        } else if(StringUtils.equals("星期二", weekInfo)) {
            return DateUtil.addDay(startDate, 1);
        } else if(StringUtils.equals("星期三", weekInfo)) {
            return DateUtil.addDay(startDate, 2);
        } else if(StringUtils.equals("星期四", weekInfo)) {
            return DateUtil.addDay(startDate, 3);
        } else if(StringUtils.equals("星期五", weekInfo)) {
            return DateUtil.addDay(startDate, 4);
        } else if(StringUtils.equals("星期六", weekInfo)) {
            return DateUtil.addDay(startDate, 5);
        } else if(StringUtils.equals("星期天", weekInfo)) {
            return DateUtil.addDay(startDate, 6);
        } else {
            return null;
        }
    }



}
