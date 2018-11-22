package cn.com.smart.web.bean.course;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CourseTable {

	/**
	 * 表格头
	 */
	private List<String> th;

	/**
	 * 表行
	 */
	private List<CourseTr> trs;
	
}
