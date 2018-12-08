package cn.com.smart.web.utils;

import cn.com.smart.utils.DateUtil;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DataUtil {

    public static String handleNull(Object obj) {
        return obj == null ? "" : obj.toString().trim();
    }

    public static boolean isDecimal(String value) {
        boolean is = false;
        Pattern pattern = Pattern.compile("\\d+\\.\\d+");
        Matcher matcher = pattern.matcher(value);
        if (matcher.matches()) {
            is = true;
        } else {
            is = false;
        }

        return is;
    }

	public static boolean isNum(String value) {
		boolean is = false;
		Pattern pattern = Pattern.compile("\\d+|\\d+\\.\\d+");
		Matcher matcher = pattern.matcher(value);
		if (matcher.matches()) {
			is = true;
		} else {
			is = false;
		}

		return is;
	}

	public static boolean isInteger(String value) {
		boolean is = false;
		Pattern pattern = Pattern.compile("\\d+");
		if (value != null && value.length() > 1) {
			pattern = Pattern.compile("^[1-9]\\d+");
		}

		Matcher matcher = pattern.matcher(value);
		if (matcher.matches()) {
			is = true;
		} else {
			is = false;
		}

		return is;
	}

	public static boolean isPhoneNO(String phoneNo) {
		Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
		Matcher m = p.matcher(phoneNo);
		return m.matches();
	}

	public static boolean isChinese(String value) {
		Pattern p = Pattern.compile("^[\\u4E00-\\u9FFF]+$");
		Matcher m = p.matcher(value);
		boolean is = m.matches();
		return is;
	}

	public static boolean isEmail(String email) {
		Pattern p = Pattern.compile("^([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+\\.[a-zA-Z]{2,3}$");
		Matcher m = p.matcher(email);
		return m.matches();
	}

    public static String[] list2Array(Collection<String> values) {
        String[] valueArray = null;
        if (values != null && values.size() > 0) {
            valueArray = new String[values.size()];
            values.toArray(valueArray);
        }

        return valueArray;
    }

	public static boolean isArrayContains(String str,String subStr,String separater) {
		boolean is = false;
		if(null != str) {
			if(null == subStr) {
				is = true;
			} else {
				String[] strArray = str.split(separater);
				for (int i = 0; i < strArray.length; i++) {
					if(subStr.equals(strArray[i].trim())) {
						is = true;
						break;
					}
				}
			}
		}
		return is;
	}

	public static String[] stringToArray(String value,String separator) {
		String[] array = null;
		if(StringUtils.isNotBlank(value) && StringUtils.isNotBlank(separator)) {
			array = value.split(separator);
		}
		value = null;
		return array;
	}

	public static String arrayToString(Object[] objs,String separator) {
		StringBuffer strBuff = null;
		if(null != objs && objs.length>0) {
			if(StringUtils.isBlank(separator)) {
				separator = "";
			}
			strBuff = new StringBuffer();
			for (int i=0;i<objs.length;i++) {
				if(i < objs.length-1 ) {
					strBuff.append(String.valueOf(objs[i])+separator);
				} else {
					strBuff.append(String.valueOf(objs[i]));
				}

			}
		}
		objs = null;
		return (null != strBuff)?strBuff.toString():null;
	}


	public static String getFileSuffix(String fileName) {
		return fileName.substring(fileName.lastIndexOf(".") + 1);
	}

	public static String trimFileSuffix(String fileName) {
		return fileName.substring(0, fileName.lastIndexOf("."));
	}


	public static String desEncode(String value, String key) {
		if (StringUtils.isNotEmpty(value) && StringUtils.isNotEmpty(key)) {
			try {
				byte[] bytes = value.getBytes("UTF-8");
				bytes = DESCoder.encrypt(bytes, key);
				value = Base64.encodeBase64URLSafeString(bytes);
			} catch (UnsupportedEncodingException var3) {
				var3.printStackTrace();
			} catch (Exception var4) {
				var4.printStackTrace();
			}
		}

		return value;
	}

	public static String desDecode(String value, String key) {
		try {
			byte[] bytes = Base64.decodeBase64(value);
			bytes = DESCoder.decrypt(bytes, key);
			value = new String(bytes, "UTF8");
		} catch (UnsupportedEncodingException var3) {
			value = null;
			var3.printStackTrace();
		} catch (Exception var4) {
			value = null;
			var4.printStackTrace();
		}

		return value;
	}

	public static String filterFilePath(String value) {
		if (StringUtils.isNotBlank(value)) {
			value.replaceAll("\\.|/|\\\\\\\\|\\\\|:|%2F|%2E|25%|20%|%5C|60%|27%|%3A|%2A", "");
		}

		return value;
	}

	public static String handleNumNull(Object obj) {
		return obj == null ? "0" : obj.toString().trim();
	}

	public static boolean isContains(String value, String contain) {
		boolean is = false;
		if (StringUtils.isNotBlank(value) && contain != null) {
			is = value.indexOf(contain) > -1;
		}

		return is;
	}


	public static Integer handleObj2Integer(Object obj) {
		if (obj == null) {
			return 0;
		} else {
			Integer value = 0;

			try {
				value = Integer.parseInt(obj.toString());
			} catch (Exception var3) {
				value = 0;
			}

			return value;
		}
	}

	public static String numToCN(int num) {
    	String[] cnArr = new String[]{"", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"};
    	if(num >= 1 && num <= 10) {
			return cnArr[num];
	    }
	    return "";
	}

	public static String getRate(int count, int total) {
		DecimalFormat df = new DecimalFormat("0.00");//格式化小数
		return df.format((float)(count * 100) /total);//返回的是String类型
	}

	public static List<Map<String, String>> getMonthList() {
    	return getMonthList(false);
	}

	public static List<Map<String, String>> getMonthList(boolean isIncludeCurMonth) {
		List<Map<String, String>> monthList = new ArrayList<>();
		Date date;
		if(isIncludeCurMonth) {
			date = new Date();
			Map<String, String> item = new HashMap<>();
			item.put("month", DateUtil.dateToStr(date, "yyyyMM"));
			item.put("monthDesc", DateUtil.dateToStr(date, "yyyy年MM月"));
			monthList.add(item);
		}

		for(int index = 1; index <= 6; index++) {
			date = DateUtil.addMonth(new Date(), (-1 * index));
			Map<String, String> item = new HashMap<>();
			item.put("month", DateUtil.dateToStr(date, "yyyyMM"));
			item.put("monthDesc", DateUtil.dateToStr(date, "yyyy年MM月"));
			monthList.add(item);
		}
		return monthList;
	}
}
