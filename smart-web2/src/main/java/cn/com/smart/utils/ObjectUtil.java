package cn.com.smart.utils;

import cn.com.smart.web.utils.DataUtil;
import org.apache.commons.lang3.StringUtils;

/**
 * 简单对象工具类
 * @author XUWENYI
 * @version 1.0
 * @since 1.0
 * 2015年8月22日
 */
public class ObjectUtil {

	/**
	 * 根据内容进行数据类型转换
	 * <p>如:字符串“5”转换之后变成整型5</p>
	 * @param value
	 * @return 转换后的值
	 */
	public static Object covertDataType(Object value) {
		Object obj = null;
		String valueStr = value.toString();
		if(StringUtils.isNotEmpty(valueStr)) {
			if(DataUtil.isInteger(valueStr)) {
				obj = Integer.parseInt(valueStr);
			} else if(DataUtil.isDecimal(valueStr)) {
				obj = Double.parseDouble(valueStr);
			} else {
				obj = value;
			}
		} else {
			obj = value;
		}
		return obj;
	}
	
	/**
	 * boolean型转化为整型 <br />
	 * 转换依据是:true--1;false--0
	 * @param value
	 * @return 返回1或0
	 */
	public static int boolean2Int(boolean value) {
		return value?1:0;
	}
	
	
	/**
	 * boolean型转化为String <br />
	 * 转换依据是:true--"1";false--"0"
	 * @param value
	 * @return 返回“1”或“0”
	 */
	public static String boolean2String(boolean value) {
		return value?"1":"0";
	}
	
	
	/**
	 * int型转化为boolean <br />
	 * 转换依据是:1--true;非1--false
	 * @param value
	 * @return 返回true或false
	 */
	public static boolean int2Boolean(int value) {
		return value == 1;
	}
	
	
	/**
	 * Strng型转化为boolean <br />
	 * 转换依据是:"1"--true；非"1"--false
	 * @param value
	 * @return 返回true或false
	 */
	public static boolean string2Boolean(String value) {
		return "1".equals(value);
	}
	
}
