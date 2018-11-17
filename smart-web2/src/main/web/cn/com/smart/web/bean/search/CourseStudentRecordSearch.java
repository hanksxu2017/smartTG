package cn.com.smart.web.bean.search;

import cn.com.smart.filter.bean.FilterParam;
import org.apache.commons.lang3.StringUtils;

public class CourseStudentRecordSearch extends FilterParam {

    private String weekInfo;

    private String studentName;

    private String teacherId;

    private String classId;

    @Override
    public String getParamToString() {
        StringBuilder strBuilder = new StringBuilder();
        String param = super.getParamToString();
        if(StringUtils.isNotBlank(param)) {
            strBuilder.append(param);
        }
        if(StringUtils.isNotBlank(classId)) {
            strBuilder.append("&classId=:"+classId);
        }
        if(StringUtils.isNotBlank(teacherId)) {
            strBuilder.append("&teacherId=:"+teacherId);
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

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
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
}
