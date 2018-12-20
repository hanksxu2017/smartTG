package cn.com.smart.web.service;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.entity.TGStudyCourseStudentRecord;
import cn.com.smart.web.bean.entity.TGStudyStudentCourseRel;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 课时服务类
 *
 * @author xuwenyi
 * @create 2018-12-06 16:18
 */
@Service
public class CourseBusinessService {

	@Autowired
	private StudyCourseRecordService courseRecordService;

	@Autowired
	private StudyStudentCourseRelService studentCourseRelService;

	@Autowired
	private StudyCourseStudentRecordService courseStudentRecordService;

	/**
	 * 创建一周课时记录
	 * @param startDate     开始时间,必须为周一
	 * @param courseList    课时表
	 * @return              执行结果
	 */
	public SmartResponse<String> generateWeekCourseRecord(Date startDate, List<TGStudyCourse> courseList) {
		TGStudyCourseRecord courseRecord;
		for(TGStudyCourse course : courseList) {
			List<TGStudyStudentCourseRel> studentCourseRelList = this.getStudentCourseRel(course.getId());
			if(CollectionUtils.isEmpty(studentCourseRelList)) {
				// 班级无学生,不进行排课
				continue;
			}
			courseRecord = this.initCourseRecord(course, startDate);
			if(null != courseRecord) {
				if(StringUtils.isBlank(courseRecord.getId())) {
					this.courseRecordService.save(courseRecord);
				}
				this.createCourseStudentRecord(courseRecord, studentCourseRelList);
			}
		}

		SmartResponse<String> smartResponse = new SmartResponse<>();
		smartResponse.setResult(IConstant.OP_SUCCESS);
		smartResponse.setMsg(IConstant.OP_SUCCESS_MSG);
		return smartResponse;
	}

	private List<TGStudyStudentCourseRel> getStudentCourseRel(String courseId) {
		Map<String, Object> params = new HashMap<>();
		params.put("status", IConstant.STATUS_NORMAL);
		params.put("courseId", courseId);
		return studentCourseRelService.findByParam(params).getDatas();
	}

	/**
	 *
	 * @param course
	 * @return
	 */
	private TGStudyCourseRecord initCourseRecord(TGStudyCourse course, Date startDate) {

		String courseDate =
				DateUtil.dateToStr(this.getWeekDate(course.getWeekInfo(), startDate), "yyyy-MM-dd");

		Map<String, Object> params = new HashMap<>();
		params.put("courseDate", courseDate);
		params.put("courseId", course.getId());
		List<TGStudyCourseRecord> courseRecords = this.courseRecordService.findByParam(params).getDatas();
		if(CollectionUtils.isNotEmpty(courseRecords)) {
			return courseRecords.get(0);
		}

		TGStudyCourseRecord courseRecord = new TGStudyCourseRecord();

		courseRecord.setCourseId(course.getId());
		courseRecord.setCourseDate(courseDate);
		courseRecord.setCourseTime(course.getCourseTime());
		courseRecord.setCourseName(course.getName());

		courseRecord.setClassroomId(course.getClassroomId());
		courseRecord.setClassroomName(course.getClassroomName());

		courseRecord.setTeacherId(course.getTeacherId());
		courseRecord.setTeacherName(course.getTeacherName());

		params = new HashMap<>();
		params.put("courseId", course.getId());
		Long count = studentCourseRelService.getCount(params);
		courseRecord.setStudentQuantityPlan(count.intValue());

		courseRecord.setCreateTime(new Date());

		return courseRecord;
	}

	private Date getWeekDate(short weekInfo, Date startDate) {
		if(weekInfo >= 1 && weekInfo <= 7) {
			return DateUtil.addDay(startDate, weekInfo - 1);
		}
		return null;
	}

	/**
	 * 生成课时对应的学生课时记录
	 * @param courseRecord
	 */
	private void createCourseStudentRecord(TGStudyCourseRecord courseRecord, List<TGStudyStudentCourseRel> studentCourseRelList) {

		Map<String, Object> params = new HashMap<>();
		params.put("status", IConstant.STATUS_NORMAL);
		params.put("courseId", courseRecord.getCourseId());
		TGStudyCourseStudentRecord courseStudentRecord;
		for(TGStudyStudentCourseRel rel : studentCourseRelList) {
			courseStudentRecord = this.initCourseStudentRecord(courseRecord, rel);
			if(StringUtils.isBlank(courseStudentRecord.getId())) {
				this.courseStudentRecordService.save(courseStudentRecord);
			}
		}
	}

	/**
	 *
	 * @param courseRecord
	 * @param rel
	 * @return
	 */
	private TGStudyCourseStudentRecord initCourseStudentRecord(TGStudyCourseRecord courseRecord, TGStudyStudentCourseRel rel) {

		Map<String, Object> params = new HashMap<>();
		params.put("courseRecordId", courseRecord.getId());
		params.put("studentId", rel.getStudentId());
		List<TGStudyCourseStudentRecord> courseStudentRecords = this.courseStudentRecordService.findByParam(params).getDatas();
		if(CollectionUtils.isNotEmpty(courseStudentRecords)) {
			return courseStudentRecords.get(0);
		}

		TGStudyCourseStudentRecord record = new TGStudyCourseStudentRecord();
		record.setCourseRecordId(courseRecord.getId());
		record.setCourseId(courseRecord.getCourseId());
		record.setStudentId(rel.getStudentId());
		record.setStudentName(rel.getStudentName());
		record.setCreateTime(new Date());
		return record;
	}

}
