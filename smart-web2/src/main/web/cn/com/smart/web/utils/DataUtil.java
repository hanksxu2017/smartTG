package cn.com.smart.web.utils;

public class DataUtil {

    public static String handleNull(Object obj) {
        return obj == null ? "" : obj.toString().trim();
    }
}
