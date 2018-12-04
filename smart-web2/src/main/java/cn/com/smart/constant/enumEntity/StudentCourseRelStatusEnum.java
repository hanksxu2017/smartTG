package cn.com.smart.constant.enumEntity;

import cn.com.smart.constant.IEnum;

public enum StudentCourseRelStatusEnum implements IEnum {
	NORMAL("正常"),
	EXIT_COURSE("退班");

	private String message;

	StudentCourseRelStatusEnum(String message) {
		this.message = message;
	}

	@Override
	public String getMessage() {
		return null;
	}
}
