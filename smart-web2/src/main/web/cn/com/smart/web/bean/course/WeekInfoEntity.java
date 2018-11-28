package cn.com.smart.web.bean.course;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WeekInfoEntity {

	private int weekInfo;

	private String weekInfoStr;

	public WeekInfoEntity(){}

	public WeekInfoEntity(int weekInfo, String weekInfoStr) {
		this.weekInfo = weekInfo;
		this.weekInfoStr = weekInfoStr;
	}
}
