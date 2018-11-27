package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.web.bean.UserInfo;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 登录
 * @author XUWENYI
 *
 */
@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {

	@Autowired
	private UserService userServ;

	@RequestMapping(method=RequestMethod.GET)
	public String index() throws Exception {
		return LOGIN;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public ModelAndView checkLogin(HttpServletRequest request,ModelAndView model, 
			String userName,String password) throws Exception {
		boolean is = false;
		String msg = null;
		HttpSession session = request.getSession();
		if(StringUtils.isNotEmpty(userName)
				&& StringUtils.isNotEmpty(password)) {

			UserInfo userInfo = null;
				SmartResponse<UserInfo> smartResp = userServ.login(userName, password);
				if(OP_SUCCESS.equals(smartResp.getResult())) {
					userInfo = smartResp.getData();
					setUserInfo2Session(session, userInfo);
					is = true;
					msg = "登录成功 ";
				} else {
					msg = "用户名或密码输入错误";
				}
				smartResp = null;
		}
		if(is) {
			RedirectView view =  new RedirectView("/index", true, true, false);
			model.setView(view);
		} else {
			ModelMap modelMap = model.getModelMap();
			modelMap.put("userName", userName);
			modelMap.put("password", password);
			modelMap.put("msg", msg);
		}
		return model;
	}

}
