package cn.com.smart.web.bean.entity;

import cn.com.smart.bean.BaseBeanImpl;
import cn.com.smart.bean.DateBean;
import cn.com.smart.constant.IConstant;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 *
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Entity
@Table(name="tg_study_renew_record")
public class TGStudyRenewRecord extends BaseBeanImpl implements DateBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4257684310254668325L;

	private String id;

	private String studentId;
	
	private String studentName;

	private int amount;

	private int courseCount;

	private String description;

	private String operatorId;

	private String operatorFullName;

	private Date createTime;

	@Id
	@Column(name="id", length=64)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	@Column(name="amount", length=16)
	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	@Column(name="course_count", length=8)
	public int getCourseCount() {
		return courseCount;
	}

	public void setCourseCount(int courseCount) {
		this.courseCount = courseCount;
	}

	@Column(name="description", length=128)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name="operator_id", length=64)
	public String getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(String operatorId) {
		this.operatorId = operatorId;
	}

	@Column(name="operator_full_name", length=64)
	public String getOperatorFullName() {
		return operatorFullName;
	}

	public void setOperatorFullName(String operatorFullName) {
		this.operatorFullName = operatorFullName;
	}

	@Column(name="create_time", length=32)
	@Override
	public Date getCreateTime() {
		return createTime;
	}

	@Override
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
