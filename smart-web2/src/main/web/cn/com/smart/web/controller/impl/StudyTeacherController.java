package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.bean.search.SchoolSearch;
import cn.com.smart.web.bean.entity.TGStudySchool;
import cn.com.smart.web.bean.search.TeacherSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudySchoolService;
import cn.com.smart.web.service.StudyTeacherService;
import com.mixsmart.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

@Controller
@RequestMapping("/studyTeacher")
public class StudyTeacherController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyTeacherService studyTeacherService;

    public StudyTeacherController() {
        super.setSubDir("/studyTeacher/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(TeacherSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_teacher_list", searchParam, page.getStartNum(), page.getPageSize());
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
        return modelView;
    }

    /**
     * 提交新增
     *
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> save(TGStudyTeacher studyTeacher) {
        studyTeacher.setCreateTime(new Date());
        SmartResponse<String> smartResp = studyTeacherService.save(studyTeacher);
        return smartResp;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotEmpty(id)) {
            TGStudyTeacher studyTeacher = studyTeacherService.find(id).getData();
            if(null != studyTeacher) {
                modelView.getModelMap().put("objBean", studyTeacher);
            }
        }
        modelView.setViewName(getURI() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studyTeacher
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyTeacher studyTeacher) {
        TGStudyTeacher studyTeacherDb = this.studyTeacherService.find(studyTeacher.getId()).getData();
        studyTeacher.setCreateTime(studyTeacherDb.getCreateTime());
        studyTeacher.setUpdateTime(new Date());
        SmartResponse<String> smartResp = studyTeacherService.update(studyTeacher);
        return smartResp;
    }

}
