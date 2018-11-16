package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.search.StudentClassRelSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudyClassService;
import cn.com.smart.web.service.StudyStudentClassRelService;
import cn.com.smart.web.service.StudyTeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * 分班信息管理
 */
@Controller
@RequestMapping("/studyStudent/class")
public class StudyStudentClassRelController extends BaseController {

    @Autowired
    private OPService opService;

    @Autowired
    private StudyStudentClassRelService studentClassRelService;
    @Autowired
    private StudyClassService classService;
    @Autowired
    private StudyTeacherService teacherService;

    public StudyStudentClassRelController() {
        super.setSubDir("/studyStudent/class/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(StudentClassRelSearch searchParam, RequestPage page, HttpServletRequest request) {

        SmartResponse<Object> smartResp = opService.getDatas("select_study_class_rel_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelAndView = this.packListModelView(searchParam, smartResp);

        Map<String,Object> param = new HashMap<>();
        param.put("status", "NORMAL");

        modelAndView.getModelMap().put("classes", classService.findByParam(param).getDatas());
        modelAndView.getModelMap().put("teachers", teacherService.findByParam(param).getDatas());
        return modelAndView;
    }

}
