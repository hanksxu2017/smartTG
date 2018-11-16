package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.search.ClassSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/studyCourse")
public class StudyCourseController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyCourseService studyCourseService;
    @Autowired
    private StudyClassService studyClassService;
    @Autowired
    private StudyClassroomService studyClassroomService;
    @Autowired
    private StudyTeacherService studyTeacherService;


    public StudyCourseController() {
        super.setSubDir("/studyCourse/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(ClassSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_course_list", searchParam, page.getStartNum(), page.getPageSize());
        return this.packListModelView(searchParam, smartResp);
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getURI() + "add");

        Map<String, Object> params = new HashMap<>();
        params.put("status", "NORMAL");

        modelView.getModelMap().put("classes", studyClassService.findByParam(params).getDatas());
        modelView.getModelMap().put("classrooms", studyClassroomService.findByParam(params).getDatas());

        return modelView;
    }

    /**
     * 提交新增
     *
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> save(TGStudyCourse studyCourse) {
        SmartResponse<String> smartResp = new SmartResponse<String>();
        if(this.checkCourseConflict(studyCourse)) {
            smartResp.setResult(IConstant.OP_FAIL);
            smartResp.setMsg("课程存在冲突,保存失败");
        } else {
            studyCourse.setCreateTime(new Date());
            smartResp = studyCourseService.save(studyCourse);
        }
        return smartResp;
    }

    /**
     * 检查课程安排是否存在冲突
     * @param studyCourse
     * @return
     */
    private boolean checkCourseConflict(TGStudyCourse studyCourse) {
        String courseTime = studyCourse.getCourseTime();
        String weekInfo = studyCourse.getWeekInfo();
        // TODO


        return false;
    }



    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotBlank(id)) {
            TGStudyCourse studyCourse = studyCourseService.find(id).getData();
            if(null != studyCourse) {
                modelView.getModelMap().put("objBean", studyCourse);
            }
        }

        Map<String, Object> params = new HashMap<>();
        params.put("status", "NORMAL");

        modelView.getModelMap().put("classes", studyClassService.findByParam(params).getDatas());
        modelView.getModelMap().put("classrooms", studyClassroomService.findByParam(params).getDatas());

        modelView.setViewName(getURI() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studyCourse
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyCourse studyCourse) {
        TGStudyCourse studyCourseDb = this.studyCourseService.find(studyCourse.getId()).getData();
        studyCourse.setCreateTime(studyCourseDb.getCreateTime());
        studyCourse.setUpdateTime(new Date());
        SmartResponse<String> smartResp = studyCourseService.update(studyCourse);
        return smartResp;
    }

}
