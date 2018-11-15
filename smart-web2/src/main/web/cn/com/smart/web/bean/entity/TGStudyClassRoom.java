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
@Table(name="tg_study_classroom")
public class TGStudyClassRoom extends BaseBeanImpl implements DateBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4257684310254668325L;

	private String id;

	private String studySchoolId;

    private String studySchoolName;

	private String name;
	
	private String description;

	private String status = "NORMAL";

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

    @Column(name="study_school_id", length=64, nullable = false)
    public String getStudySchoolId() {
        return studySchoolId;
    }

    public void setStudySchoolId(String studySchoolId) {
        this.studySchoolId = studySchoolId;
    }

    @Column(name="study_school_name", length=64)
    public String getStudySchoolName() {
        return studySchoolName;
    }

    public void setStudySchoolName(String studySchoolName) {
        this.studySchoolName = studySchoolName;
    }

    @Column(name="description", length=64)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name="name",length=128)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
}
