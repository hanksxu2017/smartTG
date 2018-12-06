package cn.com.smart.web.service;

import cn.com.smart.web.bean.course.*;
import cn.com.smart.web.bean.entity.TGStudyClassroom;
import cn.com.smart.web.bean.entity.TGStudyClassroomRental;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TNDict;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * 描述:
 * 课程表服务
 *
 * @outhor xuwenyi
 * @create 2018-12-06 10:31
 */
@Slf4j
@Service
public class StudyCourseTableService {

	private CourseTable courseTable;

	@Autowired
	private StudyCourseService courseService;

	@Autowired
	private StudyClassroomService classroomService;

	@Autowired
	private DictService dictService;

	@Autowired
	private StudyClassroomRentalService classroomRentalService;

	public synchronized CourseTable getCourseTable() {
		if(null == courseTable) {
			this.courseTable = this.packageCourseTable();
		}

		return courseTable;
	}

	public void clearCourseTable() {
		this.courseTable = null;
	}

	/**
	 * 封装课时表对象
	 * @return
	 */
	private CourseTable packageCourseTable() {
		log.info("-----课程表初始化...");
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
		} else if(!isFoundCurCourseTime) {
			addCourseTdToNewTr(courseTrList, courseTd, isExistEarlier);
			this.updateCourseCount(courseTrList, courseTd.getWeekInfo(), courseTd.getCourseTimeIndex());
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

}
