package cn.com.smart.web.bean.entity;

import cn.com.smart.bean.BaseBeanImpl;
import cn.com.smart.bean.DateBean;
import cn.com.smart.constant.IConstant;
import cn.com.smart.web.constant.enums.tg.CourseStudentRecordStatusEnum;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 *
 * 学生课时记录
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Entity
@Table(name="tg_study_course_student_record")
public class TGStudyCourseStudentRecord extends BaseBeanImpl implements DateBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4257684310254668325L;

	private String id;

	private String courseRecordId;

	private String courseId;

	private String studentId;

	private String studentName;

    private String status = CourseStudentRecordStatusEnum.NORMAL.name();

	private Date createTime;

	private Date updateTime;

	private String description;

	private String makeUpTargetId;

	private String signType = IConstant.SIGNED_TYPE_NORMAL;

	@Id
	@Column(name="id", length=64)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

    @Column(name="status",length=16, nullable = false)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name="create_time", length=20)
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Column(name="update_time", length=20)
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Column(name="description", length=128)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name="course_record_id", length=64)
    public String getCourseRecordId() {
        return courseRecordId;
    }

    public void setCourseRecordId(String courseRecordId) {
        this.courseRecordId = courseRecordId;
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

    @Column(name="course_id", length=64)
    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

	@Column(name="make_up_target_id", length=64)
	public String getMakeUpTargetId() {
		return makeUpTargetId;
	}

	public void setMakeUpTargetId(String makeUpTargetId) {
		this.makeUpTargetId = makeUpTargetId;
	}

	@Column(name="sign_type", length=16)
	public String getSignType() {
		return signType;
	}

	public void setSignType(String signType) {
		this.signType = signType;
	}
}
