package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.search.ClassSearch;
import cn.com.smart.web.bean.search.CourseStudentRecordSearch;
import cn.com.smart.web.bean.search.WeekInfo;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
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
@RequestMapping("/studyCourse/studentRecord")
public class StudyCourseStudentRecordController extends BaseController {

    @Autowired
    private OPService opService;

    @Autowired
    private StudyClassService classService;
    @Autowired
    private StudyTeacherService teacherService;

    public StudyCourseStudentRecordController() {
        super.setSubDir("/studyCourse/studentRecord/");
    }



    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(CourseStudentRecordSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_course_student_record_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelAndView = this.packListModelView(searchParam, smartResp);

        // 增加自定义按钮
        this.addCustomBtn(modelAndView.getModelMap());

        Map<String, Object> params = new HashMap<>();
        params.put("status", IConstant.STATUS_NORMAL);
        modelAndView.getModelMap().put("classes", this.classService.findByParam(params).getDatas());
        modelAndView.getModelMap().put("teachers", this.teacherService.findByParam(params).getDatas());
        modelAndView.getModelMap().put("weeks", getWeekInfo());
        modelAndView.getModelMap().put("searchParam", searchParam);

        return modelAndView;
    }

    /**
     *
     * @param modelMap
     */
    private void addCustomBtn(Map<String, Object> modelMap) {
        CustomBtn customBtnCourse = new CustomBtn("studentSignIn", "学生签到", "学生签到", this.getUriPath() + "studentSignIn","glyphicon-list-alt", BtnPropType.SelectType.ONE.getValue());
        customBtnCourse.setWidth("500");

        customBtns = new ArrayList<>(1);
        customBtns.add(customBtnCourse);
        modelMap.put("customBtns", customBtns);
    }

    private List<WeekInfo> getWeekInfo() {
        List<WeekInfo> weeks = new ArrayList<>();
        weeks.add(new WeekInfo("2018-11-5 ~ 2018-11-11", "2018-11-11"));
        weeks.add(new WeekInfo("2018-11-12 ~ 2018-11-18", "2018-11-18"));
        weeks.add(new WeekInfo("2018-11-19 ~ 2018-11-25", "2018-11-25"));
        weeks.add(new WeekInfo("2018-11-26 ~ 2018-12-2", "2018-12-2"));
        return weeks;
    }


}
