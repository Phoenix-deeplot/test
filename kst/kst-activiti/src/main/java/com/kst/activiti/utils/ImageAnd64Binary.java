package com.kst.activiti.utils;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.codec.binary.Base64;



public class ImageAnd64Binary {
	
	public static void main(String[] args) {
		String imgSrcPath = "H:/1.jpg"; 		// 生成64编码的图片的路径
		String imgCreatePath = "H:/123.png"; 	// 将64编码生成图片的路径
		imgCreatePath = imgCreatePath.replaceAll("\\\\", "/");
		System.out.println(imgCreatePath);
		String strImg = getImageStr(imgSrcPath);
		System.out.println(strImg);
		generateImage(strImg, imgCreatePath);
	}

	public static String getImageStr(String imgSrcPath) {
		InputStream in = null;
		byte[] data = null;
		// 读取图片字节数组
		try {
			in = new FileInputStream(imgSrcPath);
			data = new byte[in.available()];
			in.read(data);
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 对字节数组Base64编码
		return Base64.encodeBase64String(data);// 返回Base64编码过的字节数组字符串
	}

	public static boolean generateImage(String imgStr, String imgCreatePath) {
		if (imgStr == null) // 图像数据为空
			return false;
		try {
			// Base64解码
			byte[] b = Base64.decodeBase64(imgStr);
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {// 调整异常数据
					b[i] += 256;
				}
			}
			OutputStream out = new FileOutputStream(imgCreatePath);
			out.write(b);
			out.flush();
			out.close();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

}
