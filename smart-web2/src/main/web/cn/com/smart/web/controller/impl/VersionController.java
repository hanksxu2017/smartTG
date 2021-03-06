package cn.com.smart.web.controller.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import cn.com.smart.filter.bean.FilterParam;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.UserInfo;
import cn.com.smart.web.bean.VersionSearch;
import cn.com.smart.web.bean.entity.TNVersion;
import cn.com.smart.web.constant.enums.VersionType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.VersionService;
import cn.com.smart.web.tag.bean.DelBtn;
import cn.com.smart.web.tag.bean.EditBtn;
import cn.com.smart.web.tag.bean.PageParam;
import cn.com.smart.web.tag.bean.RefreshBtn;

import com.mixsmart.utils.StringUtils;

/**
 * 版本控制器
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Controller
@RequestMapping("/version")
public class VersionController extends BaseController {

	@Autowired
	private OPService opServ;
	@Autowired
	private VersionService versionServ;

	public VersionController() {
		super.setSubDir("/version/");
	}
	
	/**
	 * 
	 * @param session
	 * @param searchParam
	 * @param page
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(HttpSession session, VersionSearch searchParam, RequestPage page) {
		SmartResponse<Object> smartResp = opServ.getDatas("version_mgr_list", searchParam, page.getStartNum(), page.getPageSize());
		ModelAndView modelView = this.packListModelView(searchParam, smartResp);
		return modelView;
	}


	@RequestMapping("/add")
	public ModelAndView add() {
		ModelAndView modelView = new ModelAndView();
		modelView.getModelMap().put("version", versionServ.getLastVersionAddOne(VersionType.PC));
		modelView.setViewName(getPageDir() + "add");
		return modelView;
	}
	
	/**
	 * 保存
	 * @return
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public SmartResponse<String> save(HttpSession session,TNVersion version) {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		if(null != version && StringUtils.isNotEmpty(version.getVersion()) 
				&& StringUtils.isNotEmpty(version.getDescr())) {
			if(StringUtils.isEmpty(version.getUpdateDate())) {
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				version.setUpdateDate(formatter.format(new Date()));
			}
			UserInfo userInfo = getUserInfoFromSession(session);
			version.setVersion(version.getVersion().toUpperCase());
			version.setUserId(userInfo.getId());
			version.setDescr(escapeDescr(version.getDescr()));
			version.setType(VersionType.PC.getValue());
			smartResp = versionServ.save(version);
		}
		return smartResp;
	}
	
	@RequestMapping("/edit")
	public ModelAndView edit(String id) {
		ModelAndView modelView = new ModelAndView();
		if(StringUtils.isNotEmpty(id)) {
			TNVersion version = versionServ.find(id).getData();
			if(null != version) {
				version.setDescr(unescapeDescr(version.getDescr()));
				modelView.getModelMap().put("objBean", version);
			}
		}
		modelView.setViewName(getPageDir() + "edit");
		return modelView;
	}
	
	/**
	 * 更新
	 * @param version
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public SmartResponse<String> update(TNVersion version) {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		if(null != version && StringUtils.isNotEmpty(version.getId()) 
				&& StringUtils.isNotEmpty(version.getVersion()) 
				&& StringUtils.isNotEmpty(version.getDescr())) {
			version.setType(VersionType.PC.getValue());
			version.setVersion(version.getVersion().toUpperCase());
			version.setDescr(escapeDescr(version.getDescr()));
			smartResp = versionServ.update(version);
		}
		return smartResp;
	}
	
	/**
	 * 更新
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public SmartResponse<String> delete(String id) {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		if(StringUtils.isNotEmpty(id)) {
			smartResp = versionServ.delete(id);
		}
		return smartResp;
	}
	
	/**
	 * 查看
	 * @param id
	 * @return
	 */
	@RequestMapping("/view")
	public ModelAndView view(String id) {
		ModelAndView modelView = new ModelAndView();
		if(StringUtils.isNotEmpty(id)) {
			SmartResponse<TNVersion> smartResp = versionServ.find(id);
			modelView.getModelMap().put("smartResp", smartResp);
		}
		modelView.setViewName(getPageDir() + "view");
		return modelView;
	}
	
	/**
	 * 查看最近更新的10条记录
	 * @return
	 */
	@RequestMapping("/updateLog")
	public ModelAndView updateLog() {
		ModelAndView modelView = new ModelAndView();
		List<TNVersion> versions = versionServ.getVersion(VersionType.PC, 10);
		modelView.getModelMap().put("versions", versions);
		versions = null;
		modelView.setViewName(getPageDir() + "updateLog");
		return modelView;
	}
	
	private String escapeDescr(String descr) {
		descr = StringEscapeUtils.escapeHtml4(descr);
		descr = descr.replace(" ", "&nbsp;");
		descr = descr.replaceAll("\n\r|\n", "<br />");
		return descr;
	}
	
	private String unescapeDescr(String descr) {
		descr = StringEscapeUtils.unescapeHtml4(descr);
		descr = descr.replaceAll("<br />", "\n");
		descr = descr.replace("&nbsp;", " ");
		return descr;
	}


}
