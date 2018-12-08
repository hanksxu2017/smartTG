package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.CourseDateSelector;
import cn.com.smart.web.bean.search.CourseRecordSearch;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.constant.enums.IconType;
import cn.com.smart.web.constant.enums.SelectedEventType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import cn.com.smart.web.tag.bean.*;
import cn.com.smart.web.utils.DataUtil;
import cn.com.smart.web.utils.ThreadPoolUtil;
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
    private StudyTeacherService teacherService;

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
	public ModelAndView simpList(HttpSession session, CourseRecordSearch searchParam,
	                             ModelAndView modelView, RequestPage page) throws Exception {
		String uri = this.getUriPath() + "simpList";
		ModelMap modelMap = modelView.getModelMap();
		modelMap.put("courseDates", getCourseDate(searchParam));

		SmartResponse<Object> smartResp = this.opService.getDatas("courseRecord_simp_list",searchParam, page.getStartNum(), page.getPageSize());
		pageParam = new PageParam(uri, "#courseRecord-tab", page.getPage(), page.getPageSize());
		selectedEventProp = new SelectedEventProp(SelectedEventType.OPEN_TO_TARGET.getValue(),"studyStudent/courseRecHas?courseRecHas=" + searchParam.getId(),"#has-student-list","id");
		refreshBtn = new RefreshBtn(uri + "?teacherId=" + DataUtil.handleNull(searchParam.getTeacherId()), null,"#courseRecord-tab");

		modelMap.put("smartResp", smartResp);
		modelMap.put("pageParam", pageParam);
		modelMap.put("selectedEventProp", selectedEventProp);
		modelMap.put("refreshBtn", refreshBtn);
		pageParam = null;

		modelMap.put("teachers", this.teacherService.findNormal().getDatas());
		modelMap.put("searchParam", searchParam);

		modelMap.put("curDate", DateUtil.dateToStr(new Date(), "yyyy-MM-dd"));

		modelView.setViewName(this.getPageDir() + "simpList");
		return modelView;
	}

	/**
	 *
	 * @param searchParam   查询参数
	 * @return              日期列表
	 */
	private List<CourseDateSelector> getCourseDate(CourseRecordSearch searchParam) {
		Date curDate = new Date();

		String courseDate = DateUtil.dateToStr(curDate, "yyyy-MM-dd");
		if(StringUtils.isBlank(searchParam.getSelectCourseDate())) {
			// 默认使用当前日期
			searchParam.setSelectCourseDate(courseDate);
		}
		String description = courseDate + " 星期" + DataUtil.numToCN(DateUtil.getWeek(curDate));

		List<CourseDateSelector> selectorList = new ArrayList<>();
		selectorList.add(new CourseDateSelector(courseDate, description));

		Date date;
		for(int index = 1; index <= 7; index++) {
			// 前第几天
			addCourseDateSelector(selectorList, curDate, -1 * index);
			// 后第几天
			addCourseDateSelector(selectorList, curDate, index);
		}

		if(selectorList.size() > 1) {
			Collections.sort(selectorList);
		}

		return selectorList;
	}

	private void addCourseDateSelector(List<CourseDateSelector> selectorList, Date baseDate, int index) {
		Date date = DateUtil.addDay(baseDate, index);
		String courseDate = DateUtil.dateToStr(date, "yyyy-MM-dd");
		String description = courseDate + " " + getWeekStr(DateUtil.getWeek(date));
		selectorList.add(new CourseDateSelector(courseDate, description));
	}

	private String getWeekStr(int week) {
		if(0 == week) {
			return "星期天";
		}
		return "星期" + DataUtil.numToCN(week);
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

    @RequestMapping(value = "/generateDailyCourse")
    public ModelAndView generateCourseRecord() {
        ModelAndView modelView = new ModelAndView();

        modelView.getModelMap().put("startDate", DateUtil.dateToStr(DateUtil.getNextMonday(new Date()), "yyyy-MM-dd"));
        modelView.getModelMap().put("endDate", DateUtil.dateToStr(DateUtil.getNextSunday(new Date()), "yyyy-MM-dd"));

        modelView.setViewName(getPageDir() + "generateDailyCourse");
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

	@Autowired
	private StudyCourseTableService courseTableService;

	@RequestMapping(value = "/clearSystemMem")
	@ResponseBody
	public SmartResponse<String> clearSystemMem() {
		SmartResponse<String> smartResponse = new SmartResponse<>();

		this.courseTableService.clearCourseTable();

		smartResponse.setResult(IConstant.OP_SUCCESS);
		smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
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

        // 开启线程执行课时创建
	    ThreadPoolUtil.getThreadPool().execute(new GenerateWeekCourseRecordThread(startDate, courseList));

        fsResp.setResult(IConstant.OP_SUCCESS);
        fsResp.setMsg("课时已生成!");
        return fsResp;
    }

    @Autowired
    private CourseBusinessService courseBusinessService;

	/**
	 * 周课时生成线程
	 */
	class GenerateWeekCourseRecordThread implements Runnable {

    	private Date startDate;
    	private List<TGStudyCourse> courseList;

	    GenerateWeekCourseRecordThread(Date startDate, List<TGStudyCourse> courseList) {
			this.startDate = startDate;
			this.courseList = courseList;
	    }

	    @Override
	    public void run() {
		    courseBusinessService.generateWeekCourseRecord(startDate, courseList);
	    }
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
}
