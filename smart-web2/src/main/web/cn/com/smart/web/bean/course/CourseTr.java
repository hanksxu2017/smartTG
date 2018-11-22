package cn.com.smart.web.bean.course;

import lombok.Getter;
import lombok.Setter;

import java.util.Map;

@Getter
@Setter
public class CourseTr {

	private int weekInfo;

	private String courseTime;

	/**
	 * key: classroomId_weekInfo_courseTimeIndex
	 */
	private Map<String, CourseTd> courseTdMap;

}
