package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.bean.entity.TNRole;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import com.mixsmart.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/studyClass")
public class StudyClassController extends BaseController {

    @Autowired
    private OPService opService;

    public StudyClassController() {
        super.setSubDir("/studyClass/");
    }

    @RequestMapping("/index")
    public ModelAndView index(ModelAndView modelView) throws Exception {
        modelView.setViewName(this.getPageDir() + "index");
        return modelView;
    }

    @RequestMapping("/teacherHas")
    public ModelAndView teacherHas(ModelAndView modelView,String id) throws Exception {
        if(StringUtils.isNotEmpty(id)) {
            SmartResponse<Object> smartResp = this.opService.find(TGStudyTeacher.class, id);
            ModelMap modelMap = modelView.getModelMap();
            modelMap.put("id", id);
            if(smartResp.getResult().equals(OP_SUCCESS)) {
                TGStudyTeacher teacher = (TGStudyTeacher) smartResp.getData();
                String name = (null != teacher) ? teacher.getName() : null;
                modelMap.put("name", name);
            }
        }
        modelView.setViewName(this.getPageDir() + "teacherHas");
        return modelView;
    }

    @RequestMapping("/studentHas")
    public ModelAndView studentHas(ModelAndView modelView,String id) throws Exception {
        if(StringUtils.isNotEmpty(id)) {
            SmartResponse<Object> smartResp = this.opService.find(TGStudyStudent.class, id);
            ModelMap modelMap = modelView.getModelMap();
            modelMap.put("id", id);
            if(smartResp.getResult().equals(OP_SUCCESS)) {
                TGStudyStudent student = (TGStudyStudent) smartResp.getData();
                String name = (null != student) ? student.getName() : null;
                modelMap.put("name", name);
            }
        }
        modelView.setViewName(this.getPageDir() + "studentHas");
        return modelView;
    }



}
