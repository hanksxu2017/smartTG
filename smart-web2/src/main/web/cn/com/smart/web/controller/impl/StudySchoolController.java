package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.search.SchoolSearch;
import cn.com.smart.web.bean.entity.TGStudySchool;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudySchoolService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/studySchool")
public class StudySchoolController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudySchoolService studySchoolService;

    public StudySchoolController() {
        super.setSubDir("/studySchool/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(SchoolSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_school_list", searchParam, page.getStartNum(), page.getPageSize());
        return this.packListModelView(searchParam, smartResp);
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getPageDir() + "add");
        return modelView;
    }

    /**
     * 提交新增
     *
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> save(TGStudySchool studySchool) {
        SmartResponse<String> smartResp = studySchoolService.save(studySchool);
        return smartResp;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotEmpty(id)) {
            TGStudySchool studySchool = studySchoolService.find(id).getData();
            if(null != studySchool) {
                modelView.getModelMap().put("objBean", studySchool);
            }
        }
        modelView.setViewName(getPageDir() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studySchool
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudySchool studySchool) {
        SmartResponse<String> smartResp = studySchoolService.update(studySchool);
        return smartResp;
    }

}
