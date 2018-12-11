package cn.com.smart.web.service;

import cn.com.smart.constant.enumEntity.CourseStudentRecordStatusEnum;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.bean.statistics.student.*;
import cn.com.smart.web.utils.DataUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.*;

/**
 * 
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
@Slf4j
public class StudyStService {

	@Autowired
	private StudyTeacherService teacherService;

	@Autowired
	private OPService opService;

	@Autowired
	private StudyStTeacherService statisticsTeacherService;

	/**
	 * 月末必须结清所有课时
	 */
	public void doTeacherMonthStatistics() {
		log.info("---------教师月数据统计---------");
		String curMonth = DateUtil.dateToStr(DateUtil.addMonth(new Date(), -1), "yyyyMM");
		List<TGStudyTeacher> teacherList = this.teacherService.findNormal().getDatas();
		if(CollectionUtils.isNotEmpty(teacherList)) {
			TGStudyStTeacher dbRecord;
			TGStudyStTeacher statisticsTeacher;
			for(TGStudyTeacher teacher : teacherList) {
				dbRecord = this.statisticsTeacherService.getByMonthAndTeacher(curMonth, teacher.getId());
				statisticsTeacher = this.statisticsTeacher(curMonth, teacher);
				if(null == dbRecord) {
					this.statisticsTeacherService.save(statisticsTeacher);
				} else {
					statisticsTeacher.setId(dbRecord.getId());
					statisticsTeacher.setCreateTime(dbRecord.getCreateTime());
					this.statisticsTeacherService.update(statisticsTeacher);
				}
			}
		}
	}

	private TGStudyStTeacher statisticsTeacher(String curMonth, TGStudyTeacher teacher) {
		TGStudyStTeacher statisticsTeacher = new TGStudyStTeacher();
		statisticsTeacher.setMonth(curMonth);
		statisticsTeacher.setTeacherId(teacher.getId());
		statisticsTeacher.setTeacherName(teacher.getName());

		statisticsTeacher.setCourseCount(this.getCountByOpService("st_course_count", teacher.getId()));
		statisticsTeacher.setCourseRecordCount(this.getCountByOpService("st_course_record_count", teacher.getId()));
		statisticsTeacher.setCourseRecordStudentCount(this.getCountByOpService("st_course_record_student_count", teacher.getId()));

		statisticsTeacher.setStudentCount(this.getCountByOpService("st_student_count", teacher.getId()));
		statisticsTeacher.setExitCourseCount(this.getCountByOpService("st_exit_course_count", teacher.getId()));
		statisticsTeacher.setDropOutCount(this.getCountByOpService("st_drop_out_count", teacher.getId()));

		// 新学生
		statisticsTeacher.setNewStudentCount(this.getCountByOpService("st_new_student_count", teacher.getId()));
		statisticsTeacher.setNewStudentExitCourseCount(this.getCountByOpService("st_new_student_exit_course_count", teacher.getId()));
		statisticsTeacher.setNewStudentDropOutCount(this.getCountByOpService("st_new_student_drop_out_count", teacher.getId()));

		int totalNewStudent = statisticsTeacher.getNewStudentCount() + statisticsTeacher.getNewStudentExitCourseCount();
		if(totalNewStudent > 0) {
			statisticsTeacher.setNewStudentExitCourseRate(DataUtil.getRate(statisticsTeacher.getNewStudentExitCourseCount(), totalNewStudent));
			statisticsTeacher.setNewStudentDropOutRate(DataUtil.getRate(statisticsTeacher.getNewStudentDropOutCount(), totalNewStudent));
		}

		int totalOldStudent = statisticsTeacher.getStudentCount() - statisticsTeacher.getNewStudentCount() +
				statisticsTeacher.getExitCourseCount() - statisticsTeacher.getNewStudentExitCourseCount();
		if(totalOldStudent > 0) {
			statisticsTeacher.setExitCourseRate(
					DataUtil.getRate((statisticsTeacher.getExitCourseCount() - statisticsTeacher.getNewStudentExitCourseCount()), totalOldStudent));
			statisticsTeacher.setDropOutRate(
					DataUtil.getRate((statisticsTeacher.getDropOutCount() - statisticsTeacher.getNewStudentDropOutCount()), totalOldStudent));
		}

		return statisticsTeacher;
	}

	private int getCountByOpService(String resId, String teacherId) {
		Map<String,Object> params = new HashMap<>();
		params.put("teacherId", teacherId);
		List<Object> studentCountList = this.opService.getDatas(resId, params).getDatas();
		BigInteger intValue = (BigInteger)studentCountList.get(0);
		return intValue.intValue();
	}


	@Autowired
	private StudyStudentService studentService;

	/**
	 * 统计所有学生的信息,包括续费，课时
	 * 月末必须对所有课时进行点名操作
	 */
	public void doStudentStatistics() {
		List<TGStudyStudent> studentList = this.studentService.findNormal().getDatas();
		if(CollectionUtils.isEmpty(studentList)) {
			return;
		}

		String month = DateUtil.dateToStr(DateUtil.addMonth(new Date(), -1), "yyyyMM");

		Map<String, TGStudyCourse> courseMap = new HashMap<>();
		Map<String, TGStudyCourseRecord> courseRecordMap = new HashMap<>();

		TGStudyStStudent stStudent;
		List<TGStudyStStudentSignRecord> stStudentSignRecordList;
		StudentStatistics studentStatistics;

		for(TGStudyStudent student : studentList) {
			studentStatistics = this.doSingleStudentStatistics(student, month, courseMap, courseRecordMap);
			stStudent = parseStStudent(studentStatistics);
			this.stStudentService.save(stStudent);

			if(stStudent.getTotalCount() > 0) {
				stStudentSignRecordList = this.parseStStudentSignRecord(stStudent.getId(), studentStatistics);
				this.stStudentSignRecordService.save(stStudentSignRecordList);
			}
		}
	}

	private TGStudyStStudent parseStStudent(StudentStatistics studentStatistics) {
		TGStudyStStudent stStudent = new TGStudyStStudent();
		if(null != studentStatistics) {
			stStudent.setMonth(studentStatistics.getMonth());
			stStudent.setStudentId(studentStatistics.getStudentId());
			stStudent.setStudentName(studentStatistics.getStudentName());
			stStudent.setDescription(studentStatistics.getDescription());
			stStudent.setCourseCount(studentStatistics.getCourseCount());
			stStudent.setCourseArr(DataUtil.arrayToString(studentStatistics.getCourseArr(), ","));
			stStudent.setCreateTime(new Date());

			StudentCourseSignStatistics signStatistics = studentStatistics.getStudentCourseSignStatistics();
			if(null != signStatistics) {
				stStudent.setTotalCount(signStatistics.getTotalCount());
				stStudent.setSignedCount(signStatistics.getSignedCount());
				stStudent.setPersonalLeaveCount(signStatistics.getPersonalLeaveCount());
				stStudent.setPlayTruantCount(signStatistics.getPlayTruantCount());
				stStudent.setMakeUpCount(signStatistics.getMakeUpCount());
				stStudent.setOthersCount(signStatistics.getOthersCount());
			}

			StudentRenewRecord renewRecord = studentStatistics.getStudentRenewRecord();
			if(null != renewRecord) {
				stStudent.setRemainCourse(renewRecord.getRemainCourse());
				stStudent.setAmountPayable(renewRecord.getAmountPayable());
				stStudent.setAmountPay(renewRecord.getAmountPay());
				stStudent.setPayDate(renewRecord.getPayDate());
			}
		}
		return stStudent;
	}

	/**
	 * 封装学生的课时签到信息
	 * @param stId                  学生统计信息编号
	 * @param studentStatistics     学生统计信息
	 * @return                      学生课时信息统计列表
	 */
	private List<TGStudyStStudentSignRecord> parseStStudentSignRecord(String stId, StudentStatistics studentStatistics) {
		List<TGStudyStStudentSignRecord> recordList = new ArrayList<>();
		if(null != studentStatistics && null != studentStatistics.getStudentCourseSignStatistics() &&
			CollectionUtils.isNotEmpty(studentStatistics.getStudentCourseSignStatistics().getStudentCourseSignRecordList())) {
			TGStudyStStudentSignRecord stStudentSignRecord;
			for(StudentCourseSignRecord studentCourseSignRecord : studentStatistics.getStudentCourseSignStatistics().getStudentCourseSignRecordList()) {
				stStudentSignRecord = parseStStudentSignRecord(stId, studentCourseSignRecord);
				recordList.add(stStudentSignRecord);
			}
		}
		return recordList;
	}

	private TGStudyStStudentSignRecord parseStStudentSignRecord(String stId, StudentCourseSignRecord studentCourseSignRecord) {
		TGStudyStStudentSignRecord record = new TGStudyStStudentSignRecord();
		record.setStatisticsId(stId);
		record.setCourseDate(studentCourseSignRecord.getCourseDate());
		record.setSignStatus(studentCourseSignRecord.getSignStatus().name());
		record.setSignType(studentCourseSignRecord.getSignType());
		record.setCourseRecordId(studentCourseSignRecord.getCourseRecordId());
		record.setCreateTime(new Date());
		return record;
	}

	/**
	 * 学生信息统计
	 * @param month         目标月份
	 * @param studentList   要统计的学生列表
	 * @return              统计对象
	 */
	public StudentStatisticsDataHandle doStudentStatistics(String month, List<TGStudyStudent> studentList) {
		StudentStatisticsDataHandle handle = new StudentStatisticsDataHandle();

		String curMonth = DateUtil.dateToStr(new Date(), "yyyyMM");
		if(StringUtils.equals(curMonth, month)) {
			// 查找当前月份的数据
			this.packageCurMonthStudentStatistics(month, studentList, handle);
		} else {
			// TODO 全部历史月份

		}


		return handle;
	}

	@Autowired
	private StudyStStudentService stStudentService;

	@Autowired
	private StudyStStudentSignRecordService stStudentSignRecordService;



	/**
	 * 执行学生统计</br>
	 * @param studentList   要统计的学生列表
	 * @param dataHandle    统计对象
	 */
	private void packageCurMonthStudentStatistics(String month, List<TGStudyStudent> studentList, StudentStatisticsDataHandle dataHandle) {
		List<StudentStatistics> studentStatisticsList = new ArrayList<>();
		if(CollectionUtils.isNotEmpty(studentList)) {
			// 最大班级数
			int maxCourseCount = 0;
			// 最大月时数
			int maxCourseDay = 0;
			//
			int previousMaxCourseDay = 0;
			StudentStatistics studentStatistics;

			Map<String, TGStudyCourse> courseMap = new HashMap<>();
			Map<String, TGStudyCourseRecord> courseRecordMap = new HashMap<>();
			for(TGStudyStudent student : studentList) {
				studentStatistics = this.doSingleStudentStatistics(student, month, courseMap, courseRecordMap);
				studentStatisticsList.add(studentStatistics);

				if(studentStatistics.getCourseCount() > maxCourseCount) {
					maxCourseCount = studentStatistics.getCourseCount();
				}
				if(studentStatistics.getStudentCourseSignStatistics().getTotalCount() > maxCourseDay) {
					maxCourseDay = studentStatistics.getStudentCourseSignStatistics().getTotalCount();
				}

				if(studentStatistics.getStudentCourseSignStatistics().getPreviousSignCount() > previousMaxCourseDay) {
					previousMaxCourseDay = studentStatistics.getStudentCourseSignStatistics().getPreviousSignCount();
				}
			}

			dataHandle.setMonthInTable(month.substring(0, 4) + "年" + month.substring(4));
			dataHandle.setMaxCourseCount(maxCourseCount);
			dataHandle.setMaxCourseDay(maxCourseDay);

			Date lastMonth = DateUtil.addMonth(new Date(), -1);
			dataHandle.setPreviousMonthInTable(DateUtil.dateToStr(lastMonth, "yyyy年MM月"));
			dataHandle.setPreviousMaxCourseDay(previousMaxCourseDay);

//			Collections.sort(studentStatisticsList);
			dataHandle.setStudentStatisticsList(studentStatisticsList);
		}
	}

	@Autowired
	private StudyStudentCourseRelService studentCourseRelService;

	/**
	 * 执行单个学生的统计
	 * @param student   要统计的学生对象
	 * @param month     要统计的月份
	 * @return          统计结果
	 */
	private StudentStatistics doSingleStudentStatistics(TGStudyStudent student, String month,
	                                                    Map<String, TGStudyCourse> courseMap, Map<String, TGStudyCourseRecord> courseRecordMap) {
		StudentStatistics studentStatistics = new StudentStatistics();
		studentStatistics.setMonth(month);

		studentStatistics.setStudentId(student.getId());
		studentStatistics.setStudentName(student.getName());
		studentStatistics.setDescription(StringUtils.isNotBlank(student.getDescription()) ? student.getDescription() : "");
		studentStatistics.setStudentPhone(student.getParentPhone());
		this.packageCourseStatistics(student.getId(), studentStatistics, courseMap);

		this.packageStudentRenewRecord(student, studentStatistics);

		this.packageStudentCourseSignStatistics(student, studentStatistics, courseRecordMap);

		return studentStatistics;
	}

	/**
	 * 统计课时信息
	 * @param studentId             学生编号
	 * @param studentStatistics     统计对象
	 * @param courseMap             课时表
	 */
	private void packageCourseStatistics(String studentId, StudentStatistics studentStatistics, Map<String, TGStudyCourse> courseMap) {
		List<TGStudyStudentCourseRel> studentCourseRelList = this.studentCourseRelService.findNormalByStudentId(studentId);
		if(CollectionUtils.isNotEmpty(studentCourseRelList)) {
			studentStatistics.setCourseCount(studentCourseRelList.size());
			String[] courseArr = new String[studentCourseRelList.size()];
			TGStudyCourse course;
			TGStudyStudentCourseRel studentCourseRel;
			for(int index = 0; index < studentCourseRelList.size(); index++) {
				studentCourseRel = studentCourseRelList.get(index);
				course = this.getCourseFromMap(studentCourseRel.getCourseId(), courseMap);
				if(null != course) {
					courseArr[index] = course.getTeacherName().substring(0, 1) + DataUtil.numToCN(course.getWeekInfo()) + course.getCourseTimeIndex();
				}

			}
			studentStatistics.setCourseArr(courseArr);
		}
	}

	@Autowired
	private StudyCourseService courseService;

	private TGStudyCourse getCourseFromMap(String courseId, Map<String, TGStudyCourse> courseMap) {
		TGStudyCourse course = courseMap.get(courseId);
		if(null == course) {
			course = this.courseService.find(courseId).getData();
			if(null != course) {
				courseMap.put(courseId, course);
			}
		}
		return course;
	}

	@Autowired
	private StudyRenewRecordService renewRecordService;

	/**
	 * 统计续费信息
	 * @param student               学生
	 * @param studentStatistics     统计对象
	 */
	private void packageStudentRenewRecord(TGStudyStudent student, StudentStatistics studentStatistics) {
		StudentRenewRecord studentRenewRecord = new StudentRenewRecord();
		studentRenewRecord.setStudentId(student.getId());
		studentRenewRecord.setMonth(studentStatistics.getMonth());
		studentRenewRecord.setRemainCourse(student.getRemainCourse());
		studentRenewRecord.setAmountPayable(student.getRenewAmount());
		List<TGStudyRenewRecord> renewRecordList = this.renewRecordService.findByStudentId(student.getId());
		if(CollectionUtils.isNotEmpty(renewRecordList)) {
			for(TGStudyRenewRecord renewRecord : renewRecordList) {
				if(StringUtils.equals(DateUtil.dateToStr(renewRecord.getCreateTime(), "yyyyMM"), studentStatistics.getMonth())) {
					studentRenewRecord.setAmountPay(studentRenewRecord.getAmountPay() + renewRecord.getAmount());
					studentRenewRecord.setPayDate(studentRenewRecord.getPayDate() + "," +
							DateUtil.dateToStr(renewRecord.getCreateTime(), "dd").replaceFirst("^0*", ""));
				}
			}
			studentRenewRecord.setPayDate(studentRenewRecord.getPayDate().replaceFirst(",", ""));
		}

		studentStatistics.setStudentRenewRecord(studentRenewRecord);
	}

	@Autowired
	private StudyCourseStudentRecordService courseStudentRecordService;

	/**
	 * 统计学生的课时签到信息
	 * @param student               学生
	 * @param studentStatistics     统计对象
	 */
	private void packageStudentCourseSignStatistics(TGStudyStudent student, StudentStatistics studentStatistics, Map<String, TGStudyCourseRecord> courseRecordMap) {
		StudentCourseSignStatistics courseSignStatistics = new StudentCourseSignStatistics();
		courseSignStatistics.setStudentId(student.getId());
		courseSignStatistics.setMonth(studentStatistics.getMonth());
		// 上一个月的签到统计信息
		courseSignStatistics.setStStudentSignRecordList(parsePreviousSignRecord(studentStatistics.getMonth(), student));
		if(CollectionUtils.isNotEmpty(courseSignStatistics.getStStudentSignRecordList())) {
			courseSignStatistics.setPreviousSignCount(courseSignStatistics.getStStudentSignRecordList().size());
		}

		List<TGStudyCourseStudentRecord> courseStudentRecordList = this.courseStudentRecordService.findByStudentId(student.getId());
		if(CollectionUtils.isNotEmpty(courseStudentRecordList)) {
			for(TGStudyCourseStudentRecord courseStudentRecord : courseStudentRecordList) {
			    if(StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentRecordStatusEnum.X_MAKE_UP.name())) {
			        // 补课记录不进行统计
			        continue;
                }
				if(this.isCourseRecordInMonth(courseStudentRecord, studentStatistics.getMonth(), courseRecordMap)) {
					this.parseCourseStudentRecordToStatistics(courseStudentRecord, courseSignStatistics, courseRecordMap);
				}
			}
			Collections.sort(courseSignStatistics.getStudentCourseSignRecordList());
		}

		studentStatistics.setStudentCourseSignStatistics(courseSignStatistics);
	}

	/**
	 * 查询历史月份的学生统计信息
	 * @param month         要查找的月份
	 * @param student       要查找的学生
	 */
	private List<TGStudyStStudentSignRecord> parsePreviousSignRecord(String month, TGStudyStudent student) {
		String previousMonth = DateUtil.dateToStr(DateUtil.addMonth(DateUtil.parseDate(month, "yyyyMM"), -1), "yyyyMM");
		TGStudyStStudent statisticsStudent;
		List<TGStudyStStudentSignRecord> stStudentSignRecordList;
		statisticsStudent = stStudentService.findByStudentId(student.getId(), previousMonth);
		if (null != statisticsStudent) {
			// 查询课时签到信息
			stStudentSignRecordList = this.stStudentSignRecordService.findByStatisticsId(statisticsStudent.getId());
			if (CollectionUtils.isNotEmpty(stStudentSignRecordList)) {
				Collections.sort(stStudentSignRecordList);
				return stStudentSignRecordList;
			}
		}
		return null;
	}

	private boolean isCourseRecordInMonth(TGStudyCourseStudentRecord courseStudentRecord, String month, Map<String, TGStudyCourseRecord> courseRecordMap) {
        TGStudyCourseRecord courseRecord = this.getCourseRecordFromMap(courseStudentRecord.getCourseRecordId(), courseRecordMap);
        if(null != courseRecord && StringUtils.isNotBlank(courseRecord.getCourseDate())) {
            String courseMonth;
            try {
                courseMonth = courseRecord.getCourseDate().replaceAll("-", "").substring(0, 6);
                log.info("{}----month:{}", courseStudentRecord.getId(), courseMonth);
            } catch (Exception e) {
                courseMonth = "";
            }
            return StringUtils.equals(courseMonth, month);
        }

        return false;
	}

	/**
	 *
	 * @param courseStudentRecord   学生的课时对象
	 * @param courseSignStatistics  课时签到对象
	 */
	private void parseCourseStudentRecordToStatistics(TGStudyCourseStudentRecord courseStudentRecord,
	                                                  StudentCourseSignStatistics courseSignStatistics,
	                                                  Map<String, TGStudyCourseRecord> courseRecordMap) {
		courseSignStatistics.setTotalCount(courseSignStatistics.getTotalCount() + 1);
		if(StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentRecordStatusEnum.SIGNED.name())) {
			courseSignStatistics.setSignedCount(courseSignStatistics.getSignedCount() + 1);
		} else if(StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentRecordStatusEnum.PERSONAL_LEAVE.name())){
			courseSignStatistics.setPersonalLeaveCount(courseSignStatistics.getPersonalLeaveCount() + 1);
		} else if(StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentRecordStatusEnum.PLAY_TRUANT.name())){
			courseSignStatistics.setPlayTruantCount(courseSignStatistics.getPlayTruantCount() + 1);
		} else {
			courseSignStatistics.setOthersCount(courseSignStatistics.getOthersCount() + 1);
		}
		courseSignStatistics.getStudentCourseSignRecordList().add(this.initStudentCourseSignRecord(courseStudentRecord, courseSignStatistics, courseRecordMap));
	}

	/**
	 *
	 * @param courseStudentRecord   学生的课时对象
	 * @param courseSignStatistics  课时签到对象
	 * @param courseRecordMap       课时记录MAP
	 * @return                      学生课时签到统计信息
	 */
	private StudentCourseSignRecord initStudentCourseSignRecord(TGStudyCourseStudentRecord courseStudentRecord,
	                                                            StudentCourseSignStatistics courseSignStatistics,
	                                                            Map<String, TGStudyCourseRecord> courseRecordMap) {
		StudentCourseSignRecord studentCourseSignRecord = new StudentCourseSignRecord();
		studentCourseSignRecord.setStudentId(courseStudentRecord.getStudentId());
		studentCourseSignRecord.setMonth(courseSignStatistics.getMonth());
		studentCourseSignRecord.setCourseRecordId(courseStudentRecord.getCourseRecordId());
		studentCourseSignRecord.setSignType(courseStudentRecord.getSignType());

		TGStudyCourseRecord courseRecord = this.getCourseRecordFromMap(courseStudentRecord.getCourseRecordId(), courseRecordMap);
		if(null != courseRecord && StringUtils.isNotBlank(courseRecord.getCourseDate())) {
			String courseDate = courseRecord.getCourseDate();
			String day = courseDate.substring(courseDate.length() - 2);
			if(StringUtils.isNotBlank(day) && day.startsWith("0")) {
				day =  day.substring(1);
			}
			studentCourseSignRecord.setCourseDate(Integer.valueOf(day));
		}
		studentCourseSignRecord.setSignStatus(CourseStudentRecordStatusEnum.valueOf(courseStudentRecord.getStatus()));

		return studentCourseSignRecord;
	}

	@Autowired
	private StudyCourseRecordService courseRecordService;

	private TGStudyCourseRecord getCourseRecordFromMap(String courseRecordId, Map<String, TGStudyCourseRecord> courseRecordMap) {
		TGStudyCourseRecord courseRecord = courseRecordMap.get(courseRecordId);
		if(null == courseRecord) {
			courseRecord = this.courseRecordService.find(courseRecordId).getData();
			if(null != courseRecord) {
				courseRecordMap.put(courseRecordId, courseRecord);
			}
		}
		return courseRecord;
	}

}
