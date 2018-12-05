package cn.com.smart.web.bean.search;

import cn.com.smart.filter.bean.FilterParam;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.StringUtils;

@Getter
@Setter
public class StatisticsTeacherSearch extends FilterParam {

    private String teacherId;

    private String month;

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
	    if(StringUtils.isNotBlank(month)) {
		    strBuilder.append("&month="+month);
	    }
        return param;
    }

}
