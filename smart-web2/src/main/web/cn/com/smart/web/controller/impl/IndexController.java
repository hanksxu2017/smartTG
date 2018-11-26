package cn.com.smart.web.controller.impl;

import cn.com.smart.web.bean.entity.TNVersion;
import cn.com.smart.web.constant.enums.VersionType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.SubSystemService;
import cn.com.smart.web.service.VersionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * 首页
 * @author XUWENYI
 *
 */
@Controller
@RequestMapping("/index")
public class IndexController extends BaseController {
	
	@Autowired
	private VersionService versionServ;
	@Autowired
	private SubSystemService subSysServ;
	
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, String forward) throws Exception {
		ModelAndView modelView = new ModelAndView();
		TNVersion version = versionServ.getNewVersion(VersionType.PC);
		if(null == version) {
			version = new TNVersion();
			version.initVersion();
		}
		ModelMap modelMap = modelView.getModelMap();
		modelMap.put("version", version);
		modelMap.put("forward", forward);
		modelView.setViewName("index");
		return modelView;
	}
	
	/**
	 * 首页
	 * @param request
	 * @param modelView
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/welcome")
	public ModelAndView welcome(HttpServletRequest request,ModelAndView modelView) throws Exception {
		modelView.setViewName("welcome");
		return modelView;
	}
	
}
