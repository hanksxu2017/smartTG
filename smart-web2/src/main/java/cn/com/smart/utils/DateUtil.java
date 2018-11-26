package cn.com.smart.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

/**
 * 日期工具类
 * @author XUWENYI
 * @version 1.0
 * @since JDK1.6
 * 2015年8月22日
 */
public class DateUtil extends BaseUtil {

	/**
	 * 时间转为日期格式 <br />
	 * 如：formatter参数为空时，默认格式为“yyyy-MM-dd HH:mm:ss”
	 * @param date
	 * @param formatter 
	 * @return 日期转换后的字符串 
	 */
	public static String dateToStr(Date date,String formatter) {
		String value = null;
		if(null != date) {
			if(StringUtils.isEmpty(formatter)) {
				formatter = "yyyy-MM-dd HH:mm:ss";
			}
			SimpleDateFormat dateFormat = new SimpleDateFormat(formatter);
			value = dateFormat.format(date);
			dateFormat = null;
		}
		return value;
	}

    /**
     *
     * @param dateStr
     * @param format
     * @return
     */
    public static Date parseDate(String dateStr, String format) {
	    try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(format);
            return dateFormat.parse(dateStr);
        } catch (Exception e) {
	        return null;
        }
    }

    /**
     * 获取日期所处的星期</br>
     * 星期1-星期6: 1-6, 星期天: 0
     * @param date
     * @return
     */
    public static int getWeek(Date date) {
        if(null == date) {
            return -1;
        }
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        return w;
    }

    public static Date addDay(Date srcDate, int offset) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(srcDate);
        calendar.add(Calendar.DAY_OF_MONTH,offset);
        return calendar.getTime();
    }

    public static Date addMinute(Date srcDate, int offset) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(srcDate);
        calendar.add(Calendar.MINUTE,offset);
        return calendar.getTime();
    }


	private static Date getThisWeekMonday(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		// 获得当前日期是一个星期的第几天
		int dayWeek = cal.get(Calendar.DAY_OF_WEEK);
		if (Calendar.SUNDAY == dayWeek) {
			// 指定时间为星期天,日期向前移动1天
			cal.add(Calendar.DAY_OF_MONTH, -1);
		}
		// 设置一个星期的第一天，按中国的习惯一个星期的第一天是星期一
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		// 获得当前日期是一个星期的第几天
		int day = cal.get(Calendar.DAY_OF_WEEK);
		// 根据日历的规则，给当前日期减去星期几与一个星期第一天的差值
		cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);
		return cal.getTime();
	}

	public static Date getNextMonday(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(getThisWeekMonday(date));
		cal.add(Calendar.DATE, 7);
		return cal.getTime();
	}

	public static Date getNextSunday(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(getThisWeekMonday(date));
		cal.add(Calendar.DATE, 13);
		return cal.getTime();
	}
}
