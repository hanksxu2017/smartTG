package cn.com.smart.web.bean.statistics.student;

import cn.com.smart.constant.enumEntity.CourseStudentRecordStatusEnum;
import lombok.Getter;
import lombok.Setter;

/**
 * 描述:
 * 学生课时的签到记录
 *
 * @outhor xuwenyi
 * @create 2018-12-07 9:33
 */
@Getter
@Setter
public class StudentCourseSignRecord implements Comparable<StudentCourseSignRecord>{
	//
	private String studentId;
	//
	private String month;
	// 课时日期,格式:dd
	private int courseDate;
	// 签到类型
	private CourseStudentRecordStatusEnum  signStatus;
	//
	private String courseRecordId;

	@Override
	public int compareTo(StudentCourseSignRecord o) {
		if(this.courseDate > o.getCourseDate()) {
			return 1;
		} else if(this.courseDate < o.getCourseDate()) {
			return -1;
		}
		return 0;
	}
}
