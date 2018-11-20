package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.constant.enumEntity.CourseStudentStatusEnum;
import cn.com.smart.constant.enumEntity.SystemMessageEnum;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.StudentCourseRelSearch;
import cn.com.smart.web.bean.search.StudentSearch;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.constant.enums.SelectedEventType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import cn.com.smart.web.tag.bean.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/studyStudent")
public class StudyStudentController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyStudentService studentService;

    public StudyStudentController() {
        super.setSubDir("/studyStudent/");
    }

    /**
     * @param searchParam   查询参数对象
     * @param page          分页参数对象
     * @return              JSP页面对象
     */
    @RequestMapping("/list")
    public ModelAndView list(StudentSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_study_student_list", searchParam, page.getStartNum(), page.getPageSize());
	    return this.packListModelView(searchParam, smartResp);
    }

    /**
     *
     * @return  JSP页面对象
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getPageDir() + "add");
        return modelView;
    }

	/**
	 *
	 * @param studyStudent  学生信息
	 * @return              保存结果
	 */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> save(TGStudyStudent studyStudent) {
        studyStudent.setCreateTime(new Date());

        short parentType = studyStudent.getParentType();
        if(1 == parentType) {
            studyStudent.setParentName(studyStudent.getParentName() + "(父亲)");
        } else if(2 == parentType) {
            studyStudent.setParentName(studyStudent.getParentName() + "(母亲)");
        }

        studyStudent.setRemainCourse(studyStudent.getTotalCourse());

        studyStudent.setAge(this.getAge(studyStudent.getBirthday()));

	    return studentService.save(studyStudent);
    }

	/**
	 * 根据出生日期计算年龄
	 * @param birthday  出生日期
	 * @return          年龄
	 */
	private int getAge(String birthday) {
        Date birthDate = DateUtil.parseDate(birthday, "yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        int curYear = cal.get(Calendar.YEAR);

		assert birthDate != null;
		cal.setTime(birthDate);
        int birthYear = cal.get(Calendar.YEAR);//获取年份

        return curYear - birthYear;
    }

    @RequestMapping(value = "/edit")
    public ModelAndView update(String id) {
        ModelAndView modelView = new ModelAndView();
        if(StringUtils.isNotBlank(id)) {
            TGStudyStudent studyStudent = studentService.find(id).getData();
            if(null != studyStudent) {
                modelView.getModelMap().put("objBean", studyStudent);
            }
        }
        modelView.setViewName(getPageDir() + "edit");
        return modelView;
    }

    /**
     * 提交编辑
     *
     * @param studyStudent  学生信息对象
     * @return              修改结果
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> update(TGStudyStudent studyStudent) {
        TGStudyStudent studyStudentDb = this.studentService.find(studyStudent.getId()).getData();
        studyStudent.setCreateTime(studyStudentDb.getCreateTime());
        studyStudent.setUpdateTime(new Date());
	    return studentService.update(studyStudent);
    }

    @Autowired
    private StudyStudentCourseRelService studentCourseRelService;

    /**
     * 简单列表
     * @return              JSP页面对象
     */
    @RequestMapping("/simpList")
    public ModelAndView simpList(StudentSearch searchParam,
                                 ModelAndView modelView, RequestPage page){
        String uri = this.getUriPath() + "simpList";
        SmartResponse<Object> smartResp = this.opService.getDatas("student_simp_list",searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, "#student-tab", page.getPage(), page.getPageSize());
        selectedEventProp = new SelectedEventProp(SelectedEventType.OPEN_TO_TARGET.getValue(),"studyCourse/studentHas","#has-class-list","id");

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);
        modelMap.put("selectedEventProp", selectedEventProp);
        pageParam = null;

        modelView.setViewName(this.getPageDir() + "simpList");
        return modelView;
    }

    /**
     *
     * @return          JSP页面对象
     */
    @RequestMapping("/courseList")
    public ModelAndView classList(StudentCourseRelSearch searchParam,ModelAndView modelView,RequestPage page) {
        String uri = this.getUriPath() + "courseList";
	    if(StringUtils.isBlank(searchParam.getStatus())) {
		    searchParam.setStatus(IConstant.STATUS_NORMAL);
	    }
        if(StringUtils.equals(searchParam.getStatus(), "ALL")) {
            searchParam.setStatus(null);
        }
        SmartResponse<Object> smartResp = this.opService.getDatas("student_course_list", searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, null, page.getPage(), page.getPageSize());
        uri = uri + "?id=" + searchParam.getId();
        delBtn = new DelBtn(this.getUriPath() + "exitCourse?studentId=" + searchParam.getId(), "确定要从该班中退出吗？",uri,"#student-course-tab", null);
        delBtn.setName("退班");
        refreshBtn = new RefreshBtn(uri, null,"#student-course-tab");

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);
        modelMap.put("delBtn", delBtn);
