package cn.com.smart.web.constant.enums.tg;

import cn.com.smart.constant.IEnum;

public enum StudentStatusEnum implements IEnum {
	NORMAL("正常"),
	DROP_OUT("退学"),
	TEMP_LEAVE("休学"),
	SIGN_UP("报名"),
	;

	private String message;

	StudentStatusEnum(String message) {
		this.message = message;
	}

	@Override
	public String getMessage() {
		return message;
	}

}
