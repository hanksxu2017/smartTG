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
@Table(name="tg_study_course")
public class TGStudyCourse extends BaseBeanImpl implements DateBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4257684310254668325L;

	private String id;

	private String weekInfo;

	private String courseTime;

	private String classId;

	private String className;

	private String classroomId;

	private String classroomName;

	private String teacherId;

	private String teacherName;

	private String status = "NORMAL";

	private String description;

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

    @Column(name="update_time", length=20)
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Column(name="week_info", length=16)
    public String getWeekInfo() {
        return weekInfo;
    }

    public void setWeekInfo(String weekInfo) {
        this.weekInfo = weekInfo;
    }

    @Column(name="course_time", length=16)
    public String getCourseTime() {
        return courseTime;
    }

    public void setCourseTime(String courseTime) {
        this.courseTime = courseTime;
    }

    @Column(name="class_id", length=64)
    public String getClassId() {
        return classId;
    }

    public void setClassId(String studyClassId) {
        this.classId = studyClassId;
    }

    @Column(name="class_name", length=64)
    public String getClassName() {
        return className;
    }

    public void setClassName(String studyClassName) {
        this.className = studyClassName;
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

    @Column(name="teacher_id", length=64)
    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String studyTeacherId) {
        this.teacherId = studyTeacherId;
    }

    @Column(name="teacher_name", length=64)
    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String studyTeacherName) {
        this.teacherName = studyTeacherName;
    }
}
