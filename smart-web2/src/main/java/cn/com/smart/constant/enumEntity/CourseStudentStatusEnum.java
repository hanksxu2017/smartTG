package cn.com.smart.constant.enumEntity;

import cn.com.smart.constant.IEnum;

public enum CourseStudentStatusEnum implements IEnum {
	NORMAL("正常"),
	SIGNED("已签到"),
	PERSONAL_LEAVE("事假"),
	PLAY_TRUANT("旷课"),
	OTHER_ABSENT("缺席"),
	CANCEL_AS_EXIT("退班");

	private String message;

	CourseStudentStatusEnum(String message) {
		this.message = message;
	}

	@Override
	public String getMessage() {
		return null;
	}
}
