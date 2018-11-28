package cn.com.smart.web.bean.course;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CourseTimeEntity implements Comparable<CourseTimeEntity>{

	private int courseTimeIndex;

	private String courseTime;

    private String first = "YES";

	public CourseTimeEntity() {}

	public CourseTimeEntity(int courseTimeIndex, String courseTime) {
		this.courseTimeIndex = courseTimeIndex;
		this.courseTime = courseTime;
	}

	@Override
	public int compareTo(CourseTimeEntity o) {
		if(this.courseTimeIndex > o.getCourseTimeIndex()) {
			return 1;
		} else if(this.courseTimeIndex < o.getCourseTimeIndex()) {
			return -1;
		}
		return 0;
	}
}
