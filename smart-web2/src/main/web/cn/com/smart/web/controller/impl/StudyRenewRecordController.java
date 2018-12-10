package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyClassroom;
import cn.com.smart.web.bean.entity.TGStudyRenewRecord;
import cn.com.smart.web.bean.entity.TGStudySchool;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.search.ClassroomSearch;
import cn.com.smart.web.bean.search.RenewRecordSearch;
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
@RequestMapping("/studyRenewRecord")
public class StudyRenewRecordController extends BaseController {

    @Autowired
    private OPService opService;

    @Autowired
    private StudyRenewRecordService renewRecordService;

    public StudyRenewRecordController() {
        super.setSubDir("/studyRenewRecord/");
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(RenewRecordSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("renew_record_list", searchParam, page.getStartNum(), page.getPageSize());
        return this.packListModelView(searchParam, smartResp, page);
    }

    @Autowired
    private StudyStudentService studentService;

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();

        TGStudyRenewRecord renewRecord = this.renewRecordService.find(id).getData();
        modelView.getModelMap().put("renewRecord", renewRecord);

	    TGStudyStudent student = this.studentService.find(renewRecord.getStudentId()).getData();
	    modelView.getModelMap().put("student", student);

        modelView.setViewName(getPageDir() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyRenewRecord renewRecord) {
	    TGStudyRenewRecord renewRecordDb = this.renewRecordService.find(renewRecord.getId()).getData();
	    renewRecordDb.setAmount(renewRecord.getAmount());
	    renewRecordDb.setCourseCount(renewRecord.getCourseCount());
	    renewRecordDb.setDescription(renewRecord.getDescription());

        return this.renewRecordService.update(renewRecordDb);
    }

}
