package cn.com.smart.constant.enumEntity;

import cn.com.smart.constant.IEnum;

public enum StudentCourseSignTypeEnum implements IEnum {
	NORMAL("正常签到"),
	SIGN_AS_HAS("到班签到");

	private String message;

	StudentCourseSignTypeEnum(String message) {
		this.message = message;
	}

	@Override
	public String getMessage() {
		return null;
	}
}
