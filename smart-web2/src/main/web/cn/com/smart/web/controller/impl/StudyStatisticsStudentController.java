package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.course.CourseTable;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.search.CourseSearch;
import cn.com.smart.web.bean.search.StatisticsStudentSearch;
import cn.com.smart.web.bean.search.StatisticsTeacherSearch;
import cn.com.smart.web.bean.statistics.student.StudentStatisticsDataHandle;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudyStatisticsService;
import cn.com.smart.web.service.StudyStudentService;
import cn.com.smart.web.service.StudyTeacherService;
import cn.com.smart.web.utils.DataUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Slf4j
@Controller
@RequestMapping("/studyStatistics/student")
public class StudyStatisticsStudentController extends BaseController {

    @Autowired
    private OPService opService;

    public StudyStatisticsStudentController() {
        super.setSubDir("/studyStatistics/student/");
    }

	/**
	 * @param searchParam   查询参数对象
	 * @param page          分页参数对象
	 * @return              JSP页面对象
	 */
	@RequestMapping("/list")
	public ModelAndView list(StatisticsStudentSearch searchParam, RequestPage page) {
		if(StringUtils.isBlank(searchParam.getMonth())) {
			searchParam.setMonth(DateUtil.dateToStr(new Date(), "yyyyMM"));
		} else {
			searchParam.setMonth(searchParam.getMonth().replaceAll("/",""));
		}
		ModelAndView modelView = new ModelAndView();
		modelView.getModelMap().put("searchParam", searchParam);

		modelView.getModelMap().put("monthList", DataUtil.getMonthList());
		modelView.setViewName(this.getPageDir() + "table");
		return modelView;
	}

	@Autowired
	private StudyStatisticsService statisticsService;

	@Autowired
	private StudyStudentService studentService;

	@RequestMapping(value = "/generateStatisticsTable", method = RequestMethod.GET)
	@ResponseBody
	public SmartResponse<StudentStatisticsDataHandle> generateStatisticsTable(StatisticsStudentSearch searchParam, RequestPage page) {
		SmartResponse<StudentStatisticsDataHandle> smartResponse = new SmartResponse<>();

		List<TGStudyStudent> studentList = this.studentService.findNormalForPage(page.getPage(), page.getPageSize(), "remain_course, create_time desc").getDatas();

		// TODO 如果查询往期月份的统计师数据,直接从数据库读取

		smartResponse.setData(this.statisticsService.doStudentStatistics(studentList));
		smartResponse.setResult(IConstant.OP_SUCCESS);
		smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
		return smartResponse;
	}

}
