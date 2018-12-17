package cn.com.smart.web.bean.search;

import cn.com.smart.filter.bean.FilterParam;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.StringUtils;

@Getter
@Setter
public class TeacherSearch extends FilterParam {

	private String teacherId;

	@Override
	public String getParamToString() {
		StringBuilder strBuilder = new StringBuilder();
		String param = super.getParamToString();
		if(StringUtils.isNotBlank(param)) {
			strBuilder.append(param);
		}
		if(StringUtils.isNotBlank(teacherId)) {
			strBuilder.append("&teacherId="+teacherId);
		}
		param = strBuilder.toString();
		if(StringUtils.isNotBlank(param) && param.startsWith("&")) {
			param = param.substring(1);
		}
		return param;
	}
}
