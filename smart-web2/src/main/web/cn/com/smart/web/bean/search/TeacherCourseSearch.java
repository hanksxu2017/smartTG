package cn.com.smart.web.bean.search;

import cn.com.smart.filter.bean.FilterParam;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.StringUtils;

@Getter
@Setter
public class TeacherCourseSearch extends FilterParam {

	private String courseName;

	private String weekInfo;

	@Override
	public String getParamToString() {
		StringBuilder strBuilder = new StringBuilder();
		String param = super.getParamToString();
		if(StringUtils.isNotBlank(param)) {
			strBuilder.append(param);
		}
		if(StringUtils.isNotBlank(courseName)) {
			strBuilder.append("&courseName="+courseName);
		}
		if(StringUtils.isNotBlank(weekInfo)) {
			strBuilder.append("&weekInfo="+weekInfo);
		}
		param = strBuilder.toString();
		if(StringUtils.isNotBlank(param) && param.startsWith("&")) {
			param = param.substring(1);
		}
		return param;
	}
}
