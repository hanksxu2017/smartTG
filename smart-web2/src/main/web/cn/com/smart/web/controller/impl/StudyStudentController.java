package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.search.StudentSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudyStudentService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;

@Controller
@RequestMapping("/studyStudent")
public class StudyStudentController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyStudentService studyStudentService;

    public StudyStudentController() {
        super.setSubDir("/studyStudent/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(StudentSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_student_list", searchParam, page.getStartNum(), page.getPageSize());
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
    public SmartResponse<String> save(TGStudyStudent studyStudent) {
        studyStudent.setCreateTime(new Date());

        short parentType = studyStudent.getParentType();
        if(1 == parentType) {
            studyStudent.setParentName(studyStudent.getParentName() + "(父亲)");
        } else if(2 == parentType) {
            studyStudent.setParentName(studyStudent.getParentName() + "(母亲)");
        }

        studyStudent.setRemainCourse(studyStudent.getTotalCourse());

        SmartResponse<String> smartResp = studyStudentService.save(studyStudent);
        return smartResp;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotBlank(id)) {
            TGStudyStudent studyStudent = studyStudentService.find(id).getData();
            if(null != studyStudent) {
                modelView.getModelMap().put("objBean", studyStudent);
            }
        }
        modelView.setViewName(getURI() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studyStudent
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyStudent studyStudent) {
        TGStudyStudent studyStudentDb = this.studyStudentService.find(studyStudent.getId()).getData();
        studyStudent.setCreateTime(studyStudentDb.getCreateTime());
        studyStudent.setUpdateTime(new Date());
        SmartResponse<String> smartResp = studyStudentService.update(studyStudent);
        return smartResp;
    }

}
