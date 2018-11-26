//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package cn.com.smart.web.utils;

import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

public abstract class DESCoder extends Coder {
	public static final String ALGORITHM = "DES";

	public DESCoder() {
	}

	private static Key toKey(byte[] key) throws Exception {
		DESKeySpec dks = new DESKeySpec(key);
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey secretKey = keyFactory.generateSecret(dks);
		return secretKey;
	}

	public static byte[] decrypt(byte[] data, String key) throws Exception {
		Key k = toKey(encryptBASE64(key.getBytes()).getBytes());
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(2, k);
		return cipher.doFinal(data);
	}

	public static byte[] encrypt(byte[] data, String key) throws Exception {
		Key k = toKey(encryptBASE64(key.getBytes()).getBytes());
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(1, k);
		return cipher.doFinal(data);
	}

	public static String initKey() throws Exception {
		return initKey((String)null);
	}

	public static String initKey(String seed) throws Exception {
		SecureRandom secureRandom = null;
		if (seed != null) {
			secureRandom = new SecureRandom(decryptBASE64(seed));
		} else {
			secureRandom = new SecureRandom();
		}

		KeyGenerator kg = KeyGenerator.getInstance("DES");
		kg.init(secureRandom);
		SecretKey secretKey = kg.generateKey();
		return encryptBASE64(secretKey.getEncoded());
	}

	private static SecretKey generateKey(String secretKey) throws NoSuchAlgorithmException {
		SecureRandom secureRandom = new SecureRandom(secretKey.getBytes());
		KeyGenerator kg = null;

		try {
			kg = KeyGenerator.getInstance("DES");
		} catch (NoSuchAlgorithmException var4) {
			;
		}

		kg.init(secureRandom);
		return kg.generateKey();
	}
}
