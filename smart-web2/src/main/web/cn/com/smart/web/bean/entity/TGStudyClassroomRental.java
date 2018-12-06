package cn.com.smart.web.bean.entity;

import cn.com.smart.bean.BaseBeanImpl;
import cn.com.smart.bean.DateBean;
import cn.com.smart.constant.IConstant;
import cn.com.smart.constant.enumEntity.ClassroomRentalStatusEnum;

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
@Table(name="tg_study_classroom_rental")
public class TGStudyClassroomRental extends BaseBeanImpl implements DateBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4257684310254668325L;

	private String id;

	private String name;

	private String classroomId;

	private String classroomName;

	private String tenantName;

	private String tenantPhone;

	private String status = ClassroomRentalStatusEnum.NORMAL.name();

	private int duration;

	private String endDate;

	private Date createTime;

	private String description;

	private short weekInfo;

	private short courseTimeIndex;

	private String courseTime;

	private Date updateTime;

	@Id
	@Column(name="id", length=64)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name="name", length=64)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name="description", length=64)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    @Column(name="week_info", length=16)
    public short getWeekInfo() {
        return weekInfo;
    }

    public void setWeekInfo(short weekInfo) {
        this.weekInfo = weekInfo;
    }

    @Column(name="course_time", length=16)
    public String getCourseTime() {
        return courseTime;
    }

    public void setCourseTime(String courseTime) {
        this.courseTime = courseTime;
    }

    @Column(name="classroom_id", length=64)
    public String getClassroomId() {
        return classroomId;
    }

    public void setClassroomId(String studyClassroomId) {
        this.classroomId = studyClassroomId;
    }

    @Column(name="classroom_name", length=64)
    public String getClassroomName() {
        return classroomName;
    }

    public void setClassroomName(String studyClassroomName) {
        this.classroomName = studyClassroomName;
    }

	@Column(name="course_time_index", length=2)
	public short getCourseTimeIndex() {
		return courseTimeIndex;
	}

	public void setCourseTimeIndex(short courseTimeIndex) {
		this.courseTimeIndex = courseTimeIndex;
	}

	@Column(name="tenant_name", length=64)
	public String getTenantName() {
		return tenantName;
	}

	public void setTenantName(String tenantName) {
		this.tenantName = tenantName;
	}

	@Column(name="tenant_phone", length=16)
	public String getTenantPhone() {
		return tenantPhone;
	}

	public void setTenantPhone(String tenantPhone) {
		this.tenantPhone = tenantPhone;
	}

	@Column(name="duration", length=8)
	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	@Column(name="end_date", length=16)
	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	@Column(name="update_time", length=16)
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
}
