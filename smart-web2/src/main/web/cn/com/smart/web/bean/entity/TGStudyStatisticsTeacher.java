package cn.com.smart.web.bean.entity;

import cn.com.smart.bean.BaseBeanImpl;
import cn.com.smart.bean.DateBean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * 教师统计信息
 *
 * @outhor xuwenyi
 * @create 2018-12-05 9:35
 */
@Entity
@Table(name="tg_study_statistics_teacher")
public class TGStudyStatisticsTeacher extends BaseBeanImpl implements DateBean {

	private String id;

	// 统计数据以月为单位
	// 统计月份
	private String month;

	// 教师编号
	private String teacherId;

	// 教师姓名
	private String teacherName;

	// 月带班数
	private int courseCount;

	// 月带班学生数
	private int studentCount;

	// 月课时数
	private int courseRecordCount;

	// 月课时学生人次
	private int courseRecordStudentCount;

	// 月退班学生数
	private int exitCourseCount;

	// 月退学学生数
	private int dropOutCount;

	// 月新入学生数
	private int newStudentCount;

	// 月新入学生退班数
	private int newStudentExitCourseCount;

	// 月新入学生退学数
	private int newStudentDropOutCount;

	// 新生退班比率(实际值*100)
	private String newStudentExitCourseRate = "0.00";

	// 新生退学比率(实际值*100)
	private String newStudentDropOutRate = "0.00";

	// 退班比率(实际值*100)
	private String exitCourseRate = "0.00";

	// 退学比率(实际值*100)
	private String dropOutRate = "0.00";

	private Date createTime;


	@Id
	@Column(name="id", length=64)
	@Override
	public String getId() {
		return this.id;
	}

	@Override
	public void setId(String id) {
		this.id = id;
	}

	@Column(name="create_time", length=20)
	@Override
	public Date getCreateTime() {
		return this.createTime;
	}

	@Override
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name="month", length=16)
	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	@Column(name="teacher_id", length=64)
	public String getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
	}

	@Column(name="teacher_name", length=64)
	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	@Column(name="course_count", length=4)
	public int getCourseCount() {
		return courseCount;
	}

	public void setCourseCount(int courseCount) {
		this.courseCount = courseCount;
	}

	@Column(name="student_count", length=4)
	public int getStudentCount() {
		return studentCount;
	}

	public void setStudentCount(int studentCount) {
		this.studentCount = studentCount;
	}

	@Column(name="course_record_student_count", length=4)
	public int getCourseRecordStudentCount() {
		return courseRecordStudentCount;
	}

	public void setCourseRecordStudentCount(int courseRecordStudentCount) {
		this.courseRecordStudentCount = courseRecordStudentCount;
	}

	@Column(name="drop_out_count", length=4)
	public int getDropOutCount() {
		return dropOutCount;
	}

	public void setDropOutCount(int dropOutCount) {
		this.dropOutCount = dropOutCount;
	}

	@Column(name="exit_course_count", length=4)
	public int getExitCourseCount() {
		return exitCourseCount;
	}

	public void setExitCourseCount(int exitCourseCount) {
		this.exitCourseCount = exitCourseCount;
	}

	@Column(name="new_student_count", length=4)
	public int getNewStudentCount() {
		return newStudentCount;
	}

	public void setNewStudentCount(int newStudentCount) {
		this.newStudentCount = newStudentCount;
	}

	@Column(name="drop_out_rate", length=8)
	public String getDropOutRate() {
		return dropOutRate;
	}

	public void setDropOutRate(String dropOutRate) {
		this.dropOutRate = dropOutRate;
	}

	@Column(name="exit_course_rate", length=8)
	public String getExitCourseRate() {
		return exitCourseRate;
	}

	public void setExitCourseRate(String exitCourseRate) {
		this.exitCourseRate = exitCourseRate;
	}

	@Column(name="new_student_drop_out_rate", length=8)
	public String getNewStudentDropOutRate() {
		return newStudentDropOutRate;
	}

	public void setNewStudentDropOutRate(String newStudentDropOutRate) {
		this.newStudentDropOutRate = newStudentDropOutRate;
	}

	@Column(name="new_student_exit_course_rate", length=8)
	public String getNewStudentExitCourseRate() {
		return newStudentExitCourseRate;
	}

	public void setNewStudentExitCourseRate(String newStudentExitCourseRate) {
		this.newStudentExitCourseRate = newStudentExitCourseRate;
	}

	@Column(name="course_record_count", length=4)
	public int getCourseRecordCount() {
		return courseRecordCount;
	}

	public void setCourseRecordCount(int courseRecordCount) {
		this.courseRecordCount = courseRecordCount;
	}

	@Column(name="new_student_exit_course_count", length=4)
	public int getNewStudentExitCourseCount() {
		return newStudentExitCourseCount;
	}

	public void setNewStudentExitCourseCount(int newStudentExitCourseCount) {
		this.newStudentExitCourseCount = newStudentExitCourseCount;
	}

	@Column(name="new_student_drop_out_count", length=4)
	public int getNewStudentDropOutCount() {
		return newStudentDropOutCount;
	}

	public void setNewStudentDropOutCount(int newStudentDropOutCount) {
		this.newStudentDropOutCount = newStudentDropOutCount;
	}
}
