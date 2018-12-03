package cn.com.smart.web.bean.search;

import cn.com.smart.utils.DateUtil;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class CourseDateSelector implements Comparable<CourseDateSelector>{

	// 格式 yyyy-MM-dd
	private String courseDate;

	private String description;

	public CourseDateSelector(String courseDate, String description) {
		this.courseDate = courseDate;
		this.description = description;
	}

	@Override
	public int compareTo(CourseDateSelector o) {
		String format = "yyyy-MM-dd";
		Date cDate = DateUtil.parseDate(this.courseDate, format);
		Date oDate = DateUtil.parseDate(o.getCourseDate(), format);
		if(cDate.before(oDate)) {
			return -1;
		} else if(cDate.after(oDate)) {
			return 1;
		}
		return 0;
	}
}
