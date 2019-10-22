package com.kst.common.utils;


import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import com.kst.common.constant.Setting;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.imageio.ImageIO;
import javax.print.*;
import javax.print.attribute.DocAttributeSet;
import javax.print.attribute.HashDocAttributeSet;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.Copies;
import javax.print.attribute.standard.MediaPrintableArea;
import javax.print.attribute.standard.MediaSizeName;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.*;

/**
 * @Author: zjf
 * @Date: 2019/06/05
 * @Version 1.0
 * Description: 二维码生成解析工具类
 */
public final class QRCodeUtil {

    private static final Logger logger = LoggerFactory.getLogger(QRCodeUtil.class);

    // 二维码颜色==黑色
    private static final int BLACK = 0xFF000000;
    // 二维码颜色==白色
    private static final int WHITE = 0xFFFFFFFF;

    // 二维码图片格式==jpg和png两种
    private static final List<String> IMAGE_TYPE = new ArrayList<>();

    static {
        IMAGE_TYPE.add("jpg");
        IMAGE_TYPE.add("png");
    }

    /**
     * zxing方式生成二维码
     * 注意：
     * 1,文本生成二维码的方法独立出来,返回image流的形式,可以输出到页面
     * 2,设置容错率为最高,一般容错率越高,图片越不清晰, 但是只有将容错率设置高一点才能兼容logo图片
     * 3,logo图片默认占二维码图片的20%,设置太大会导致无法解析
     *
     * @param content 二维码包含的内容，文本或网址
     * @param path 生成的二维码图片存放位置
     * @param size 生成的二维码图片尺寸 可以自定义或者默认（250）
     * @param logoPath logo的存放位置

     */
    public static boolean generateQRCode(String content, String path, Integer size, String logoPath) {
        try {
            //图片类型
            String imageType = "jpg";
            //获取二维码流的形式，写入到目录文件中
            BufferedImage image = getBufferedImage(content, size, logoPath);
            //获得随机数
            Random random = new Random();
            //生成二维码存放文件
            File file = new File(path + random.nextInt(1000) + ".jpg");
            if (!file.exists()) {
                file.mkdirs();
            }
            ImageIO.write(image, imageType, file);
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void generateQRCode(String content, Integer size, HttpServletResponse response) {
        try {
            //图片类型
            String imageType = "png";
            //获取二维码流的形式
            BufferedImage image = getBufferedImage(content, size, "");
            //转换成png格式的IO流
            ImageIO.write(image, imageType,response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 二维码流的形式，包含文本内容
     *
     * @param content 二维码文本内容
     * @param size 二维码尺寸
     * @param logoPath logo的存放位置
     * @return
     */
    public static BufferedImage getBufferedImage(String content, Integer size, String logoPath) {
        if (size == null || size <= 0) {
            size = 250;
        }
        BufferedImage image = null;
        try {
            // 设置编码字符集
            Map<EncodeHintType, Object> hints = new HashMap<>();
            //设置编码
            hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            //设置容错率最高
            hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
            hints.put(EncodeHintType.MARGIN, 1);
            // 1、生成二维码
            MultiFormatWriter multiFormatWriter = new MultiFormatWriter();
            BitMatrix bitMatrix = multiFormatWriter.encode(content, BarcodeFormat.QR_CODE, size, size, hints);
            // 2、获取二维码宽高
            int codeWidth = bitMatrix.getWidth();
            int codeHeight = bitMatrix.getHeight();
            // 3、将二维码放入缓冲流
            image = new BufferedImage(codeWidth, codeHeight, BufferedImage.TYPE_INT_RGB);
            for (int i = 0; i < codeWidth; i++) {
                for (int j = 0; j < codeHeight; j++) {
                    // 4、循环将二维码内容定入图片
                    image.setRGB(i, j, bitMatrix.get(i, j) ? BLACK : WHITE);
                }
            }
            //判断是否写入logo图片
            if (logoPath != null && !"".equals(logoPath)) {
                File logoPic = new File(logoPath);
                if (logoPic.exists()) {
                    Graphics2D g = image.createGraphics();
                    BufferedImage logo = ImageIO.read(logoPic);
                    int widthLogo = logo.getWidth(null) > image.getWidth() * 2 / 10 ? (image.getWidth() * 2 / 10) : logo.getWidth(null);
                    int heightLogo = logo.getHeight(null) > image.getHeight() * 2 / 10 ? (image.getHeight() * 2 / 10) : logo.getHeight(null);
                    int x = (image.getWidth() - widthLogo) / 2;
                    int y = (image.getHeight() - heightLogo) / 2;
                    // 开始绘制图片
                    g.drawImage(logo, x, y, widthLogo, heightLogo, null);
                    g.drawRoundRect(x, y, widthLogo, heightLogo, 15, 15);
                    //边框宽度
                    g.setStroke(new BasicStroke(2));
                    //边框颜色
                    g.setColor(Color.WHITE);
                    g.drawRect(x, y, widthLogo, heightLogo);
                    g.dispose();
                    logo.flush();
                    image.flush();
                }
            }

        }catch (WriterException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return image;
    }

    /**
     * 给二维码图片添加Logo
     *
     * @param qrPic   二维码图片
     * @param logoPic logo图片
     * @param path    合成后的图片存储目录
     */
    public static boolean generateQRCode(File qrPic, File logoPic, String path) {
        try {
            String imageType = path.substring(path.lastIndexOf(".") + 1).toLowerCase();
            if (!IMAGE_TYPE.contains(imageType)) {
                return false;
            }
            if (!qrPic.isFile() && !logoPic.isFile()) {
                return false;
            }
            //读取二维码图片，并构建绘图对象
            BufferedImage image = ImageIO.read(qrPic);
            Graphics2D g = image.createGraphics();
            //读取Logo图片
            BufferedImage logo = ImageIO.read(logoPic);
            //设置logo的大小,最多20%
            int widthLogo = logo.getWidth(null) > image.getWidth() * 2 / 10 ? (image.getWidth() * 2 / 10) : logo.getWidth(null);
            int heightLogo = logo.getHeight(null) > image.getHeight() * 2 / 10 ? (image.getHeight() * 2 / 10) : logo.getHeight(null);
            // 计算图片放置位置，默认在中间
            int x = (image.getWidth() - widthLogo) / 2;
            int y = (image.getHeight() - heightLogo) / 2;
            // 开始绘制图片
            g.drawImage(logo, x, y, widthLogo, heightLogo, null);
            g.drawRoundRect(x, y, widthLogo, heightLogo, 15, 15);
            //边框宽度
            g.setStroke(new BasicStroke(2));
            //边框颜色
            g.setColor(Color.WHITE);
            g.drawRect(x, y, widthLogo, heightLogo);
            g.dispose();
            logo.flush();
            image.flush();
            File newFile = new File(path);
            if (!newFile.exists()) {
                newFile.mkdirs();
            }
            ImageIO.write(image, imageType, newFile);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 解析指定路径下的二维码图片
     *
     * @param path 二维码图片路径
     * @return
     */
    public static Result parseQRCode(String path) {
        try {
            MultiFormatReader formatReader = new MultiFormatReader();
            File file = new File(path);
            if (file.exists()) {
                BufferedImage image = ImageIO.read(file);
                LuminanceSource source = new BufferedImageLuminanceSource(image);
                Binarizer binarizer = new HybridBinarizer(source);
                BinaryBitmap binaryBitmap = new BinaryBitmap(binarizer);
                Map hints = new HashMap();
                hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
                Result result = formatReader.decode(binaryBitmap, hints);
                return result;
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (NotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 打印二维码
     * @param fileName
     * @param count
     */
    public static void drawImage(String fileName, int count) {
        try {
            DocFlavor dof = null;

            if (fileName.endsWith(".gif")) {
                dof = DocFlavor.INPUT_STREAM.GIF;
            } else if (fileName.endsWith(".jpg")) {
                dof = DocFlavor.INPUT_STREAM.JPEG;
            } else if (fileName.endsWith(".png")) {
                dof = DocFlavor.INPUT_STREAM.PNG;
            }
            // 获取默认打印机
            PrintService ps = PrintServiceLookup.lookupDefaultPrintService();

            PrintRequestAttributeSet pras = new HashPrintRequestAttributeSet();
//			pras.add(OrientationRequested.PORTRAIT);
//			pras.add(PrintQuality.HIGH);
            pras.add(new Copies(count));
            pras.add(MediaSizeName.ISO_A4); // 设置打印的纸张

            DocAttributeSet das = new HashDocAttributeSet();
            das.add(new MediaPrintableArea(0, 0, 30, 30, MediaPrintableArea.INCH));
            FileInputStream fin = new FileInputStream(fileName);

            Doc doc = new SimpleDoc(fin, dof, das);
            DocPrintJob job = ps.createPrintJob();

            job.print(doc, pras);
            fin.close();
        } catch (IOException ie) {
            ie.printStackTrace();
        } catch (PrintException pe) {
            pe.printStackTrace();
        }
    }

    /**
     * 批量生成二维码 5*6
     * @param qrcodeList:二维码包含的内容集合，文本或网址
     * @param showTextList 二维码
     */
    public static List<String> createCode(List<String> qrcodeList,List<String> showTextList){

        List<String> pathList=new ArrayList<>();

            int pageNum=qrcodeList.size()/30;
            for (int j=0;j<=pageNum;j++){
                int startIndex=(0+(j*30));
                int endIndex=(j+1)*30;
                if(j==pageNum){
                    endIndex=qrcodeList.size();
                }

                List<String> imgList=qrcodeList.subList(startIndex,endIndex);
                List<String> textList=showTextList.subList(startIndex,endIndex);

                double length=qrcodeList.size();
                int r=(int)Math.ceil(length/5);

                BufferedImage combined = new BufferedImage(2800, 6*640, BufferedImage.TYPE_INT_ARGB);
                String savePath= Setting.BASEFLODER +"/temporary/"+FileUtils.createFileName()+".png";
                Graphics g = combined.getGraphics();
                g.setColor(Color.black);
                Font font = new Font("Microsoft JhengHei",Font.BOLD,24);
                g.setFont(font);
                int x=10;
                int y=0;
                for (int i=0;i<imgList.size();i++){
                    BufferedImage image = QRCodeUtil.getBufferedImage(imgList.get(i), 500, null);
                    int line=i%5;

                    if(line==0){
                        g.drawImage(image, x, y, null);
                        draw(g,textList.get(i),x,y+540,font);
                        x+=560;
                    }else if(line==1){
                        g.drawImage(image, x, y, null);
                        draw(g,textList.get(i),x,y+540,font);
                        x+=560;
                    }else if(line==2){
                        g.drawImage(image, x, y, null);
                        draw(g,textList.get(i),x,y+540,font);
                        x+=560;
                    }else if(line==3){
                        g.drawImage(image, x, y, null);
                        draw(g,textList.get(i),x,y+540,font);
                        x+=560;
                    }else if(line==4){
                        g.drawImage(image, x, y, null);
                        draw(g,textList.get(i),x,y+540,font);
                        x=10;
                        y+=640;
                    }
                }
                File f=new File(savePath);
                if (!f.getParentFile().exists()) {
                    f.getParentFile().mkdirs();
                }
                try {
                    ImageIO.write(combined,"PNG",f);
                } catch (IOException e) {
                    e.printStackTrace();
                }
                pathList.add("/"+savePath);
            }

        return pathList;
    }

    //写入二维码下的文本
    public static void draw(Graphics g,String text,int x,int y,Font font){
        char[] textChar=text.toCharArray();
        int textLength=0;//当前字符宽度
        String t="";//一行字符串
        int num=0;//行数
        for (int j=0;j<textChar.length;j++){
            char c=textChar[j];
            int charWidth=g.getFontMetrics(font).charWidth(c);

            if(textLength>=480){
                //字符长度超过二维码宽度，打印一行
                g.drawString(t,x,y+num*30);
                num+=1;
                t=String.valueOf(c);
                textLength=charWidth;
            }else{
                //字符长度小于二维码宽度，继续添加
                textLength+=charWidth;
                t+=c;
            }
            if(j==textChar.length-1){
                g.drawString(t,x,y+num*30);
            }
        }
    }




   /* public static void main(String[] args) {
        String text = "hello world!"; // 随机生成验证码
        System.out.println("随机码： " + text);
        int width = 100; // 二维码图片的宽
        int height = 100; // 二维码图片的高
        String format = "png"; // 二维码图片的格式


        try {
            // 生成二维码图片，并返回图片路径
            String pathName = generateQRCode(text, width, height, format, "D:/new.png");
            System.out.println("生成二维码的图片路径： " + pathName);

            String content = parseQRCode(pathName);
            System.out.println("解析出二维码的图片的内容为： " + content);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }*/

}