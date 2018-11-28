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
@Table(name="tg_study_classroom")
public class TGStudyClassroom extends BaseBeanImpl implements DateBean, Comparable<TGStudyClassroom> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4257684310254668325L;

	private String id;

	private String schoolId;

    private String schoolName;

	private String name;
	
	private String description;

	private String status = IConstant.STATUS_NORMAL;

	private Date createTime;

	private Date updateTime;

	private int sortOrder;

	@Id
	@Column(name="id", length=64)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

    @Column(name="school_id", length=64, nullable = false)
    public String getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(String studySchoolId) {
        this.schoolId = studySchoolId;
    }

    @Column(name="school_name", length=64)
    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
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

	@Column(name="sort_order", length=4)
	public int getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}

	@Override
	public int compareTo(TGStudyClassroom o) {
		if(this.sortOrder > o.getSortOrder()) {
			return 1;
		} else if(this.sortOrder < o.getSortOrder()) {
			return -1;
		}
		return 0;
	}
}
