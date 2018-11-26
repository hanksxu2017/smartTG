package cn.com.smart.web.plugins.bean;

/**
 * ZTreeCheck节点
 * @author XUWENYI <br />
 * 2017年1月5日
 * @version 1.0
 * @since 1.0
 */
public class ZTreeNodeCheck extends ZTreeNode {

	
	private Boolean checked = false;
	
	private Boolean nocheck = false;
	
	private Boolean chkDisabled = false;
	
	private Boolean doCheck = true;
	
	private Boolean halfCheck = false;

	public Boolean getChecked() {
		return checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

	public Boolean getNocheck() {
		return nocheck;
	}

	public void setNocheck(Boolean nocheck) {
		this.nocheck = nocheck;
	}

	public Boolean getChkDisabled() {
		return chkDisabled;
	}

	public void setChkDisabled(Boolean chkDisabled) {
		this.chkDisabled = chkDisabled;
	}

	public Boolean getDoCheck() {
		return doCheck;
	}

	public void setDoCheck(Boolean doCheck) {
		this.doCheck = doCheck;
	}

	public Boolean getHalfCheck() {
		return halfCheck;
	}

	public void setHalfCheck(Boolean halfCheck) {
		this.halfCheck = halfCheck;
	}
	
	
}
