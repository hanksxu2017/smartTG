package cn.com.smart.web.bean.statistics.student;

import cn.com.smart.web.bean.entity.TGStudyStStudentSignRecord;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * 描述:
 * 学生课时的签到统计
 *
 * @outhor xuwenyi
 * @create 2018-12-07 9:30
 */
@Getter
@Setter
public class StudentCourseSignStatistics implements Comparable<StudentCourseSignStatistics>{
	//
	private String studentId;
	//
	private String month;
	//
	private int totalCount;
	//
	private int signedCount;
	//
	private int personalLeaveCount;
	//
	private int playTruantCount;
	//
	private int makeUpCount;
	//
	private int othersCount;
	//
	List<StudentCourseSignRecord> studentCourseSignRecordList = new ArrayList<>();
	// 前一个月的签到信息
	private int previousSignCount;
	private List<TGStudyStStudentSignRecord> stStudentSignRecordList = new ArrayList<>();

	@Override
	public int compareTo(StudentCourseSignStatistics o) {
		if(this.totalCount > o.getTotalCount()) {
			return 1;
		} else if(this.totalCount < o.getTotalCount()) {
			return -1;
		}
		return 0;
	}
}
