package cn.com.smart.web.interceptor;

import cn.com.smart.init.config.InitSysConfig;
import cn.com.smart.web.constant.IActionConstant;
import cn.com.smart.web.helper.HttpRequestHelper;
import cn.com.smart.web.utils.DataUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 访问控制拦截
 * @author XUWENYI
 *
 */
public class ACLInterceptor implements HandlerInterceptor {
  
	private List<String> excludeMaps;
	private List<String> authUriList;
	private String resSuffix;

	private final static Logger log = LoggerFactory.getLogger(ACLInterceptor.class);
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object obj, Exception arg3)
			throws Exception {
		String currentUri = HttpRequestHelper.getCurrentUri(request);
		long startTime = (Long)request.getAttribute("startTime");
		Date responseTime = new Date();
		long endTime = responseTime.getTime();
		long useTime = endTime - startTime;
		log.debug("请求["+currentUri+"]用时："+useTime+"毫秒");
		if(!isRes(currentUri)) {
			response.setHeader("Cache-Control","no-cache");
			response.setHeader("Pragrma","no-cache");
			response.setDateHeader("Expires",-1);
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
			Object obj, ModelAndView modelAndView) throws Exception {
		String currentUri = HttpRequestHelper.getCurrentUri(request);
		if(isRes(currentUri) || null == modelAndView) {
			return;
		}
		ModelMap modelMap = modelAndView.getModelMap();
		modelMap.put("project", InitSysConfig.getInstance().getProjectInfo());
		if(!modelMap.containsKey("currentUri")) {
		    modelMap.put("currentUri", HttpRequestHelper.getCurrentUri(request));
		} 
		if(!modelMap.containsKey("currentUriParam")) {
		    modelMap.put("currentUriParam", HttpRequestHelper.getCurrentUriParam(request));
		}
		//请求参数添加到map里面
		Map<String,String[]> curParamMaps = request.getParameterMap();
		if(null != curParamMaps && curParamMaps.size()>0) {
			Set<Map.Entry<String, String[]>> items = curParamMaps.entrySet();
			for (Map.Entry<String, String[]> item : items) {
				if(item.getValue().length<2) {
					String value = item.getValue()[0];
					if(StringUtils.isNotEmpty(value) && value.startsWith("%")) {
						value = URLDecoder.decode(value, "UTF-8");
					}
					if(value.length()<100 && !modelMap.containsKey(item.getKey())) {
						modelMap.put(item.getKey(), value);
					}
				}
			}
		} //if;
		RedirectView redirectView = ((RedirectView)modelAndView.getView());
		if(null == redirectView || !redirectView.isRedirectView()) {
			if(isLogin(request)) {
				modelMap.put("userInfo", HttpRequestHelper.getUserInfoFromSession(request));
			}
		}
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object obj) throws Exception {
		String currentUriParam = HttpRequestHelper.getCurrentUriParam(request);
		//获取域名或IP地址
		String serverName = request.getServerName();
		String domainForward = InitSysConfig.getInstance().getValue("domain.forward");
		//如果是通过IP或域名访问的地址，和配置文件中配置的IP或域名不一致；
		//则采用配置文件中的IP或域名访问（即：根据配置的域名或IP重新跳转）.
		if("1".equals(domainForward)) {
			String domain = InitSysConfig.getInstance().getValue("domain.name");
			if(StringUtils.isNotEmpty(domain) && !serverName.equals(domain)) {
				String path = request.getContextPath();
				String basePath = request.getScheme()+"://"+domain+":"+request.getServerPort()+path+"/";
				response.sendRedirect(basePath+currentUriParam);
				return false;
			}
		}
		String currentUri = HttpRequestHelper.getCurrentUri(request);
		boolean is = false;
		Date currentTime = new Date();
		long startTime = currentTime.getTime();
		request.setAttribute("startTime", startTime);

		if(isLogin(request)) {
			is = true;
		} else {
			if(!isRes(currentUri)) {
				if(!isExclude(currentUri)) {
					String loginUri = "/login";
					loginUri = handleRedirectUri(request, loginUri);
					response.sendRedirect(loginUri);
				} else {
					is = true;
				}
			} else {
				is = true;
			}

		}
		return is;
	}


	/**
	 * 是否排除
	 * @param currentUri
	 * @return
	 */
	private boolean isExclude(String currentUri) {
		boolean is = false;
		is = currentUri.startsWith("#");
		is = is ? is : isUriContains(excludeMaps, currentUri);
		return is;
	}

	/**
	 * 检测请求的资源样式,js,图片等文件(css,js,img)
	 * @param currentUri
	 * @return
	 */
	private boolean isRes(String currentUri) {
		boolean isRes = false;
		if(StringUtils.isNotEmpty(resSuffix)) {
			String suffix = DataUtil.getFileSuffix(currentUri);
			if(StringUtils.isNotEmpty(suffix)) {
				if(DataUtil.isArrayContains(resSuffix, suffix, ",")) {
					isRes = true;
				}
			}
		}
		return isRes;
	}

	/**
	 * 判断URI列表中是否包含URI；
	 * 注：当列表为空或 <code>uri</code> 参数值为空时，返回：true
	 * @param uriList
	 * @param uri
	 * @return 如果包含返回：true；否则返回false
	 */
	private boolean isUriContains(List<String> uriList, String uri) {
	    boolean is = false;
	    if(CollectionUtils.isEmpty(uriList) || StringUtils.isEmpty(uri)) {
	        return true;
	    }
	    for (String uriTmp : uriList) {
	        if(StringUtils.isNotEmpty(uriTmp) && uriTmp.indexOf("*")>-1) {
	            uriTmp = uriTmp.replace("*", "");
                if(uri.startsWith(uriTmp) || uri.endsWith(uriTmp) || uri.contains(uriTmp)) {
                    is = true;
                    break;
                }
            } else {
                if(uri.equals(uriTmp)) {
                    is = true;
                    break;
                }
            }
        }
	    return is;
	}
	
	/**
	 * 判断用户是否登录
	 * @param request
	 * @return
	 */
	private boolean isLogin(HttpServletRequest request) {
		boolean is = false;
		HttpSession session = request.getSession();
		if(null != session) {
			is = (null != session.getAttribute(IActionConstant.SESSION_USER_KEY))?true:false;
		}
		return is;
	}

	/**
	 *  处理调整URI
	 * @param request
	 * @param uri
	 * @return
	 */
	private String handleRedirectUri(HttpServletRequest request, String uri) {
		String contextPath = request.getContextPath();
		if(StringUtils.isNotEmpty(contextPath) && !"/".equals(contextPath)) {
			uri = contextPath+uri;
		}
		return uri;
	}

	/********getter and setter*******/
	public List<String> getExcludeMaps() {
		return excludeMaps;
	}

	public void setExcludeMaps(List<String> excludeMaps) {
		this.excludeMaps = excludeMaps;
	}

	public String getResSuffix() {
		return resSuffix;
	}

	public void setResSuffix(String resSuffix) {
		this.resSuffix = resSuffix;
	}

    public List<String> getAuthUriList() {
        return authUriList;
    }

    public void setAuthUriList(List<String> authUriList) {
        this.authUriList = authUriList;
    }
}
