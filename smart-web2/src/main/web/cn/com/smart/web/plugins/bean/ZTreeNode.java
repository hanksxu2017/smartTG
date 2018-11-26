package cn.com.smart.web.plugins.bean;

import cn.com.smart.web.utils.DataUtil;
import org.apache.commons.lang3.StringUtils;

/**
 * ZTree基础属性
 * @author XUWENYI <br />
 * 2017年1月5日
 * @version 1.0
 * @since 1.0
 */
public class ZTreeNode {

	protected String id;
	
	protected String pId;
	
	protected String name;
	
	protected Boolean open = true;
	
	protected Boolean isParent = false;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getOpen() {
		return open;
	}

	public void setOpen(Object open) {
		String openStr = DataUtil.handleNull(open);
		if(StringUtils.isNotEmpty(openStr)) {
			this.open = StringUtils.equals("1", openStr);
		}
	}

	public Boolean getIsParent() {
		return isParent;
	}

	public void setIsParent(Object isParent) {
		String isParentStr = DataUtil.handleNull(isParent);
		if(StringUtils.isNotEmpty(isParentStr)) {
			this.open = StringUtils.equals("1", isParentStr);
		}
	}
	
}
