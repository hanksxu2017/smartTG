package cn.com.smart.web.utils;

import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

/**
 * 描述:
 * 微信授权
 *
 * @outhor xuwenyi
 * @create 2018-12-19 13:43
 */
@Slf4j
public class VxAuthUtil {

	public static final String APP_ID = "wx2aa0116110bb18bb";

	private static final String APP_SECRET = "5e067b9537236dcd3a8df3a755e29186";

	public static String getUserInfoByCode(String code) {
		/**
		 * 通过code换取网页授权access_token
		 */
		// 同意授权
		if (StringUtils.isNotBlank(code)) {
			// 拼接请求地址
			String url = "https://api.weixin.qq.com/sns/oauth2/access_token?"
					+ "appid=" + APP_ID + "&secret="
					+ APP_SECRET
					+ "&code=" + code
					+ "&grant_type=authorization_code";
			String res = doGet(url);
			log.info("---获取微信用户信息,token信息:{}", res);
			JSONObject json = JSONObject.parseObject(res);

			/**
			 * 拉取用户信息(需scope为 snsapi_userinfo)
			 */
			String url3 = "https://api.weixin.qq.com/sns/userinfo?access_token="
					+ json.getString("access_token")
					+ "&openid="
					+ json.getString("openid") + "&lang=zh_CN";

			String userInfo = VxAuthUtil.doGet(url3);
			log.info("---获取微信用户信息,用户信息:{}", userInfo);

			return userInfo;
		}
		return "";
	}
/*
	public static JSONObject getAccessTokenByCode(String code) {
		// 同意授权
		if (StringUtils.isNotBlank(code)) {
			// 拼接请求地址
			String url = "https://api.weixin.qq.com/sns/oauth2/access_token?"
					+ "appid=" + APP_ID + "&secret="
					+ APP_SECRET
					+ "&code=" + code
					+ "&grant_type=authorization_code";
			String res = doGet(url);
			log.info("---token信息:{}", res);
			return JSONObject.parseObject(res);
		}
		return null;
	}*/

	public static String doGet(String url) {
		CloseableHttpClient httpClient = HttpClients.createDefault();
		RequestConfig requestConfig = RequestConfig.custom()
				.setConnectTimeout(5000)   //设置连接超时时间
				.setConnectionRequestTimeout(5000) // 设置请求超时时间
				.setSocketTimeout(5000)
				.setRedirectsEnabled(true)//默认允许自动重定向
				.build();
		HttpGet httpGet = new HttpGet(url);
		httpGet.setConfig(requestConfig);
		String srtResult = "";
		try {
			HttpResponse httpResponse = httpClient.execute(httpGet);
			if(httpResponse.getStatusLine().getStatusCode() == 200){
				srtResult = entityToStr(httpResponse.getEntity());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				httpClient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return srtResult;
	}

	/**
	 *
	 * @param entity
	 * @return
	 * @throws IOException
	 */
	private static String entityToStr(HttpEntity entity) throws IOException {
		if(entity != null){
			InputStream is = entity.getContent();
			StringBuilder builder = new StringBuilder();
			//转换为字节输入流
			BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
			String body;
			while((body=br.readLine()) != null){
				builder.append(body);
			}
			return builder.toString();
		}
		return "";
	}
}
