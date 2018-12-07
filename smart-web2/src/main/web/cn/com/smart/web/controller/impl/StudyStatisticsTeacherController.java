package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.course.*;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.CourseSearch;
import cn.com.smart.web.bean.search.RenewRecordSearch;
import cn.com.smart.web.bean.search.StatisticsTeacherSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import cn.com.smart.web.utils.DataUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Slf4j
@Controller
@RequestMapping("/studyStatistics/teacher")
public class StudyStatisticsTeacherController extends BaseController {

    @Autowired
    private OPService opService;

    @Autowired
    private StudyTeacherService teacherService;

    public StudyStatisticsTeacherController() {
        super.setSubDir("/studyStatistics/teacher/");
    }


    /**
     * @param searchParam   查询参数对象
     * @param page          分页参数对象
     * @return              JSP页面对象
     */
	/**
	 * @param searchParam
	 * @param page
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(StatisticsTeacherSearch searchParam, RequestPage page) {
		if(StringUtils.isBlank(searchParam.getMonth())) {
			searchParam.setMonth(DateUtil.dateToStr(DateUtil.addMonth(new Date(), -1), "yyyyMM"));
		} else {
			searchParam.setMonth(searchParam.getMonth().replaceAll("/",""));
		}
		SmartResponse<Object> smartResp = opService.getDatas("statistics_teacher_list", searchParam, page.getStartNum(), page.getPageSize());

		ModelAndView modelAndView = this.packListModelView(searchParam, smartResp, page);
		modelAndView.getModelMap().put("teachers", teacherService.findNormal().getDatas());
		modelAndView.getModelMap().put("monthList", DataUtil.getMonthList());

		return modelAndView;
	}

}
