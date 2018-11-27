package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.bean.search.CourseSearch;
import cn.com.smart.web.constant.enums.BtnPropType;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.OPService;
import cn.com.smart.web.service.StudyCourseRecordService;
import cn.com.smart.web.service.StudyCourseService;
import cn.com.smart.web.service.StudyTeacherService;
import cn.com.smart.web.tag.bean.CustomBtn;
import cn.com.smart.web.tag.bean.PageParam;
import cn.com.smart.web.tag.bean.RefreshBtn;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/studyCourse")
public class StudyCourseController extends BaseController {

    @Autowired
    private OPService opService;
    @Autowired
    private StudyCourseService courseService;

    @Autowired
    private StudyTeacherService teacherService;

    public StudyCourseController() {
        super.setSubDir("/studyCourse/");
    }



    /**
     * @param searchParam   查询参数对象
     * @param page          分页参数对象
     * @return              JSP页面对象
     */
    @RequestMapping("/list")
    public ModelAndView list(CourseSearch searchParam, RequestPage page) {
        SmartResponse<Object> smartResp = opService.getDatas("select_course_list", searchParam, page.getStartNum(), page.getPageSize());

        ModelAndView modelView = new ModelAndView();
        Map<String, Object> modelMap = modelView.getModelMap();
        refreshBtn = new RefreshBtn(this.getUriPath() + "list", null, null);
        pageParam = new PageParam(this.getUriPath() + "list", null, page.getPage(), page.getPageSize());

        modelMap.put("pageParam", pageParam);
        modelMap.put("refreshBtn", refreshBtn);
        modelMap.put("smartResp", smartResp);
        modelMap.put("searchParam", searchParam);

        modelMap.put("teachers", this.teacherService.findNormal().getDatas());

        CustomBtn customBtnReport = new CustomBtn("generateDailyCourse", "生成周课时表",
		        "生成周课时表", this.getUriPath() + "record/generateDailyCourse","glyphicon-list-alt", BtnPropType.SelectType.NONE.getValue());
        customBtnReport.setWidth("600");
        customBtns = new ArrayList<>(1);
        customBtns.add(customBtnReport);
        modelMap.put("customBtns", customBtns);

        modelView.setViewName(this.getPageDir() + "list");
        return modelView;
    }





    @RequestMapping("/index")
    public ModelAndView index(ModelAndView modelView) {
        modelView.setViewName(this.getPageDir() + "/index");
        return modelView;
    }

    @RequestMapping("/studentHas")
    public ModelAndView roleHas(ModelAndView modelView,String id) {
        if(StringUtils.isNotEmpty(id)) {
            SmartResponse<Object> smartResp = this.opService.find(TGStudyStudent.class, id);
            ModelMap modelMap = modelView.getModelMap();
            modelMap.put("id", id);
            if(smartResp.getResult().equals(OP_SUCCESS)) {
                TGStudyStudent student = (TGStudyStudent) smartResp.getData();
                String name = (null != student)?student.getName():null;
                modelMap.put("name", name);
            }
        }
        modelView.setViewName(this.getPageDir() + "studentHas");
        return modelView;
    }

    @RequestMapping("/teacherHas")
    public ModelAndView teacherHas(ModelAndView modelView,String id) {
        if(StringUtils.isNotEmpty(id)) {
            SmartResponse<Object> smartResp = this.opService.find(TGStudyTeacher.class, id);
            ModelMap modelMap = modelView.getModelMap();
            modelMap.put("id", id);
            if(smartResp.getResult().equals(OP_SUCCESS)) {
                TGStudyTeacher teacher = (TGStudyTeacher) smartResp.getData();
                String name = (null != teacher)?teacher.getName():null;
                modelMap.put("name", name);
            }
        }
        modelView.setViewName(this.getPageDir() + "teacherHas");
        return modelView;
    }

    @RequestMapping(value = "/queryCourse", method = RequestMethod.GET)
    @ResponseBody
    public SmartResponse<TGStudyCourse> queryCourse(String teacherId, Short weekInfo, String courseId) {
        Map<String, Object> params = new HashMap<>();
        if(StringUtils.isNotBlank(teacherId)) {
            params.put("teacherId", teacherId);
        }
        if(null != weekInfo) {
            params.put("weekInfo", weekInfo);
        }
        if(StringUtils.isNotBlank(courseId)) {
            params.put("id", courseId);
        }
        return this.courseService.findByParam(params, "weekInfo");
    }

    @RequestMapping(value = "/queryWeeks", method = RequestMethod.GET)
    @ResponseBody
    public SmartResponse<Object> queryWeeks(String teacherId) {
        Map<String, Object> params = new HashMap<>();
        if(StringUtils.isNotBlank(teacherId)) {
            params.put("teacherId", teacherId);
        }

        return this.opService.getDatas("teacher_course_weeks", params);
    }

	/**
	 * 提交编辑
	 *  TODO 提交编辑时的检查冲突要排除对象本身
	 * @param course
	 * @return
	 */
	@RequestMapping(value = "/subEditCourse", method = RequestMethod.POST)
	@ResponseBody
	public SmartResponse<String> subEditCourse(TGStudyCourse course) {
		SmartResponse<String> smartResp = new SmartResponse<>();
		String checkRes = this.checkCourseConflict(course);
		if(StringUtils.isNotBlank(checkRes)) {
			smartResp.setMsg(checkRes);
			return smartResp;
		}

		course.setUpdateTime(new Date());
		course.setName(this.concatCourseName(course));

		smartResp = this.courseService.update(course);
		// 老师课时增加成功后,进行本周内的时安排
		generateCurWeekCourseRecIfNecessary(course);

		return smartResp;

	}

