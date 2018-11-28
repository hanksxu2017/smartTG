package cn.com.smart.web.bean.course;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * 使用星期+时间编号定位一条行记录
 */
@Getter
@Setter
public class CourseTr implements Comparable<CourseTr>{

	// 星期
	private WeekInfoEntity weekInfoEntity;

	// 时间
	private CourseTimeEntity courseTimeEntity;

	// 课程
	List<CourseTd> tds = new ArrayList<>();

	@Override
	public int compareTo(CourseTr o) {
		if(this.weekInfoEntity.getWeekInfo() > o.getWeekInfoEntity().getWeekInfo()) {
			return 1;
		} else if(this.weekInfoEntity.getWeekInfo() < o.getWeekInfoEntity().getWeekInfo()) {
			return -1;
		}

		if(this.courseTimeEntity.getCourseTimeIndex() > o.getCourseTimeEntity().getCourseTimeIndex()) {
			return 1;
		} else if(this.courseTimeEntity.getCourseTimeIndex() < o.getCourseTimeEntity().getCourseTimeIndex()) {
			return -1;
		}

		return 0;
	}
}
