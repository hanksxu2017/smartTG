//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package cn.com.smart.web.bean;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.Random;
import javax.imageio.ImageIO;
import javax.imageio.stream.ImageOutputStream;

public class Captcha {
	private ByteArrayInputStream image;
	private String str;
	private int imageW;
	private int imageH;
	private int fontSize;
	private Random random = new Random();
	private BufferedImage buffImage;
	private static final char[] randomSequence = new char[]{'A', 'B', 'C', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', '3', '4', '5', '6', '7', '8', '9'};

	public Captcha(int imageW, int imageH, int fontSize) {
		this.imageW = imageW;
		this.imageH = imageH;
		this.fontSize = fontSize;
		this.init();
	}

	public ByteArrayInputStream getImage() {
		return this.image;
	}

	public String getString() {
		return this.str;
	}

	private void init() {
		this.buffImage = new BufferedImage(this.imageW, this.imageH, 1);
		Graphics2D g = this.buffImage.createGraphics();
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, this.imageW, this.imageH);
		Font font = new Font("Courier", 1, this.fontSize);
		g.setFont(font);
		FontMetrics fm = g.getFontMetrics();
		int starX = (this.imageW - fm.stringWidth("A B C D")) / 2;
		int strW = fm.stringWidth(" A");
		String sRand = "";
		g.setColor(Color.BLUE);

		for(int i = 0; i < 4; ++i) {
			int index = this.random.nextInt(randomSequence.length - 1);
			String rand = String.valueOf(randomSequence[index]);
			sRand = sRand + rand;
			int strH = fm.stringWidth(rand);
			int x = starX + strW * i;
			g.drawString(rand, x, this.randY(strH));
		}

		this.str = sRand;
		g.dispose();
		this.buffImage = this.twistImage();
		ByteArrayInputStream input = null;
		ByteArrayOutputStream output = new ByteArrayOutputStream();

		try {
			ImageOutputStream imageOut = ImageIO.createImageOutputStream(output);
			ImageIO.write(this.buffImage, "JPEG", imageOut);
			imageOut.close();
			input = new ByteArrayInputStream(output.toByteArray());
		} catch (Exception var12) {
			System.out.println("验证码图片产生出现错误：" + var12.toString());
		}

		this.image = input;
	}

	private int randY(int strH) {
		int count = 0;

		int y;
		while(true) {
			y = this.random.nextInt(this.imageH - 5);
			if (y - strH > 5) {
				break;
			}

			if (count == 5) {
				y = strH + 6;
				break;
			}

			++count;
		}

		return y;
	}

	private int getXPosition4Twist(double dPhase, double dMultValue, int height, int xPosition, int yPosition) {
		double PI = 3.141592653589793D;
		double dx = PI * (double)yPosition / (double)height + dPhase;
		double dy = Math.sin(dx);
		return xPosition + (int)(dy * dMultValue);
	}

	private BufferedImage twistImage() {
		double dMultValue = 8.0D;
		double dPhase = (double)this.random.nextInt(6);
		BufferedImage destBi = new BufferedImage(this.buffImage.getWidth(), this.buffImage.getHeight(), 1);
		Graphics2D g = destBi.createGraphics();
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, this.imageW, this.imageH);

		for(int i = 0; i < destBi.getWidth(); ++i) {
			for(int j = 0; j < destBi.getHeight(); ++j) {
				int nOldX = this.getXPosition4Twist(dPhase, dMultValue, destBi.getHeight(), i, j);
				if (nOldX >= 0 && nOldX < destBi.getWidth() && j >= 0 && j < destBi.getHeight()) {
					destBi.setRGB(nOldX, j, this.buffImage.getRGB(i, j));
				}
			}
		}

		return destBi;
	}

	public int getImageW() {
		return this.imageW;
	}

	public void setImageW(int imageW) {
		this.imageW = imageW;
	}

	public int getImageH() {
		return this.imageH;
	}

	public void setImageH(int imageH) {
		this.imageH = imageH;
	}

	public BufferedImage getBuffImage() {
		return this.buffImage;
	}
}