    /**
     *
     * @param course        课时对象
     * @return              执行增加的结果
     */
    @RequestMapping(value="/saveCourse",method=RequestMethod.POST)
    public @ResponseBody SmartResponse<String> saveCourse(TGStudyCourse course) {
        SmartResponse<String> smartResp = new SmartResponse<>();
        String checkRes = this.checkCourseConflict(course);
        if(StringUtils.isNotBlank(checkRes)) {
            smartResp.setMsg(checkRes);
            return smartResp;
        }

        course.setCreateTime(new Date());
//        this.packTeacherInfo(course);

        course.setName(this.concatCourseName(course));

        smartResp = this.courseService.save(course);
        // 老师课时增加成功后,进行本周内的时安排
        generateCurWeekCourseRecIfNecessary(course);

        return smartResp;
    }

    /**
     * 检查课程安排是否存在冲突
     * @param course        课时对象
     * @return              课程存在冲突时返回提示信息,否则返回null
     */
    private String checkCourseConflict(TGStudyCourse course) {
        String checkRes = this.checkTeacherCourse(course.getCourseTimeIndex(), course.getWeekInfo(), course.getTeacherId());
        if(StringUtils.isNotBlank(checkRes)) {
            return checkRes;
        }
        checkRes = this.checkClassroom(course.getCourseTimeIndex(), course.getWeekInfo(), course.getClassroomId());
        if(StringUtils.isNotBlank(checkRes)) {
            return checkRes;
        }
        return "";
    }

    private String checkTeacherCourse(short courseTimeIndex, short weekInfo, String teacherId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseTimeIndex", courseTimeIndex);
        params.put("weekInfo", weekInfo);
        params.put("teacherId", teacherId);
        SmartResponse<TGStudyCourse> courseSmartResponse = this.courseService.findByParam(params);
        if(courseSmartResponse.isSuccess() && courseSmartResponse.getTotalNum() > 0) {
            return "课程冲突:同时间点,教师存在其他课程";
        }
        return "";
    }

    private String checkClassroom(short courseTimeIndex, short weekInfo, String classroomId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseTimeIndex", courseTimeIndex);
        params.put("weekInfo", weekInfo);
        params.put("classroomId", classroomId);
        SmartResponse<TGStudyCourse> courseSmartResponse = this.courseService.findByParam(params);
        if(courseSmartResponse.isSuccess() && courseSmartResponse.getTotalNum() > 0) {
            return "课程冲突:同时间点,教室已被其他课程占用.";
        }
        return "";
    }

    private void packTeacherInfo(TGStudyCourse course) {
        TGStudyTeacher teacher = this.teacherService.find(course.getTeacherId()).getData();
        if(null != teacher) {
            course.setTeacherName(teacher.getName());
        }
    }

    private String concatCourseName(TGStudyCourse course) {
        StringBuilder builder = new StringBuilder();
        builder.append(course.getTeacherName());
        builder.append(getWeekInfoInCN(course.getWeekInfo()));
	    builder.append(course.getCourseTimeIndex());
        return builder.toString();
    }

	/**
	 *
	 * @param weekInfo
	 * @return
	 */
	private String getWeekInfoInCN(short weekInfo) {
		String[] weeks = {"一","二","三","四","五","六","天"};
		if(weekInfo >= 1 && weekInfo <=7 ) {
			return "星期" + weeks[weekInfo - 1];
		}
		return null;
	}

    @Autowired
    private StudyCourseRecordService courseRecordService;

    private void generateCurWeekCourseRecIfNecessary(TGStudyCourse course) {
        int curWeek = DateUtil.getWeek(new Date());
        if(0 == curWeek) {
            curWeek = 7;
        }
        if(course.getWeekInfo() > curWeek) {
            Date courseDate = DateUtil.addDay(new Date(), course.getWeekInfo() - curWeek);
            TGStudyCourseRecord courseRecord = this.initCourseRecord(course, courseDate);
            this.courseRecordService.save(courseRecord);
        }
        if(course.getWeekInfo() == curWeek) {
            // 同一天,决绝生成
            // 同一天,判断时间
            String startTime = course.getCourseTime().substring(0, course.getCourseTime().indexOf("-"));
            String courseTimeStr = DateUtil.dateToStr(new Date(), "yyyy-MM-dd") + " " + startTime;
            Date courseTime = DateUtil.parseDate(courseTimeStr, "yyyy-MM-dd HH:mm");
            if(null != courseTime && courseTime.after(new Date())) log.info("真会挑时间,好好准备下周的课时吧!~~~");
        }

    }

    /**
     *
     * @param course    课时对象
     * @return          课时记录对象
     */
    private TGStudyCourseRecord initCourseRecord(TGStudyCourse course, Date courseDate) {

        String courseDateStr = DateUtil.dateToStr(courseDate, "yyyy-MM-dd");

        TGStudyCourseRecord courseRecord = new TGStudyCourseRecord();

        courseRecord.setCourseId(course.getId());
        courseRecord.setCourseDate(courseDateStr);
        courseRecord.setCourseTime(course.getCourseTime());
        courseRecord.setCourseName(course.getName());

        courseRecord.setClassroomId(course.getClassroomId());
        courseRecord.setClassroomName(course.getClassroomName());

        courseRecord.setTeacherId(course.getTeacherId());
        courseRecord.setTeacherName(course.getTeacherName());

        courseRecord.setCreateTime(new Date());

        return courseRecord;
    }

}
