package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.search.StudentClassRelSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import com.mixsmart.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * 分班信息管理
 */
@Controller
@RequestMapping("/studyStudent/course")
public class StudyStudentCourseRelController extends BaseController {

    @Autowired
    private OPService opService;

    @Autowired
    private StudyStudentCourseRelService studentCourseRelService;
    @Autowired
    private StudyClassService classService;
    @Autowired
    private StudyTeacherService teacherService;

    public StudyStudentCourseRelController() {
        super.setSubDir("/studyStudent/course/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(StudentClassRelSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_course_rel_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelAndView = this.packListModelView(searchParam, smartResp);
        return modelAndView;
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method= RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> delete(String id) {
        SmartResponse<String> smartResp = new SmartResponse<String>();
        if(StringUtils.isNotEmpty(id)) {
            smartResp = studentCourseRelService.delete(id);
        }
        return smartResp;
    }

}
