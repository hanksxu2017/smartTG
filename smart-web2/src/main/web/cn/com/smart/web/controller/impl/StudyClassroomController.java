package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyClassRoom;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.bean.search.ClassroomSearch;
import cn.com.smart.web.bean.search.TeacherSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudyClassroomService;
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
@RequestMapping("/studyClassroom")
public class StudyClassroomController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyClassroomService studyClassroomService;
    @Autowired
    private StudySchoolService studySchoolService;

    public StudyClassroomController() {
        super.setSubDir("/studyClassroom/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(ClassroomSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_classroom_list", searchParam, page.getStartNum(), page.getPageSize());
        return this.packListModelView(searchParam, smartResp);
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() {
        ModelAndView modelView = new ModelAndView();
        modelView.getModelMap().put("schools", studySchoolService.findAll().getDatas());
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
    public SmartResponse<String> save(TGStudyClassRoom studyClassRoom) {
        studyClassRoom.setCreateTime(new Date());
        SmartResponse<String> smartResp = studyClassroomService.save(studyClassRoom);
        return smartResp;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotEmpty(id)) {
            TGStudyClassRoom studyClassRoom = studyClassroomService.find(id).getData();
            if(null != studyClassRoom) {
                modelView.getModelMap().put("objBean", studyClassRoom);
            }
            modelView.getModelMap().put("schools", studySchoolService.findAll().getDatas());
        }
        modelView.setViewName(getPageDir() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studyClassRoom
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyClassRoom studyClassRoom) {
        TGStudyClassRoom studyClassRoomDb = this.studyClassroomService.find(studyClassRoom.getId()).getData();
        studyClassRoom.setCreateTime(studyClassRoomDb.getCreateTime());
        studyClassRoom.setUpdateTime(new Date());
        SmartResponse<String> smartResp = studyClassroomService.update(studyClassRoom);
        return smartResp;
    }

}
