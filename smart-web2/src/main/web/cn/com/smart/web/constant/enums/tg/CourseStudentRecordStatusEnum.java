package cn.com.smart.web.constant.enums.tg;

import cn.com.smart.constant.IEnum;

public enum CourseStudentRecordStatusEnum implements IEnum {
	NORMAL("正常"),
	SIGNED("已签到"),
	PERSONAL_LEAVE("事假"),
	PLAY_TRUANT("缺课"),
	X_MAKE_UP("补课"),
	Y_PRE_MAKE_UP("预补课");

	private String message;

	CourseStudentRecordStatusEnum(String message) {
		this.message = message;
	}

	@Override
	public String getMessage() {
		return null;
	}
}
