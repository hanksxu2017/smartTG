package cn.com.smart.web.bean.entity;

import cn.com.smart.bean.BaseBeanImpl;
import cn.com.smart.bean.DateBean;

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
@Table(name="tg_study_student")
public class TGStudyStudent extends BaseBeanImpl implements DateBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4257684310254668325L;

	private String id;
	
	private String name;

	private short sex;

	private String birthday;

	private String schoolName;

	private int level;

	private String parentPhone;

	private String parentName;

	private short parentType;

	private String status = "NORMAL";

	private int totalCourse;

	private int remainCourse;

	private Date createTime;

	private Date updateTime;

	@Id
	@Column(name="id", length=64)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

    @Column(name="name",length=64)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name="level",length=8)
    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    @Column(name="update_time",length=20)
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
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

    @Column(name="sex", length=1)
    public short getSex() {
        return sex;
    }

    public void setSex(short sex) {
        this.sex = sex;
    }

    @Column(name="birthday", length=16)
    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    @Column(name="school_name", length=128)
    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    @Column(name="parent_phone", length=16)
    public String getParentPhone() {
        return parentPhone;
    }

    public void setParentPhone(String parentPhone) {
        this.parentPhone = parentPhone;
    }

    @Column(name="parent_name", length=64)
    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    @Column(name="parent_type", length=1)
    public short getParentType() {
        return parentType;
    }

    public void setParentType(short parentType) {
        this.parentType = parentType;
    }

    @Column(name="total_course", length=16)
    public int getTotalCourse() {
        return totalCourse;
    }

    public void setTotalCourse(int totalCourse) {
        this.totalCourse = totalCourse;
    }

    @Column(name="remain_course", length=16)
    public int getRemainCourse() {
        return remainCourse;
    }

    public void setRemainCourse(int remainCourse) {
        this.remainCourse = remainCourse;
    }
}
