package cn.com.smart.constant.enumEntity;

import cn.com.smart.constant.IEnum;

public enum CourseRecordStatusEnum implements IEnum {
	NORMAL("正常"),
	NORMAL_END("已结课"),
	DELETE("解散");

	private String message;

	CourseRecordStatusEnum(String message) {
		this.message = message;
	}

	@Override
	public String getMessage() {
		return null;
	}
}