//        modelMap.put("refreshBtn", refreshBtn);
        pageParam = null;

        CustomBtn customBtnReport = new CustomBtn("reportCourse", "报班", "报班", this.getUriPath() + "reportCourse?studentId=" + searchParam.getId(),"glyphicon-list-alt", BtnPropType.SelectType.NONE.getValue());
        customBtnReport.setWidth("600");
        customBtns = new ArrayList<>(1);
        customBtns.add(customBtnReport);
        modelMap.put("customBtns", customBtns);


        modelView.setViewName(this.getPageDir() + "courseList");
        return modelView;
    }

    @Autowired
    private StudyCourseStudentRecordService courseStudentRecordService;

    @RequestMapping(value="/exitCourse", produces="application/json;charset=UTF-8")
    @ResponseBody
    public SmartResponse<String> exitClass(String id, String studentId) {

        SmartResponse<String> smartResp;
	    smartResp = new SmartResponse<>();

	    // 从班级中退出
        Map<String, Object> params = new HashMap<>();
        params.put("courseId", id);
        params.put("studentId", studentId);
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyStudentCourseRel> relList = this.studentCourseRelService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(relList)) {
            TGStudyStudentCourseRel rel = relList.get(0);
            if(null != rel && !StringUtils.equals(rel.getStatus(), IConstant.STATUS_EXIT_COURSE)) {
                rel.setStatus(IConstant.STATUS_EXIT_COURSE);
                rel.setUpdateTime(new Date());
                this.studentCourseRelService.update(rel);
            }
        }

        // 本周内未结束的课时需要结束掉
        params = new HashMap<>();
        params.put("courseId", id);
        params.put("studentId", studentId);
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyCourseStudentRecord> courseStudentRecordList =
                this.courseStudentRecordService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseStudentRecordList)) {
            for(TGStudyCourseStudentRecord record : courseStudentRecordList) {
                record.setStatus(IConstant.STATUS_COURSE_CANCEL_AS_EXIT);
                record.setUpdateTime(new Date());
            }
            this.courseStudentRecordService.update(courseStudentRecordList);
        }

        smartResp.setResult(IConstant.OP_SUCCESS);
        smartResp.setMsg("已完成退班!");
        return smartResp;
    }

    @Autowired
    private StudyTeacherService teacherService;

    /**
     *
     * @return  JSP页面对象
     */
    @RequestMapping(value = "/reportCourse")
    public ModelAndView reportCourse(String studentId) {
        ModelAndView modelView = new ModelAndView();
        modelView.setViewName(getPageDir() + "reportCourse");

        modelView.getModelMap().put("studentId", studentId);

        Map<String, Object> params = new HashMap<>();
        params.put("status", IConstant.STATUS_NORMAL);
        modelView.getModelMap().put("teachers", this.teacherService.findByParam(params).getDatas());

        return modelView;
    }


	/**
	 *
	 * @param modelView     JSP页面对象
	 * @param id            课时记录序号
	 * @return              JSP页面对象
	 */
	@RequestMapping("/courseRecHas")
	public ModelAndView courseRecHas(ModelAndView modelView,String id) {
		if(StringUtils.isNotBlank(id)) {
			SmartResponse<Object> smartResp = this.opService.find(TGStudyCourseRecord.class, id);
			ModelMap modelMap = modelView.getModelMap();
			modelMap.put("courseRecordId", id);
			if(smartResp.getResult().equals(OP_SUCCESS)) {
				TGStudyCourseRecord courseRecord = (TGStudyCourseRecord) smartResp.getData();
				if(null != courseRecord) {
					modelMap.put("name", courseRecord.getCourseName());
					if(IConstant.STATUS_COURSE_END.equals(courseRecord.getStatus())) {
						modelMap.put("studentSignStatistics", concatSignStatistics(courseRecord));
					}
				}
			}
		}
		modelView.setViewName(this.getPageDir() + "courseRecHas");
		return modelView;
	}

	private String concatSignStatistics(TGStudyCourseRecord courseRecord) {
		return "应到" + courseRecord.getStudentQuantityPlan() +
				"/实到" + courseRecord.getStudentQuantityActual() +
				"/事假" + courseRecord.getStudentPersonalLeave() +
				"/旷课" + courseRecord.getStudentPlayTruant() +
				"/其他缺席" + courseRecord.getStudentOtherAbsent();
	}

    /**
     * 该课时拥有的学生列表信息
     * @return          JSP页面对象
     */
    @RequestMapping("/studentList")
    public ModelAndView studentList(StudentCourseRelSearch searchParam, ModelAndView modelView, RequestPage page) {
        String uri = this.getUriPath() + "studentList";
        SmartResponse<Object> smartResp = this.opService.getDatas("courseRecord_student_list", searchParam, page.getStartNum(), page.getPageSize());
        pageParam = new PageParam(uri, null, page.getPage(), page.getPageSize());
        uri = uri + "?courseRecordId=" + searchParam.getCourseRecordId();
        refreshBtn = new RefreshBtn(uri, null,"#courseRecord-student-tab");

        ModelMap modelMap = modelView.getModelMap();
        modelMap.put("smartResp", smartResp);
        modelMap.put("pageParam", pageParam);
        modelMap.put("searchParam", searchParam);
        modelMap.put("refreshBtn", refreshBtn);

        CustomBtn customBtnAllSign = new CustomBtn("allSign", "全部签到",
                "全部签到", this.getUriPath() + "allSign?courseRecordId=" + searchParam.getCourseRecordId(),"glyphicon-list-alt", BtnPropType.SelectType.NONE.getValue());
        customBtnAllSign.setWidth("600");

        CustomBtn customBtnSign = new CustomBtn("studentSign", "上课点名",
                "上课点名", this.getUriPath() + "studentSign?courseRecordId=" + searchParam.getCourseRecordId(),"glyphicon-list-alt", BtnPropType.SelectType.MULTI.getValue());
        customBtnSign.setWidth("600");


        customBtns = new ArrayList<>(2);
        customBtns.add(customBtnAllSign);
        customBtns.add(customBtnSign);
        modelMap.put("customBtns", customBtns);


        modelView.setViewName(this.getPageDir() + "studentList");
        return modelView;
    }

    @Autowired
    private StudyCourseRecordService courseRecordService;

    /**
     *
     * @return  JSP页面对象
     */
    @RequestMapping(value = "/allSign")
    public ModelAndView allSign(String courseRecordId) {
        ModelAndView modelView = new ModelAndView();

        TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseRecordId).getData();
        modelView.getModelMap().put("courseRecord", courseRecord);

        if(!this.checkCourseCanSign(courseRecord)) {
            modelView.getModelMap().put("disableSign", "yes");
        }


        modelView.setViewName(this.getPageDir() + "allSign");
        return modelView;
    }

    /**
     *
     * 全部签到
     * @param courseRecordId    课时记录序号
     * @return                  签到结果
     */
    @RequestMapping(value = "/subAllSign", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> subAllSign(String courseRecordId) {
        SmartResponse<String> response = new SmartResponse<>();
        SmartResponse<TGStudyCourseRecord> smartResponse = this.courseRecordService.find(courseRecordId);
        if(!smartResponse.isSuccess() || null == smartResponse.getData()) {
            response.setMsg(smartResponse.getMsg());
            return response;
        }
        TGStudyCourseRecord courseRecord = smartResponse.getData();

        if(!this.checkCourseCanSign(courseRecord)) {
            response.setMsg("课时目前无法进行签到操作,请稍后再试!");
            return response;
        }

        Date updateDate = new Date();
        Map<String, Object> params = new HashMap<>();
        params.put("courseRecId", courseRecordId);
        params.put("status", IConstant.STATUS_NORMAL);
        List<TGStudyCourseStudentRecord> courseStudentRecordList =
                this.courseStudentRecordService.findByParam(params).getDatas();
        if(CollectionUtils.isNotEmpty(courseStudentRecordList)) {
            courseRecord.setStudentQuantityPlan(courseStudentRecordList.size());
            courseRecord.setStudentQuantityActual(courseStudentRecordList.size());
            courseRecord.setStudentPersonalLeave(0);
            courseRecord.setStudentPlayTruant(0);
            courseRecord.setStudentOtherAbsent(0);

            TGStudyStudent student;
            for(TGStudyCourseStudentRecord courseStudentRecord : courseStudentRecordList) {
                courseStudentRecord.setStatus(IConstant.STATUS_COURSE_END);
                courseRecord.setUpdateTime(updateDate);
                this.courseStudentRecordService.update(courseStudentRecord);

                // 学生课时-1
                student = this.studentService.find(courseStudentRecord.getStudentId()).getData();
                student.setRemainCourse(student.getRemainCourse() - 1);
                student.setUpdateTime(updateDate);
                student.setCourseSeriesUnSigned(0);
                this.studentService.update(student);
                if(student.getRemainCourse() < 3) {
                    // 课时不足
                    String content = "学生[" + student.getName() + "]仅剩余 " + student.getRemainCourse() + "课时!";
                    this.broadSystemMessage(SystemMessageEnum.STUDENT_REMAIN_COURSE_NOTE, content);
                }
            }
        }

        courseRecord.setUpdateTime(updateDate);
        courseRecord.setStatus(IConstant.STATUS_COURSE_END);
        response = courseRecordService.update(courseRecord);
        return response;
    }

    private boolean checkCourseCanSign(TGStudyCourseRecord courseRecord) {
        Date courseDate =
                DateUtil.parseDate(courseRecord.getCourseDate() + " " + courseRecord.getCourseTime(),
                        "yyyy-MM-dd HH:mm");
        if(null != courseDate) {
            return courseDate.before(new Date());
        }
        return false;
    }

    /**
     *
     * @return  JSP页面对象
     */
    @RequestMapping(value = "/studentSign")
    public ModelAndView studentSign(String id, String courseRecordId) {
        ModelAndView modelView = new ModelAndView();
	    modelView.getModelMap().put("studentId", id);
	    modelView.getModelMap().put("courseRecord", this.courseRecordService.find(courseRecordId).getData());

	    String[] ids = id.split(",");
	    if(ids.length > 1) {
	    	StringBuilder nameBuilder = new StringBuilder();
	    	TGStudyStudent student;
//            for (int i = 0; i < ids.length; i++) {
                for(String studentId : ids) {
                student = this.studentService.find(studentId).getData();
                if (null != student) {
                    nameBuilder.append(",").append(student.getName());
                }
            }
			String names = nameBuilder.toString();
			if(names.startsWith(",")) {
				names = names.substring(1);
			}
		    modelView.getModelMap().put("studentName", names);
	    }

        modelView.setViewName(this.getPageDir() + "studentSign");
        return modelView;
    }

    @RequestMapping(value = "/subSign", method = RequestMethod.POST)
    @ResponseBody
    public SmartResponse<String> subSign(String courseRecordId, String studentId, String status, String description) {
	    SmartResponse<String> smartResponse = new SmartResponse<>();

	    CourseStudentStatusEnum statusEnum = CourseStudentStatusEnum.valueOf(status);
	    if(StringUtils.isBlank(courseRecordId) ||
                StringUtils.isBlank(studentId) ||
                CourseStudentStatusEnum.NORMAL == statusEnum) {
		    smartResponse.setMsg("请求无效!");
		    return smartResponse;
	    }

	    String[] studentIds = studentId.split(",");
        for(String sid : studentIds) {
            smartResponse = processSingleStudentSign(courseRecordId, sid, description, statusEnum);
            if(!smartResponse.isSuccess()) {
                return smartResponse;
            }
        }

        smartResponse.setResult(IConstant.OP_SUCCESS);
        return smartResponse;
    }

    private SmartResponse<String> processSingleStudentSign(String courseRecordId, String studentId, String description, CourseStudentStatusEnum statusEnum){
        SmartResponse<String> smartResponse = new SmartResponse<>();
        Map<String, Object> params = new HashMap<>();
        params.put("courseRecordId", courseRecordId);
        params.put("studentId", studentId);
        TGStudyCourseStudentRecord courseStudentRecord = this.courseStudentRecordService.findByParam(params).getData();

        if(null == courseStudentRecord) {
            smartResponse.setMsg("学生课时数据不存在!");
            return smartResponse;
        }
        if(StringUtils.equals(courseStudentRecord.getStatus(), IConstant.STATUS_NORMAL)) {
            // 进行签到操作
            if(!this.checkCourseStudentRecordCanSign(courseStudentRecord)) {
                smartResponse.setMsg("课时目前无法进行签到操作,请稍后再试!");
                return smartResponse;
            }
            // 更新学生课时的签到信息
            courseStudentRecord.setStatus(statusEnum.name());
            courseStudentRecord.setDescription(description);
            courseStudentRecord.setUpdateTime(new Date());
            final SmartResponse<String> updateSmartResponse = this.courseStudentRecordService.update(courseStudentRecord);
            if(!updateSmartResponse.isSuccess()) {
                smartResponse.setMsg("学生课时更新失败!");
                return smartResponse;
            }

            // 学生课时-1
            TGStudyStudent student = this.studentService.find(courseStudentRecord.getStudentId()).getData();
            student.setRemainCourse(student.getRemainCourse() - 1);
            student.setUpdateTime(new Date());
            if(CourseStudentStatusEnum.SIGNED.equals(statusEnum)) {
                student.setCourseSeriesUnSigned(0);
            } else {
                // 非正常签到,生成异常签到记录
                student.setCourseSeriesUnSigned(student.getCourseSeriesUnSigned() + 1);
            }
            this.studentService.update(student);
            if(student.getCourseSeriesUnSigned() >= 3) {
                // 连续未签到,系统提示
                String content = "学生[" + student.getName() + "]已连续 " + student.getCourseSeriesUnSigned() + "次缺席!";
                this.broadSystemMessage(SystemMessageEnum.STUDENT_ABSENT_NOTE, content);
            }
            if(student.getRemainCourse() < 3) {
                // 课时不足
                String content = "学生[" + student.getName() + "]仅剩余 " + student.getRemainCourse() + "课时!";
                this.broadSystemMessage(SystemMessageEnum.STUDENT_REMAIN_COURSE_NOTE, content);
            }
        }

        // 检查课时的学生列表是否已经全部签到
        this.updateCourseRecordToEndIfAllSigned(courseStudentRecord.getCourseRecordId());

        smartResponse.setResult(IConstant.OP_SUCCESS);
        return smartResponse;
    }

	/**
	 * 查看课时是否支持签到操作
	 * @param courseStudentRecord   学生课时信息对象
	 * @return                      可以执行签到时返回true,否则返回false
	 */
	private boolean checkCourseStudentRecordCanSign(TGStudyCourseStudentRecord courseStudentRecord) {
    	TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseStudentRecord.getCourseRecordId()).getData();
    	return this.checkCourseCanSign(courseRecord);
	}

	/**
	 * 检查课时的学生是否已经全部进行了签到操作
	 * @param courseRecordId    课时记录序号
	 */
	private void updateCourseRecordToEndIfAllSigned(String courseRecordId) {
		Map<String, Object> params = new HashMap<>();
		params.put("courseRecordId", courseRecordId);
		params.put("status!", CourseStudentStatusEnum.CANCEL_AS_EXIT.name());
		List<TGStudyCourseStudentRecord> courseStudentRecordList = this.courseStudentRecordService.findByParam(params).getDatas();
		if(!CollectionUtils.isEmpty(courseStudentRecordList)) {
			// 所有学生课时记录已处理
			boolean isAllSigned = true;

			int actual = 0;
			int personalLeave = 0;
			int playTruant = 0;
			int otherAbsent = 0;

			for(TGStudyCourseStudentRecord courseStudentRecord : courseStudentRecordList) {
				if(StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.NORMAL.name())) {
					isAllSigned = false;
					break;
				}
				if(StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.SIGNED.name())) {
					actual++;
				} else if(StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.PERSONAL_LEAVE.name())) {
					personalLeave++;
				} else if(StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.PLAY_TRUANT.name())) {
					playTruant++;
				} else if(StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.OTHER_ABSENT.name())) {
					otherAbsent++;
				}
			}

			if(isAllSigned) {
				TGStudyCourseRecord courseRecord = this.courseRecordService.find(courseRecordId).getData();
				courseRecord.setStudentQuantityPlan(courseStudentRecordList.size());
				courseRecord.setStudentQuantityActual(actual);
				courseRecord.setStudentPersonalLeave(personalLeave);
				courseRecord.setStudentPlayTruant(playTruant);
				courseRecord.setStudentOtherAbsent(otherAbsent);

				courseRecord.setUpdateTime(new Date());
				courseRecord.setStatus(IConstant.STATUS_COURSE_END);
			}
		}
	}

	@Autowired
	private StudySystemMessageService systemMessageService;

	private void broadSystemMessage(SystemMessageEnum systemMessageEnum, String content) {
		TGStudySystemMessage systemMessage = new TGStudySystemMessage();
		systemMessage.setMessageType(systemMessageEnum.name());
		systemMessage.setMessageContent(content);
		systemMessage.setLevel(systemMessageEnum.getLevel());
		systemMessage.setCreateTime(new Date());
		this.systemMessageService.save(systemMessage);
	}
}
