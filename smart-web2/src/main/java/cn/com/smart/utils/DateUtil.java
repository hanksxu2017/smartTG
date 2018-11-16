package cn.com.smart.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.mixsmart.utils.StringUtils;

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

}
