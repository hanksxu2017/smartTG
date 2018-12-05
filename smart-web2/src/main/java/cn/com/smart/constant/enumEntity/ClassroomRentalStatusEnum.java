package cn.com.smart.constant.enumEntity;

import cn.com.smart.constant.IEnum;

public enum ClassroomRentalStatusEnum implements IEnum {
	NORMAL("正常"),
	CANCEL("取消"),
	EXPIRE("到期");

	private String message;

	ClassroomRentalStatusEnum(String message) {
		this.message = message;
	}

	@Override
	public String getMessage() {
		return null;
	}
}
