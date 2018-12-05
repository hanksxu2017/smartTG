package cn.com.smart.web.bean.entity;

import cn.com.smart.bean.BaseBeanImpl;
import cn.com.smart.bean.DateBean;
import cn.com.smart.constant.IConstant;
import cn.com.smart.utils.DateUtil;
import org.apache.commons.lang.StringUtils;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

/**
 *
 *
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Entity
@Table(name="tg_study_course_record")
public class TGStudyCourseRecord extends BaseBeanImpl implements DateBean, Comparable<TGStudyCourseRecord> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4257684310254668325L;

	private String id;

    private String courseId;

    private String courseName;

    // 日期,格式: yyyy-MM-dd
    private String courseDate;
    // 课时时间,格式:HH:mm-HH:mm
    private String courseTime;

	private String classroomId;

	private String classroomName;

	private String teacherId;

	private String teacherName;
    // 应到
	private int studentQuantityPlan;
    // 实到
    private int studentQuantityActual;
    // 事假
    private int studentPersonalLeave;
    // 缺课
    private int studentPlayTruant;

    private String status = IConstant.STATUS_NORMAL;

	private Date createTime;

	private Date updateTime;

	private String description;

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

    @Column(name="course_name", length=64)
    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    @Column(name="course_id", length=64)
    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    @Column(name="classroom_id", length=64)
    public String getClassroomId() {
        return classroomId;
    }

    public void setClassroomId(String classroomId) {
        this.classroomId = classroomId;
    }

    @Column(name="classroom_name", length=64)
    public String getClassroomName() {
        return classroomName;
    }

    public void setClassroomName(String classroomName) {
        this.classroomName = classroomName;
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

    @Column(name="course_date", length=32)
    public String getCourseDate() {
        return courseDate;
    }

    public void setCourseDate(String courseDate) {
        this.courseDate = courseDate;
    }

    @Column(name="course_time", length=32)
    public String getCourseTime() {
        return courseTime;
    }

    public void setCourseTime(String courseTime) {
        this.courseTime = courseTime;
    }

    @Column(name="student_quantity_plan", length=11)
    public int getStudentQuantityPlan() {
        return studentQuantityPlan;
    }

    public void setStudentQuantityPlan(int studentQuantityPlan) {
        this.studentQuantityPlan = studentQuantityPlan;
    }

    @Column(name="student_quantity_actual", length=11)
    public int getStudentQuantityActual() {
        return studentQuantityActual;
    }

    public void setStudentQuantityActual(int studentQuantityActual) {
        this.studentQuantityActual = studentQuantityActual;
    }

    @Column(name="student_personal_leave", length=11)
    public int getStudentPersonalLeave() {
        return studentPersonalLeave;
    }

    public void setStudentPersonalLeave(int studentPersonalLeave) {
        this.studentPersonalLeave = studentPersonalLeave;
    }

    @Column(name="student_play_truant", length=11)
    public int getStudentPlayTruant() {
        return studentPlayTruant;
    }

    public void setStudentPlayTruant(int studentPlayTruant) {
        this.studentPlayTruant = studentPlayTruant;
    }

    @Column(name="description", length=128)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public int compareTo(TGStudyCourseRecord o) {
        String courseEndTime = this.getCourseTime().substring(this.getCourseTime().indexOf('-') + 1);
        Date curDate = DateUtil.parseDate(this.getCourseDate() + " " + courseEndTime, "yyyy-MM-dd HH:mm");

        String oCourseEndTime = o.getCourseTime().substring(o.getCourseTime().indexOf('-') + 1);
        Date oDate = DateUtil.parseDate(o.getCourseDate() + " " + oCourseEndTime, "yyyy-MM-dd HH:mm");

        if(null != curDate && null != oDate) {
            if(curDate.before(oDate)) {
                return -1;
            }else if(curDate.after(oDate)) {
                return 1;
            }
        }
        return 0;
    }

	public boolean canSign() {
		if(StringUtils.isBlank(this.getCourseDate()) || StringUtils.isBlank(this.getCourseTime())) {
			return false;
		}
		Date courseDate = DateUtil.parseDate(this.getCourseDate() + " " + this.getCourseTime(),
						"yyyy-MM-dd HH:mm");
/*		// 已结课的课程补课签到
		if (StringUtils.equals(IConstant.STATUS_NORMAL, this.getStatus()) && null != courseDate) {
			return courseDate.before(new Date());
		}*/
        return courseDate.before(new Date());
	}
}
