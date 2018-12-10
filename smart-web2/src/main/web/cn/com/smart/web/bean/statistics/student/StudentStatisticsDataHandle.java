package cn.com.smart.web.bean.statistics.student;

import cn.com.smart.web.bean.entity.TGStudyStStudentSignRecord;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * 描述:
 * 学生统计数据对象
 *
 * @outhor xuwenyi
 * @create 2018-12-07 14:41
 */
@Getter
@Setter
public class StudentStatisticsDataHandle {

	private String monthInTable;
	// 最大班级数
	int maxCourseCount;
	// 最大月时数
	int maxCourseDay;
	//
	private List<StudentStatistics> studentStatisticsList = new ArrayList<>();

	private String previousMonthInTable = "";
	private int previousMaxCourseDay = 0;
}
