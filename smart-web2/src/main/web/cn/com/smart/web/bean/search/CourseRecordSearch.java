package cn.com.smart.web.bean.search;

import cn.com.smart.filter.bean.FilterParam;
import org.apache.commons.lang3.StringUtils;

public class CourseRecordSearch extends FilterParam {

    private String weekInfo;

    private String courseStartDate;

    private String courseEndDate;

    private String studentName;

    private String teacherId;

    private String selectCourseDate;

    @Override
    public String getParamToString() {
        StringBuilder strBuilder = new StringBuilder();
        String param = super.getParamToString();
        if(StringUtils.isNotBlank(param)) {
            strBuilder.append(param);
        }
        if(StringUtils.isNotBlank(teacherId)) {
            strBuilder.append("&teacherId=" + teacherId);
        }
	    if(StringUtils.isNotBlank(selectCourseDate)) {
		    strBuilder.append("&selectCourseDate=" + selectCourseDate);
	    }

        param = strBuilder.toString();
        if(StringUtils.isNotBlank(param) && param.startsWith("&")) {
            param = param.substring(1);
        }
        return param;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getWeekInfo() {
        return weekInfo;
    }

    public void setWeekInfo(String weekInfo) {
        this.weekInfo = weekInfo;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getCourseStartDate() {
        return courseStartDate;
    }

    public void setCourseStartDate(String courseStartDate) {
        this.courseStartDate = courseStartDate;
    }

    public String getCourseEndDate() {
        return courseEndDate;
    }

    public void setCourseEndDate(String courseEndDate) {
        this.courseEndDate = courseEndDate;
    }

	public String getSelectCourseDate() {
		return selectCourseDate;
	}

	public void setSelectCourseDate(String selectCourseDate) {
		this.selectCourseDate = selectCourseDate;
	}
}
