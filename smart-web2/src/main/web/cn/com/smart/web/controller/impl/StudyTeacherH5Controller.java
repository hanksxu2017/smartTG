package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.StudentSearch;
import cn.com.smart.web.constant.enums.tg.CourseStudentRecordStatusEnum;
import cn.com.smart.web.service.*;
import cn.com.smart.web.utils.VxAuthUtil;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("/h5")
public class StudyTeacherH5Controller {

    private final String pathDir = "h5/teacher/";

	@Autowired
	private StudyCourseStudentRecordService courseStudentRecordService;

	@RequestMapping(value = "/vxIndex")
	@ResponseBody
	public String vxIndex(@RequestParam(value = "signature") String signature,
	                      @RequestParam(value = "timestamp") String timestamp,
	                      @RequestParam(value = "nonce") String nonce,
	                      @RequestParam(value = "echostr") String echostr) {

		log.info("微信发起测试,{}---{}---{}---{}", signature, timestamp, nonce, echostr);
		return echostr;
	}


	/**
	 * 公众号功能入口
	 *
	 * @param request       HTTP请求对象
	 * @param response      HTTP响应对象
	 */
	@RequestMapping(value = "/auth")
	public void auth(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 设置编码
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		// 微信中跳转到登录接口
		String redirect_uri = URLEncoder.encode("http://www.ptwq0580.cn/h5/login", "UTF-8");
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="
				+ VxAuthUtil.APP_ID
				+ "&redirect_uri="
				+ redirect_uri
				+ "&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
		response.sendRedirect(url);
	}

	@RequestMapping(value = "/login")
	public ModelAndView login(HttpServletRequest request) {

		// 1. 检查是否是补课返回操作
		String teacherId = request.getParameter("teacherId");
		String courseRecordId = request.getParameter("courseRecordId");
		if(StringUtils.isNotBlank(teacherId) && StringUtils.isNotBlank(courseRecordId)) {
			return this.loadCourseInfoByTeacherId(teacherId, courseRecordId);
		}

		// 2. 检查微信授权信息
		String code = request.getParameter("code");
		if(StringUtils.isBlank(code)) {
			return this.forwardErrorPage("请在微信公众号内访问");
		}
		return this.loadCourserInfoFormVx(code);
	}

	/**
	 * 微信中读取课时信息
	 * @param code  微信用户的code
	 * @return      课时页面
	 */
	private ModelAndView loadCourserInfoFormVx(String code) {

		log.info("code:{}", code);

		String userInfoStr = VxAuthUtil.getUserInfoByCode(code);
		if(StringUtils.isBlank(userInfoStr)) {
			return this.forwardErrorPage("请您先关注公众号:普陀围棋");
		}
		TGStudyVxUserInfo vxUserInfo = this.flushVxUserIntoDb(JSONObject.parseObject(userInfoStr));
		if(null == vxUserInfo) {
			return this.forwardErrorPage("登录信息获取失败,请稍后再试");
		}

		TGStudyTeacher teacher = this.teacherService.getTeacherByOpenId(vxUserInfo.getOpenid());
		if(null == teacher) {
			return forwardRegisterPage(vxUserInfo.getOpenid());
		}

		ModelAndView modelView = new ModelAndView();
		modelView.getModelMap().put("courseRecordList", this.findCourseRecordAtToday(teacher));

		modelView.getModelMap().put("teacherId", teacher.getId());

		modelView.setViewName(this.pathDir + "studentSign");

		return modelView;
	}

	/**
	 * 补课返回跳转
	 * @param teacherId         教师编号
	 * @param courseRecordId    课时编号
	 * @return                  课时页面
	 */
	private ModelAndView loadCourseInfoByTeacherId(String teacherId, String courseRecordId) {
		TGStudyTeacher teacher = this.teacherService.find(teacherId).getData();

		ModelAndView modelView = new ModelAndView();
		modelView.getModelMap().put("courseRecordList", this.findCourseRecordAtToday(teacher));

		TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseRecordId).getData();
		if(!StringUtils.equals(courseRecord.getTeacherId(), teacherId)) {
			this.forwardErrorPage("教师信息错误");
		}

		modelView.getModelMap().put("chooseCourseRecord", courseRecord);
		if(courseRecord.canSign()) {
			modelView.getModelMap().put("canSign", "YES");
		}

		modelView.getModelMap().put("teacherId", teacher.getId());

		List<TGStudyCourseStudentRecord> studentRecordList = this.findStudent(courseRecordId).getDatas();
		if(CollectionUtils.isNotEmpty(studentRecordList)) {
			modelView.getModelMap().put("studentRecordList", studentRecordList);
		}

		modelView.setViewName(this.pathDir + "studentSign");

