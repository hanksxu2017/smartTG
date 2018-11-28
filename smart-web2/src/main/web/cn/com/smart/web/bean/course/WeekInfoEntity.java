package cn.com.smart.web.bean.course;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WeekInfoEntity {

	private int weekInfo;

	private String weekInfoStr;

	// 当前星期的课时数量
	private int courseCount;

	public WeekInfoEntity(){}

	public WeekInfoEntity(int weekInfo, String weekInfoStr, int courseCount) {
		this.weekInfo = weekInfo;
		this.weekInfoStr = weekInfoStr;
		this.courseCount = courseCount;
	}
}
