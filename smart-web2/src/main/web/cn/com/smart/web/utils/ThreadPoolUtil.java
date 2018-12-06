package cn.com.smart.web.utils;

import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class ThreadPoolUtil {
	private static final ThreadPoolExecutor executor= new ThreadPoolExecutor(2, 8, 200, TimeUnit.MILLISECONDS,
			new LinkedBlockingQueue<Runnable>());
	
	public static ThreadPoolExecutor getThreadPool() {
		return executor;
	}

}