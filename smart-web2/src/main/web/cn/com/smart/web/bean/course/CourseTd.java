package cn.com.smart.web.bean.course;

import cn.com.smart.web.bean.entity.TGStudyCourse;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CourseTd {

	private String classroomId;

	private int weekInfo;

	private int courseTimeIndex;

	private TGStudyCourse course;
}
