package com.kst.common.base.controller;

import com.google.zxing.qrcode.encoder.QRCode;
import com.kst.common.utils.FileUtils;
import com.kst.common.utils.QRCodeUtil;
import com.kst.common.utils.RestResponse;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.mybatis.logging.Logger;
import org.mybatis.logging.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("qrcode")
public class QrcodeController {

    private static final Logger LOGGER = LoggerFactory.getLogger(QrcodeController.class);

    @RequestMapping("/detail")
    public String detail(String id, HttpServletRequest request, HttpServletResponse response) {
        return "templates/qrcode/detail";
    }

    @GetMapping("previewQRcode")
    //进入预览页面
    public String previewQRcode() {
        return "qrcode/preview";
    }

    @PostMapping("createImage")
    @ResponseBody
    //生成二维码图片并返回路径
    public List<String> createImage(String qrcodeList,String showTextList){
        List<String> qrcode=new ArrayList<>();
        List<String> showText=new ArrayList<>();

        JSONArray object=JSONArray.fromObject(qrcodeList);
        for (Object o:object){
            qrcode.add(String.valueOf(o));
        }
        JSONArray object1=JSONArray.fromObject(showTextList);
        for (Object o:object1){
            showText.add(String.valueOf(o));
        }

        List<String> pathList= QRCodeUtil.createCode(qrcode,showText);
        return pathList;
    }

    @PostMapping("printQrcode")
    @ResponseBody
    public RestResponse printQRcode(@RequestBody List<String> list){
        File f=new File("");
        String p="";
        try {
            p= f.getCanonicalPath();
        } catch (IOException e) {
            e.printStackTrace();
        }
        for (String s:list){
            String path=p+s;
            //System.out.println(path);
            QRCodeUtil.drawImage(path,1);
        }
        return RestResponse.success();
    }

    @PostMapping("deleteQrcodeImage")
    //打印完成后删除本地的二维码图片
    public void deleteQrcodeImage(@RequestBody List<String> list){
        File f=new File("");
        String p="";
        try {
            p= f.getCanonicalPath();
        } catch (IOException e) {
            e.printStackTrace();
        }
        for (String s:list){
            FileUtils.deleteFile(p+s);
        }
    }


    //页面显示二维码
    @RequestMapping("getQRcode")
    public void getQRcode(String assetInputNo, HttpServletRequest request, HttpServletResponse response) {
        //String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/qrcode/detail?id="+id;
        QRCodeUtil.generateQRCode(assetInputNo, 0, response);
    }



}