		Map<String, Object> map = new HashMap<>();
		map.put("courseRecordId", courseRecordId);
		map.put("status", CourseStudentRecordStatusEnum.X_MAKE_UP.name());
		modelView.getModelMap().put("makeUpCount", (int)courseStudentRecordService.getCount(map));

		return modelView;
	}

	private ModelAndView forwardErrorPage(String errorMessage) {
		ModelAndView modelView = new ModelAndView();
		modelView.getModelMap().put("errorMessage", errorMessage);
		modelView.setViewName(this.pathDir + "showError");
		return modelView;
	}

	private ModelAndView forwardRegisterPage(String openid) {
		ModelAndView modelView = new ModelAndView();
		modelView.getModelMap().put("openid", openid);
		modelView.setViewName(this.pathDir + "unBind");
		return modelView;
	}

	@Autowired
	private StudyVxUserInfoService vxUserInfoService;

	private TGStudyVxUserInfo flushVxUserIntoDb(JSONObject vxUserInfoJson) {
		TGStudyVxUserInfo vxUserInfo;
		String openid = vxUserInfoJson.getString("openid");
		if(StringUtils.isBlank(openid)) {
			return null;
		}
		vxUserInfo = this.vxUserInfoService.getVxUserInfoByOpenId(openid);
		if(null != vxUserInfo) {
			return vxUserInfo;
		}

		vxUserInfo = new TGStudyVxUserInfo();
		vxUserInfo.setOpenid(openid);
		vxUserInfo.setNickname(vxUserInfoJson.getString("nickname"));
		vxUserInfo.setSex(vxUserInfoJson.getString("sex"));
		vxUserInfo.setProvince(vxUserInfoJson.getString("province"));
		vxUserInfo.setCity(vxUserInfoJson.getString("city"));
		vxUserInfo.setCountry(vxUserInfoJson.getString("country"));
		vxUserInfo.setHeadimgurl(vxUserInfoJson.getString("headimgurl"));
		vxUserInfo.setCreateTime(new Date());
		this.vxUserInfoService.save(vxUserInfo);
		return vxUserInfo;
	}

	@RequestMapping(value = "/subRegister")
	public ModelAndView register(String phone, String openid) {

		TGStudyTeacher teacher = this.teacherService.getTeacherByPhone(phone);
		if(null != teacher && StringUtils.isNotBlank(teacher.getOpenid()) && !StringUtils.equals(openid, teacher.getOpenid())) {
			return forwardErrorPage("手机号已绑定");
		}

		teacher = this.teacherService.getTeacherByOpenId(openid);
		if(null != teacher && !StringUtils.equals(phone, teacher.getPhone())) {
			return forwardErrorPage("微信已绑定");
		}

		TGStudyVxUserInfo vxUserInfo = vxUserInfoService.getVxUserInfoByOpenId(openid);
		if(null == vxUserInfo) {
			return forwardErrorPage("登录信息获取失败,请稍后再试");
		}
		this.createApply(vxUserInfo, phone);


		ModelAndView modelView = new ModelAndView();
		modelView.setViewName(this.pathDir + "info");
		return modelView;
	}

	@Autowired
	private StudyTeacherVxApplyService teacherVxApplyService;

	private void createApply(TGStudyVxUserInfo vxUserInfo, String phone) {
		TGStudyTeacherVxApply teacherVxApply = new TGStudyTeacherVxApply();
		teacherVxApply.setCreateTime(new Date());
		teacherVxApply.setNickname(vxUserInfo.getNickname());
		teacherVxApply.setOpenid(vxUserInfo.getOpenid());
		teacherVxApply.setPhone(phone);
		this.teacherVxApplyService.save(teacherVxApply);
	}

    @Autowired
    private StudyCourseRecordService courseRecordService;

    @RequestMapping(value = "/index")
    public ModelAndView index(String phone) {

        ModelAndView modelView = new ModelAndView();

        TGStudyTeacher teacher = this.getTeacherByPhone(phone);
        if(null == teacher) {
            modelView.setViewName(this.pathDir + "unBind");
            return modelView;
        }

	    modelView.getModelMap().put("courseRecordList", this.findCourseRecordAtToday(teacher));

        modelView.setViewName(this.pathDir + "studentSign");
        return modelView;
    }

	/**
	 * 查找教师在今日的所有课时
	 * @param teacher   教师信息
	 * @return          课时信息
	 */
	private List<TGStudyCourseRecord> findCourseRecordAtToday(TGStudyTeacher teacher) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("teacherId", teacher.getId());
	    params.put("courseDate", DateUtil.dateToStr(new Date(), "yyyy-MM-dd"));
	    List<TGStudyCourseRecord> courseRecordList = courseRecordService.findByParam(params).getDatas();
	    if(CollectionUtils.isNotEmpty(courseRecordList)) {
		    Collections.sort(courseRecordList);
	    }
	    return courseRecordList;
    }

    @Autowired
    private StudyTeacherService teacherService;

    private TGStudyTeacher getTeacherByPhone(String phone) {
        Map<String, Object> params = new HashMap<>();
        params.put("status", IConstant.STATUS_NORMAL);
        params.put("phone", phone);
        List<TGStudyTeacher> teacherList = this.teacherService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(teacherList)) {
            return teacherList.get(0);
        }
        return null;
    }


    @RequestMapping(value = "/queryStudent")
    @ResponseBody
    public SmartResponse<TGStudyCourseStudentRecord> queryStudent(String courseRecordId) {
	    SmartResponse<TGStudyCourseStudentRecord> smartResponse = this.findStudent(courseRecordId);

	    TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseRecordId).getData();
	    if(null != courseRecord && !courseRecord.canSign()) {
	    	// 设置为是否可点名操作标志
		    smartResponse.setSize(-1);
	    }

	    return smartResponse;
    }

    private SmartResponse<TGStudyCourseStudentRecord> findStudent(String courseRecordId) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("courseRecordId", courseRecordId);
	    return courseStudentRecordService.findByParam(params, "status");
    }

    @RequestMapping(value = "/queryCourseRecord")
    @ResponseBody
    public SmartResponse<TGStudyCourseRecord> queryCourseRecord(String courseRecordId) {
        SmartResponse<TGStudyCourseRecord> smartResponse = courseRecordService.find(courseRecordId);

	    Map<String, Object> map = new HashMap<>();
	    map.put("courseRecordId", courseRecordId);
	    map.put("status", CourseStudentRecordStatusEnum.X_MAKE_UP.name());
	    smartResponse.setSize((int)courseStudentRecordService.getCount(map));

	    return smartResponse;
    }

    @Autowired
    private StudyCourseRecordSignService courseRecordSignService;

    @RequestMapping(value = "/subStudentSign")
    @ResponseBody
    public SmartResponse<TGStudyCourseRecord> subStudentSign(String courseRecordId, String studentId, String status) {
        SmartResponse<TGStudyCourseRecord> smartResponse = new SmartResponse<>();

        CourseStudentRecordStatusEnum statusEnum = this.parseStatus(status);
        if(StringUtils.isBlank(courseRecordId) || StringUtils.isBlank(studentId) || null == statusEnum) {
            smartResponse.setMsg("请求无效");
            return smartResponse;
        }

	    try {
		    this.courseRecordSignService.subStudentSign(courseRecordId, studentId, statusEnum, "");
	    } catch (Exception e) {
		    log.info("-----[点名失败]-----{}", e);
		    smartResponse.setResult(IConstant.OP_FAIL);
		    smartResponse.setMsg("学生点名[" + statusEnum.getMessage() + "]失败!");
	    }

	    smartResponse = courseRecordService.find(courseRecordId);

	    Map<String, Object> map = new HashMap<>();
	    map.put("courseRecordId", courseRecordId);
	    map.put("status", CourseStudentRecordStatusEnum.X_MAKE_UP.name());
	    smartResponse.setSize((int)courseStudentRecordService.getCount(map));

	    return smartResponse;
    }

    private CourseStudentRecordStatusEnum parseStatus(String status) {
        if(StringUtils.equals(status, "signed")) {
            return CourseStudentRecordStatusEnum.SIGNED;
        } else if (StringUtils.equals(status, "leave")) {
            return CourseStudentRecordStatusEnum.PERSONAL_LEAVE;
        } else if (StringUtils.equals(status, "truant")) {
            return CourseStudentRecordStatusEnum.PLAY_TRUANT;
        }
        return null;
    }

    @Autowired
    private StudyMakeUpService makeUpService;

    @RequestMapping("/makeUpStudent")
    public ModelAndView makeUpStudent(StudentSearch searchParam, RequestPage page) {

       SmartResponse<Object> smartResp = makeUpService.findStudentHasAbsent(searchParam, page.getPage(), page.getPageSize());

        ModelAndView modelView = new ModelAndView();
        Map<String, Object> modelMap = modelView.getModelMap();

        modelMap.put("smartResp", smartResp);
        modelMap.put("courseRecordId", searchParam.getCourseRecordId());
        modelMap.put("teacherId", searchParam.getTeacherId());

        modelMap.put("studentName", searchParam.getName());

        modelView.setViewName(this.pathDir + "makeUpStudent");
        return modelView;
    }

    @RequestMapping(value = "/subMakeUpStudent")
    @ResponseBody
    public SmartResponse<String> subMakeUpStudent(String studentId, String courseRecordId) {
        return this.makeUpService.doMakeUp(studentId, courseRecordId);
    }

	@RequestMapping(value = "/removeMakeUp")
	@ResponseBody
	public SmartResponse<String> removeMakeUp(String courseRecordId, String studentId) {
		return this.makeUpService.removeMakeUpStudent(studentId, courseRecordId);
	}
}
