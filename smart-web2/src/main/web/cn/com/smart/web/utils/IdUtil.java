package cn.com.smart.web.utils;

import java.util.UUID;

public class IdUtil {


    public static String generateIdByUUid() {
        String uuid = UUID.randomUUID().toString().replace("-", "").toLowerCase();
        return uuid;
    }
}
