package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyClass;
import cn.com.smart.web.bean.entity.TGStudyClassRoom;
import cn.com.smart.web.bean.search.ClassSearch;
import cn.com.smart.web.bean.search.ClassroomSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import com.mixsmart.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

@Controller
@RequestMapping("/studyClass")
public class StudyClassController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyTeacherService studyTeacherService;
    @Autowired
    private StudyClassService studyClassService;


    public StudyClassController() {
        super.setSubDir("/studyClass/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(ClassSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_class_list", searchParam, page.getStartNum(), page.getPageSize());
        return this.packListModelView(searchParam, smartResp);
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() {
        ModelAndView modelView = new ModelAndView();
        modelView.getModelMap().put("teachers", studyTeacherService.findAll().getDatas());
        modelView.setViewName(getURI() + "add");
        return modelView;
    }

    /**
     * 提交新增
     *
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> save(TGStudyClass studyClass) {
        studyClass.setCreateTime(new Date());
        SmartResponse<String> smartResp = studyClassService.save(studyClass);
        return smartResp;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotEmpty(id)) {
            TGStudyClass studyClass = studyClassService.find(id).getData();
            if(null != studyClass) {
                modelView.getModelMap().put("objBean", studyClass);
            }
            modelView.getModelMap().put("teachers", studyTeacherService.findAll().getDatas());
        }
        modelView.setViewName(getURI() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studyClass
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyClass studyClass) {
        TGStudyClass studyClassDb = this.studyClassService.find(studyClass.getId()).getData();
        studyClass.setCreateTime(studyClassDb.getCreateTime());
        studyClass.setUpdateTime(new Date());
        SmartResponse<String> smartResp = studyClassService.update(studyClass);
        return smartResp;
    }

}
