package cn.com.smart.web.bean.search;

import cn.com.smart.filter.bean.FilterParam;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.StringUtils;

@Getter
@Setter
public class StudentCourseRelSearch extends FilterParam {

    private String studentName;

    private String courseId;

    private String courseRecordId;

    private String teacherId;

    private String weekInfo;

    private String status;

    @Override
    public String getParamToString() {
        StringBuilder strBuilder = new StringBuilder();
        String param = super.getParamToString();
        if(StringUtils.isNotBlank(param)) {
            strBuilder.append(param);
        }
        if(null != studentName) {
            strBuilder.append("&studentName=").append(studentName);
        }
        if(StringUtils.isNotBlank(courseId)) {
            strBuilder.append("&courseId="+courseId);
        }
        if(StringUtils.isNotBlank(teacherId)) {
            strBuilder.append("&teacherId="+teacherId);
        }
        if(StringUtils.isNotBlank(weekInfo)) {
            strBuilder.append("&weekInfo=" + weekInfo);
        }
        if(StringUtils.isNotBlank(courseRecordId)) {
            strBuilder.append("&courseRecordId=" + courseRecordId);
        }
        if(StringUtils.isNotBlank(status)) {
            strBuilder.append("&status=" + status);
        }
        param = strBuilder.toString();
        if(StringUtils.isNotBlank(param) && param.startsWith("&")) {
            param = param.substring(1);
        }
        return param;
    }

}
