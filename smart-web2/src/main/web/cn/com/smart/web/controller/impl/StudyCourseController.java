package cn.com.smart.web.controller.impl;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.RequestPage;
import cn.com.smart.web.bean.course.*;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.search.CourseSearch;
import cn.com.smart.web.controller.base.BaseController;
import cn.com.smart.web.service.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

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
	    ModelAndView modelView = new ModelAndView();
	    modelView.getModelMap().put("searchParam", searchParam);
        modelView.setViewName(this.getPageDir() + "table");
        return modelView;
    }

//	@RequestMapping("/table")
//	public ModelAndView table() {
//		ModelAndView modelView = new ModelAndView();
//		modelView.setViewName(this.getPageDir() + "table");
//		return modelView;
//	}

	@Autowired
	private StudyCourseTableService courseTableService;

	@RequestMapping(value = "/generateCourseTable", method = RequestMethod.GET)
	@ResponseBody
	public SmartResponse<CourseTable> generateCourseTable() {
		SmartResponse<CourseTable> smartResponse = new SmartResponse<>();

		smartResponse.setData(this.courseTableService.getCourseTable());
		smartResponse.setResult(IConstant.OP_SUCCESS);
		smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
		return smartResponse;
	}

	@Autowired
	private StudyClassroomService classroomService;

    @Autowired
    private DictService dictService;

    @Autowired
    private StudyClassroomRentalService classroomRentalService;

	/**
	 * 封装课时表对象
	 * @return
	 */
	private CourseTable packageCourseTable() {
        CourseTable courseTable = new CourseTable();

		// 获取所有课时对象
		List<TGStudyCourse> courseList = this.courseService.findNormal().getDatas();
		// 将租赁信息放入课程表
        List<TGStudyCourse> rentalCourseList = this.packageClassroomRentalToCourse();
        if(CollectionUtils.isNotEmpty(rentalCourseList)){
            courseList.addAll(rentalCourseList);
        }

		if(CollectionUtils.isEmpty(courseList)) {
			return courseTable;
		}

		// 表格头
		CourseTh courseTh = new CourseTh();
		// 表格行
		List<CourseTr> courseTrList = new ArrayList<>();

		// 存在课时的教师信息
		Map<String, TGStudyClassroom> classroomMap = new HashMap<>();

		CourseTd courseTd;

		// 将课时数据写入表格对象
		for(TGStudyCourse course : courseList){
			courseTd = this.packageCourseTd(course, classroomMap);
			this.choosePosForTd(courseTrList, courseTd);
		}

		Iterator<TGStudyClassroom> iterator = classroomMap.values().iterator();
		while(iterator.hasNext()) {
			courseTh.getClassroomList().add(iterator.next());
		}
		Collections.sort(courseTh.getClassroomList());

		courseTable.setTh(courseTh);

		courseTable.setTrs(courseTrList);
        return courseTable;
    }

    private List<TGStudyCourse> packageClassroomRentalToCourse() {
        List<TGStudyCourse> studyCourseList = new ArrayList<>();

        List<TGStudyClassroomRental> classroomRentalList = this.classroomRentalService.findNormal().getDatas();
        if(CollectionUtils.isNotEmpty(classroomRentalList)) {
            TGStudyCourse course;
            for(TGStudyClassroomRental classroomRental : classroomRentalList) {
                course = new TGStudyCourse();
                course.setCourseTimeIndex(classroomRental.getCourseTimeIndex());
                course.setWeekInfo(classroomRental.getWeekInfo());
                course.setTeacherName(classroomRental.getName());
                course.setClassroomId(classroomRental.getClassroomId());
                studyCourseList.add(course);
            }
        }
        return studyCourseList;
    }

	/**
	 * 一个课时生成一个单元格
	 * @param course    课时对象
	 * @return          单元格对象
	 */
	private CourseTd packageCourseTd(TGStudyCourse course, Map<String, TGStudyClassroom> classroomMap) {

	    // 1. 获取教室信息
		TGStudyClassroom classroom = classroomMap.get(course.getClassroomId());
		if(null == classroom) {
			classroom = this.classroomService.find(course.getClassroomId()).getData();
			if(null != classroom) {
				classroomMap.put(course.getClassroomId(), classroom);
			}
		}
		// 无教室信息
		if(null == classroom) {
			return null;
		}
		CourseTd courseTd = new CourseTd();
		courseTd.setClassroomId(classroom.getId());
		courseTd.setClassroomSortOrder(classroom.getSortOrder());

		courseTd.setWeekInfo(course.getWeekInfo());

		courseTd.setCourseTimeIndex(course.getCourseTimeIndex());
		courseTd.setCourse(course);
	    return courseTd;
    }

	/**
	 * 为单元格选择正确的行位置进行放置
	 * @param courseTrList  行对象列表
	 * @param courseTd      单元格对象
	 */
	private void choosePosForTd(List<CourseTr> courseTrList, CourseTd courseTd) {
		boolean isFoundCurCourseTime = false;
		boolean isFoundCurWeekInfo = false;
		boolean isExistEarlier = false;
		for (CourseTr courseTr : courseTrList) {
			if (courseTr.getWeekInfoEntity().getWeekInfo() == courseTd.getWeekInfo()) {
                isFoundCurWeekInfo = true;
				if (courseTr.getCourseTimeEntity().getCourseTimeIndex() == courseTd.getCourseTimeIndex()) {
					// 当前(星期+时间)行已存在
                    isFoundCurCourseTime = true;
					courseTr.getTds().add(courseTd);
					Collections.sort(courseTr.getTds());
					break;
				} else {
				    // 当前时间没找到
                    if(courseTr.getCourseTimeEntity().getCourseTimeIndex() < courseTd.getCourseTimeIndex()) {
                        isExistEarlier = true;
                    } else if(courseTr.getCourseTimeEntity().getCourseTimeIndex() > courseTd.getCourseTimeIndex()) {
                        courseTr.getCourseTimeEntity().setFirst("NO");
                    }
                }
			}
		}

		if(!isFoundCurWeekInfo) {
            addCourseTdToNewTr(courseTrList, courseTd, isExistEarlier);
		} else {
			// 当情星期已经存在
			if(!isFoundCurCourseTime) {
				// 当前星期增加一个课时
				addCourseTdToNewTr(courseTrList, courseTd, isExistEarlier);
				this.updateCourseCount(courseTrList, courseTd.getWeekInfo(), courseTd.getCourseTimeIndex());
			}

		}
    }

    private void addCourseTdToNewTr(List<CourseTr> courseTrList, CourseTd courseTd, boolean isExistEarlier) {
        CourseTr courseTr = new CourseTr();
        courseTr.setWeekInfoEntity(new WeekInfoEntity(courseTd.getWeekInfo(), parseWeekInfo(courseTd.getWeekInfo()), 1));
        courseTr.setCourseTimeEntity(new CourseTimeEntity(courseTd.getCourseTimeIndex(), this.parseCourseTime(courseTd.getCourseTimeIndex())));
        if(isExistEarlier) {
            courseTr.getCourseTimeEntity().setFirst("NO");
        }
        courseTr.getTds().add(courseTd);
        courseTrList.add(courseTr);
        Collections.sort(courseTrList);
    }

    /**
     * 指定星期的行数记录数+1
     * @param courseTrList      行对象
     * @param weekInfo         星期
     */
    private void updateCourseCount(List<CourseTr> courseTrList, int weekInfo, int courseTimeIndex) {
    	int count = 0;
        for(CourseTr courseTr : courseTrList) {
            if(courseTr.getWeekInfoEntity().getWeekInfo() == weekInfo) {
				if(courseTr.getCourseTimeEntity().getCourseTimeIndex() != courseTimeIndex) {
					count = courseTr.getWeekInfoEntity().getCourseCount() + 1;
					courseTr.getWeekInfoEntity().setCourseCount(count);
				}
            }
        }
	    for(CourseTr courseTr : courseTrList) {
		    if(courseTr.getWeekInfoEntity().getWeekInfo() == weekInfo &&
				    courseTr.getCourseTimeEntity().getCourseTimeIndex() == courseTimeIndex) {
			    courseTr.getWeekInfoEntity().setCourseCount(count);
		    }
	    }
    }

    private String parseCourseTime(int courseTimeIndex) {
	    TNDict dict = this.dictService.getDict("COURSE_TIMES", String.valueOf(courseTimeIndex));
	    if(null != dict) {
	    	return dict.getBusiName();
	    }
	    return "";
    }

    private String parseWeekInfo(int weekInfo) {
	    TNDict dict = this.dictService.getDict("WEEK_INFO_LIST", String.valueOf(weekInfo));
	    if(null != dict) {
		    return dict.getBusiName();
	    }
	    return "";
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

		this.packTeacherInfo(course);
		course.setUpdateTime(new Date());
		course.setName(this.concatCourseName(course));
		course.setCreateTime(DateUtil.parseDate(course.getCreateTimeStr(), "yyyy-MM-dd"));

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
        course.setCreateTime(DateUtil.parseDate(course.getCreateTimeStr(), "yyyy-MM-dd"));
        this.packTeacherInfo(course);

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
        String checkRes = this.checkTeacherCourse(course.getCourseTimeIndex(), course.getWeekInfo(), course.getTeacherId(), course.getId());
        if(StringUtils.isNotBlank(checkRes)) {
            return checkRes;
        }
        checkRes = this.checkClassroom(course.getCourseTimeIndex(), course.getWeekInfo(), course.getClassroomId(), course.getId());
        if(StringUtils.isNotBlank(checkRes)) {
            return checkRes;
        }
        return "";
    }

    private String checkTeacherCourse(short courseTimeIndex, short weekInfo, String teacherId, String courseId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseTimeIndex", courseTimeIndex);
        params.put("weekInfo", weekInfo);
        params.put("teacherId", teacherId);
        SmartResponse<TGStudyCourse> courseSmartResponse = this.courseService.findByParam(params);
        if(courseSmartResponse.isSuccess() && courseSmartResponse.getTotalNum() > 0) {
        	if(StringUtils.isBlank(courseId) || !StringUtils.equals(courseId, courseSmartResponse.getDatas().get(0).getId())) {
		        return "课程冲突:同时间点,教师存在其他课程";
	        }
        }
        return "";
    }

    private String checkClassroom(short courseTimeIndex, short weekInfo, String classroomId, String courseId) {
        Map<String, Object> params = new HashMap<>();
        params.put("courseTimeIndex", courseTimeIndex);
        params.put("weekInfo", weekInfo);
        params.put("classroomId", classroomId);
        SmartResponse<TGStudyCourse> courseSmartResponse = this.courseService.findByParam(params);
        if(courseSmartResponse.isSuccess() && courseSmartResponse.getTotalNum() > 0) {
        	if(StringUtils.isBlank(courseId) || !StringUtils.equals(courseId, courseSmartResponse.getDatas().get(0).getId())) {
		        return "课程冲突:同时间点,教室已被其他课程占用.";
	        }
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
