package cn.com.smart.web.bean.entity;

import cn.com.smart.bean.BaseBeanImpl;
import cn.com.smart.bean.DateBean;
import cn.com.smart.web.bean.statistics.student.StudentCourseSignStatistics;
import cn.com.smart.web.bean.statistics.student.StudentRenewRecord;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * 描述:
 * 学生的概要统计信息
 *
 * @outhor xuwenyi
 * @create 2018-12-07 9:21
 */
@Entity
@Table(name="tg_study_statistics_student")
public class TGStudyStStudent extends BaseBeanImpl implements DateBean {

	String id;
	// 统计的月份
	private String month;
	// 学生编号
	private String studentId;
	//
	private String studentName;
	// 续费处理的备注信息
	private String description = "";
	//
	private int courseCount;
	//
	private String courseArr;
	//
	private Date createTime;
	//
	private int totalCount;
	//
	private int signedCount;
	//
	private int personalLeaveCount;
	//
	private int playTruantCount;
	//
	private int makeUpCount;
	//
	private int othersCount;

	// 结余课时
	private int remainCourse;
	// 应付款项,单位元
	private int amountPayable;
	// 实付金额,单位元
	private int amountPay;
	// 付款日期,多个使用逗号连接
	private String payDate;

	@Id
	@Column(name="id", length=64)
	@Override
	public String getId() {
		return id;
	}

	@Override
	public void setId(String id) {
		this.id = id;
	}

	@Column(name="month", length=16)
	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	@Column(name="student_id", length=64)
	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	@Column(name="student_name", length=64)
	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	@Column(name="description", length=64)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name="course_count", length=4)
	public int getCourseCount() {
		return courseCount;
	}

	public void setCourseCount(int courseCount) {
		this.courseCount = courseCount;
	}

	@Column(name="course_arr", length=64)
	public String getCourseArr() {
		return courseArr;
	}

	public void setCourseArr(String courseArr) {
		this.courseArr = courseArr;
	}

	@Column(name="create_time", length=64)
	@Override
	public Date getCreateTime() {
		return createTime;
	}

	@Override
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name="total_count", length=4)
	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	@Column(name="signed_count", length=4)
	public int getSignedCount() {
		return signedCount;
	}

	public void setSignedCount(int signedCount) {
		this.signedCount = signedCount;
	}

	@Column(name="personal_leave_count", length=4)
	public int getPersonalLeaveCount() {
		return personalLeaveCount;
	}

	public void setPersonalLeaveCount(int personalLeaveCount) {
		this.personalLeaveCount = personalLeaveCount;
	}

	@Column(name="play_truant_count", length=4)
	public int getPlayTruantCount() {
		return playTruantCount;
	}

	public void setPlayTruantCount(int playTruantCount) {
		this.playTruantCount = playTruantCount;
	}

	@Column(name="make_up_count", length=4)
	public int getMakeUpCount() {
		return makeUpCount;
	}

	public void setMakeUpCount(int makeUpCount) {
		this.makeUpCount = makeUpCount;
	}

	@Column(name="others_count", length=4)
	public int getOthersCount() {
		return othersCount;
	}

	public void setOthersCount(int othersCount) {
		this.othersCount = othersCount;
	}

	@Column(name="remain_course", length=4)
	public int getRemainCourse() {
		return remainCourse;
	}

	public void setRemainCourse(int remainCourse) {
		this.remainCourse = remainCourse;
	}

	@Column(name="amount_payable", length=8)
	public int getAmountPayable() {
		return amountPayable;
	}

	public void setAmountPayable(int amountPayable) {
		this.amountPayable = amountPayable;
	}

	@Column(name="amount_pay", length=8)
	public int getAmountPay() {
		return amountPay;
	}

	public void setAmountPay(int amountPay) {
		this.amountPay = amountPay;
	}

	@Column(name="pay_date", length=32)
	public String getPayDate() {
		return payDate;
	}

	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}
}
