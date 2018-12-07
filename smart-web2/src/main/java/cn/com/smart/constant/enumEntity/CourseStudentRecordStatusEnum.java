package cn.com.smart.constant.enumEntity;

import cn.com.smart.constant.IEnum;

public enum CourseStudentRecordStatusEnum implements IEnum {
	NORMAL("正常"),
	SIGNED("已签到"),
	SIGNED_MAKE_UP("补课签到"),
	PERSONAL_LEAVE("事假"),
	PLAY_TRUANT("缺课"),
	X_MAKE_UP("补课");

	private String message;

	CourseStudentRecordStatusEnum(String message) {
		this.message = message;
	}

	@Override
	public String getMessage() {
		return null;
	}
}
