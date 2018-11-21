package cn.com.smart.constant.enumEntity;

import cn.com.smart.constant.IEnum;

public enum SystemMessageEnum implements IEnum {
	STUDENT_ABSENT_NOTE("学生课时缺席提醒", 20),
	STUDENT_REMAIN_COURSE_NOTE("学生剩余课时不足提醒", 10),
	COURSE_UN_SIGNED_NOTE("课时未签到提醒", 5),
	;

	private String message;

	private int level;

	SystemMessageEnum(String message, int level) {
		this.message = message;
		this.level = level;
	}

	@Override
	public String getMessage() {
		return message;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}
}
