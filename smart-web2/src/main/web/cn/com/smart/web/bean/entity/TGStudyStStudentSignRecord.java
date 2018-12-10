package cn.com.smart.web.bean.entity;

import cn.com.smart.bean.BaseBeanImpl;
import cn.com.smart.bean.DateBean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 * 描述:
 * 学生课时的签到记录
 *
 * @outhor xuwenyi
 * @create 2018-12-07 9:33
 */
@Entity
@Table(name="tg_study_statistics_student_course_sign")
public class TGStudyStStudentSignRecord extends BaseBeanImpl implements DateBean,Comparable<TGStudyStStudentSignRecord> {

	private String id;
	//
	private String statisticsId;
	// 课时日期,格式:dd
	private int courseDate;
	// 签到状态
	private String signStatus;
	//
	private String signType;
	//
	private String courseRecordId;
	//
	private Date createTime;

	@Id
	@Column(name="id", length=64)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name="statistics_id", length=64)
	public String getStatisticsId() {
		return statisticsId;
	}

	public void setStatisticsId(String statisticsId) {
		this.statisticsId = statisticsId;
	}

	@Column(name="course_date", length=2)
	public int getCourseDate() {
		return courseDate;
	}

	public void setCourseDate(int courseDate) {
		this.courseDate = courseDate;
	}

	@Column(name="sign_status", length=32)
	public String getSignStatus() {
		return signStatus;
	}

	public void setSignStatus(String signStatus) {
		this.signStatus = signStatus;
	}

	@Column(name="sign_type", length=32)
	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
	}

	@Column(name="course_record_id", length=64)
	public String getCourseRecordId() {
		return courseRecordId;
	}

	public void setCourseRecordId(String courseRecordId) {
		this.courseRecordId = courseRecordId;
	}

	@Column(name="create_time", length=64)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Override
	public int compareTo(TGStudyStStudentSignRecord o) {
		if(this.courseDate > o.getCourseDate()) {
			return 1;
		} else if(this.courseDate < o.getCourseDate()) {
			return -1;
		}
		return 0;
	}
}
