package cn.com.smart.web.bean.entity;

import cn.com.smart.bean.BaseBeanImpl;
import cn.com.smart.bean.DateBean;
import cn.com.smart.constant.IConstant;
import com.mixsmart.utils.StringUtils;

import javax.persistence.*;
import java.util.Date;

/**
 *
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Entity
@Table(name="tg_study_school")
public class TGStudySchool extends BaseBeanImpl implements DateBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4257684310254668325L;

	private String id;
	
	/**
	 * 版本
	 */
	private String name;
	
	private String address;

	private String status = IConstant.STATUS_NORMAL;
	/**
	 * 添加时间 
	 */
	private Date createTime;

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

    @Column(name="address",length=128)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

}
