package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyClassroom;
import cn.com.smart.web.bean.entity.TGStudySchool;
import cn.com.smart.web.bean.search.ClassroomSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudyClassroomService;
import cn.com.smart.web.service.StudySchoolService;
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
@RequestMapping("/studyClassroom")
public class StudyClassroomController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyClassroomService classroomService;
    @Autowired
    private StudySchoolService schoolService;

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
        SmartResponse<Object> smartResp = opService.getDatas("classroom_list", searchParam, page.getStartNum(), page.getPageSize());
        return this.packListModelView(searchParam, smartResp);
    }

    /**
     *
     * @return
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() {
        ModelAndView modelView = new ModelAndView();

        modelView.getModelMap().put("schools", schoolService.findAll().getDatas());
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
    public SmartResponse<String> save(TGStudyClassroom studyClassRoom) {
        studyClassRoom.setCreateTime(new Date());
        SmartResponse<String> smartResp = classroomService.save(studyClassRoom);
        return smartResp;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotEmpty(id)) {
            TGStudyClassroom studyClassRoom = classroomService.find(id).getData();
            if(null != studyClassRoom) {
                modelView.getModelMap().put("objBean", studyClassRoom);
            }

            Map<String, Object> params = new HashMap<>();
            params.put("status", IConstant.STATUS_NORMAL);
            SmartResponse<TGStudySchool> smartResponse = this.schoolService.findByParam(params);
            if(StringUtils.equals(IConstant.OP_SUCCESS, smartResponse.getResult()) &&
                smartResponse.getTotalNum() > 0) {
                modelView.getModelMap().put("schools", smartResponse.getDatas());
            }
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
    public SmartResponse<String> update(TGStudyClassroom studyClassRoom) {
        TGStudyClassroom studyClassRoomDb = this.classroomService.find(studyClassRoom.getId()).getData();
        studyClassRoom.setCreateTime(studyClassRoomDb.getCreateTime());
        studyClassRoom.setUpdateTime(new Date());
        SmartResponse<String> smartResp = classroomService.update(studyClassRoom);
        return smartResp;
    }

    @RequestMapping(value = "/queryBySchool", method = RequestMethod.GET)
    @ResponseBody
    public SmartResponse<TGStudyClassroom> queryBySchool(String schoolId) {
        Map<String, Object> params = new HashMap<>();
        params.put("status", IConstant.STATUS_NORMAL);
        params.put("schoolId", schoolId);
        SmartResponse<TGStudyClassroom> smartResponse = this.classroomService.findByParam(params);
        return smartResponse;
    }

}
