package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.constant.enumEntity.SystemMessageEnum;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudySystemMessage;
import cn.com.smart.web.bean.search.SystemMessageSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudySystemMessageService;
import cn.com.smart.web.tag.bean.EditBtn;
import cn.com.smart.web.tag.bean.PageParam;
import cn.com.smart.web.tag.bean.RefreshBtn;
import org.apache.commons.lang.StringUtils;
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
     * @return
     */
    @RequestMapping("/unProcessList")
    @ResponseBody
    public SmartResponse<TGStudySystemMessage> indexTodo(HttpServletRequest request) {

        Map<String, Object> params = new HashMap<>();
	    params.put("isProcess", IConstant.IS_PROCESS_NO);
        SmartResponse<TGStudySystemMessage> smartResp = this.systemMessageService.findByParam(params, " level desc");

        return smartResp;
    }

    /**
     * @param searchParam
     * @param page
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView list(SystemMessageSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("system_message_list", searchParam, page.getStartNum(), page.getPageSize());
        ModelAndView modelView = new ModelAndView();
        Map<String, Object> modelMap = modelView.getModelMap();
        editBtn = new EditBtn("edit", this.getUriPath() + "edit", null, "修改", "800");
//        delBtn = new DelBtn(this.getUriPath() + "delete", "确定要删除选中的通知吗？", this.getUriPath() + "list", null, null);
        refreshBtn = new RefreshBtn(this.getUriPath() + "list", null, null);

        modelMap.put("editBtn", editBtn);
//        modelMap.put("delBtn", delBtn);

	    pageParam = new PageParam(this.getUriPath() + "list", null, page.getPage(), page.getPageSize());
        modelMap.put("pageParam", pageParam);
        modelMap.put("refreshBtn", refreshBtn);
        modelMap.put("smartResp", smartResp);
        modelMap.put("searchParam", searchParam);

        modelView.setViewName(this.getPageDir() + "list");
        return modelView;
    }

	/**
	 *
	 * @return
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView process(String id) {
		ModelAndView modelView = new ModelAndView();

		TGStudySystemMessage systemMessage = this.systemMessageService.find(id).getData();
		SystemMessageEnum systemMessageEnum = SystemMessageEnum.valueOf(systemMessage.getMessageType());
		systemMessage.setMessageType(systemMessageEnum.getMessage());
		modelView.getModelMap().put("systemMessage", systemMessage);

		modelView.setViewName(getPageDir() + "edit");
		return modelView;
	}

	/**
	 * 提交修改
	 *
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public SmartResponse<String> update(TGStudySystemMessage systemMessage) {
        SmartResponse<String> smartResp;
                TGStudySystemMessage systemMessageDb = this.systemMessageService.find(systemMessage.getId()).getData();
	    if(StringUtils.equals(systemMessage.getIsProcess(), IConstant.IS_PROCESS_YES)) {
            systemMessageDb.setProcessDesc(systemMessage.getProcessDesc());
		    systemMessageDb.setProcessTime(new Date());
		    systemMessageDb.setIsProcess(IConstant.IS_PROCESS_YES);
            smartResp = systemMessageService.update(systemMessageDb);
        } else {
            smartResp = new SmartResponse<>();
            smartResp.setResult(IConstant.OP_SUCCESS);
            smartResp.setMsg("暂不处理");
        }

		return smartResp;
	}

















}
