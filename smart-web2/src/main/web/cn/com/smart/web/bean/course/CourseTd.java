package cn.com.smart.web.bean.course;

import cn.com.smart.web.bean.entity.TGStudyCourse;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CourseTd implements Comparable<CourseTd>{

	private String classroomId;

	private int classroomSortOrder;

	private int weekInfo;

	private int courseTimeIndex;

	private TGStudyCourse course;

	@Override
	public int compareTo(CourseTd o) {
		// 使用教室进行第一轮排序
		if(this.classroomSortOrder > o.getClassroomSortOrder()) {
			return 1;
		} else if(this.classroomSortOrder < o.getClassroomSortOrder()) {
			return -1;
		}
		return 0;
	}
}
