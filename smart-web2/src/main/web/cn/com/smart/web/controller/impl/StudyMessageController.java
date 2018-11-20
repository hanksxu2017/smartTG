package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.constant.enumEntity.SystemMessageEnum;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.UserInfo;
import cn.com.smart.web.bean.entity.TGStudyClassroom;
import cn.com.smart.web.bean.entity.TGStudySchool;
import cn.com.smart.web.bean.entity.TGStudySystemMessage;
import cn.com.smart.web.bean.search.ClassroomSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudyClassroomService;
import cn.com.smart.web.service.StudySchoolService;
import cn.com.smart.web.service.StudySystemMessageService;
import org.apache.commons.lang.StringUtils;
import org.snaker.engine.access.Page;
import org.snaker.engine.access.QueryFilter;
import org.snaker.engine.entity.WorkItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/studySystemMessage")
public class StudyMessageController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudySystemMessageService systemMessageService;


    public StudyMessageController() {
        super.setSubDir("/studySystemMessage/");
    }

    /**
     * 首页系统消息
     * @param request
     * @param page
     * @return
     */
    @RequestMapping("/unProcessList")
    @ResponseBody
    public SmartResponse<TGStudySystemMessage> indexTodo(HttpServletRequest request, Page<WorkItem> page) {

        Map<String, Object> params = new HashMap<>();
	    params.put("isProcess", 0);
        SmartResponse<TGStudySystemMessage> smartResp = this.systemMessageService.findByParam(params, " level desc");

        return smartResp;
    }

	/**
	 *
	 * @return
	 */
	@RequestMapping(value = "/process")
	public ModelAndView process(String id) {
		ModelAndView modelView = new ModelAndView();

		TGStudySystemMessage systemMessage = this.systemMessageService.find(id).getData();
		systemMessage.setMessageType(SystemMessageEnum.valueOf(systemMessage.getMessageType()).getMessage());
		modelView.getModelMap().put("systemMessage", systemMessage);

		modelView.setViewName(getPageDir() + "process");
		return modelView;
	}


	/**
	 * 提交修改
	 *
	 * @return
	 */
	@RequestMapping(value = "/subProcess", method = RequestMethod.POST)
	@ResponseBody
	public SmartResponse<String> subProcess(TGStudySystemMessage systemMessage) {
		systemMessage.setProcessTime(new Date());
		systemMessage.setIsProcess(1);
		SmartResponse<String> smartResp = systemMessageService.update(systemMessage);
		return smartResp;
	}















}
