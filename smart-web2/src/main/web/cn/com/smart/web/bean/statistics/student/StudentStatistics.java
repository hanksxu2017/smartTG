package cn.com.smart.web.bean.statistics.student;

import cn.com.smart.web.bean.entity.TGStudyStStudentSignRecord;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * 描述:
 * 学生的概要统计信息
 * TODO 月末生成当前月份的统计报表，写入数据库
 *
 * @outhor xuwenyi
 * @create 2018-12-07 9:21
 */
@Getter
@Setter
public class StudentStatistics implements Comparable<StudentStatistics>{

	// 统计的月份
	private String month;
	//
	private String studentId;
	//
	private String studentName;
	//
	private String studentPhone;
	//
	private String description = "";
	//
	private int courseCount;
	//
	private String[] courseArr = new String[0];
	//
	private StudentRenewRecord studentRenewRecord;
	//
	private StudentCourseSignStatistics studentCourseSignStatistics;


	@Override
	public int compareTo(StudentStatistics o) {
		if(this.courseCount > o.getCourseCount()) {
			return 1;
		} else if(this.courseCount < o.getCourseCount()) {
			return -1;
		}
		return this.studentCourseSignStatistics.compareTo(o.getStudentCourseSignStatistics());
	}
}
