package cn.com.smart.web.bean.course;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CourseTimeTables {
	// 星期
	private List<String> weeks;
	// 时间
	private List<String> courseTimes;
	// 教室
	private List<String> classrooms;


	
}
