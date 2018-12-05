package cn.com.smart.web.service;

import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyStatisticsTeacher;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.utils.DataUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
@Slf4j
public class StudyStatisticsService {

	@Autowired
	private StudyTeacherService teacherService;

	@Autowired
	private OPService opService;

	@Autowired
	private StudyStatisticsTeacherService statisticsTeacherService;

	/**
	 * 月末必须结清所有课时
	 */
	public void doTeacherMonthStatistics() {
		log.info("---------教师月数据统计---------");
		String curMonth = DateUtil.dateToStr(DateUtil.addMonth(new Date(), -1), "yyyyMM");
		List<TGStudyTeacher> teacherList = this.teacherService.findNormal().getDatas();
		if(CollectionUtils.isNotEmpty(teacherList)) {
			TGStudyStatisticsTeacher dbRecord;
			TGStudyStatisticsTeacher statisticsTeacher;
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

	private TGStudyStatisticsTeacher statisticsTeacher(String curMonth, TGStudyTeacher teacher) {
		TGStudyStatisticsTeacher statisticsTeacher = new TGStudyStatisticsTeacher();
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

}
