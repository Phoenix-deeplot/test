package com.kst.ams.utils;

import com.kst.ams.entity.AssetExamine;
import com.kst.ams.vo.*;
import com.kst.common.constant.Setting;
import com.kst.common.shiro.MySysUser;
import com.kst.common.utils.FileUtils;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.Organization;
import com.kst.sys.api.entity.User;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.*;


public class DocOutUtil {
    XSSFWorkbook wb;
    CellStyle sumStyle;
    CellStyle inStyle;
    CellStyle leftStyle;
    CellStyle rightStyle;
    CellStyle numberStyle;
    CellStyle finLeftStyle;
    CellStyle finRightStyle;
    CellStyle finNumberStyle;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat namesdf = new SimpleDateFormat("yyyyMMdd");

    public XSSFWorkbook createWorkbook(String url) throws IOException {
        InputStream in = null;
        in = new FileInputStream(url);
        wb = new XSSFWorkbook(in);
        wb.setForceFormulaRecalculation(true);
        XSSFDataFormat df = wb.createDataFormat();

        sumStyle = wb.createCellStyle();
        inStyle = wb.createCellStyle();
        leftStyle = wb.createCellStyle();
        rightStyle = wb.createCellStyle();
        finLeftStyle = wb.createCellStyle();
        finRightStyle = wb.createCellStyle();
        numberStyle = wb.createCellStyle();
        finNumberStyle = wb.createCellStyle();

        sumStyle.setBorderBottom(BorderStyle.MEDIUM);
        sumStyle.setBorderLeft(BorderStyle.THIN);
        sumStyle.setBorderTop(BorderStyle.MEDIUM);
        sumStyle.setBorderRight(BorderStyle.THIN);

        inStyle.setBorderBottom(BorderStyle.THIN);
        inStyle.setBorderLeft(BorderStyle.THIN);
        inStyle.setBorderTop(BorderStyle.THIN);
        inStyle.setBorderRight(BorderStyle.THIN);

        leftStyle.setBorderBottom(BorderStyle.THIN);
        leftStyle.setBorderLeft(BorderStyle.MEDIUM);
        leftStyle.setBorderTop(BorderStyle.THIN);
        leftStyle.setBorderRight(BorderStyle.THIN);

        rightStyle.setBorderBottom(BorderStyle.THIN);
        rightStyle.setBorderLeft(BorderStyle.THIN);
        rightStyle.setBorderTop(BorderStyle.THIN);
        rightStyle.setBorderRight(BorderStyle.MEDIUM);

        finLeftStyle.setBorderBottom(BorderStyle.MEDIUM);
        finLeftStyle.setBorderLeft(BorderStyle.MEDIUM);
        finLeftStyle.setBorderTop(BorderStyle.MEDIUM);
        finLeftStyle.setBorderRight(BorderStyle.THIN);

        finRightStyle.setBorderBottom(BorderStyle.MEDIUM);
        finRightStyle.setBorderLeft(BorderStyle.THIN);
        finRightStyle.setBorderTop(BorderStyle.MEDIUM);
        finRightStyle.setBorderRight(BorderStyle.MEDIUM);

        numberStyle.setBorderBottom(BorderStyle.THIN);
        numberStyle.setBorderLeft(BorderStyle.THIN);
        numberStyle.setBorderTop(BorderStyle.THIN);
        numberStyle.setBorderRight(BorderStyle.MEDIUM);
        numberStyle.setDataFormat(df.getFormat("#,##0.00"));

        finNumberStyle.setBorderBottom(BorderStyle.MEDIUM);
        finNumberStyle.setBorderLeft(BorderStyle.THIN);
        finNumberStyle.setBorderTop(BorderStyle.MEDIUM);
        finNumberStyle.setBorderRight(BorderStyle.MEDIUM);
        finNumberStyle.setDataFormat(df.getFormat("#,##0.00"));

        return wb;
    }

    static SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy年MM月止");

    public void exportDivideExcel(String yymm, List<DepreciationVO> list, String organName, HttpServletResponse response, HttpServletRequest request) {
        //合计
        DepreciationVO sumVo = new DepreciationVO();
        for (DepreciationVO v : list) {
            sumVo.setProvisionAllValue(sumVo.getProvisionAllValue() + v.getProvisionAllValue());
            sumVo.setBalanceValue(sumVo.getBalanceValue() + v.getBalanceValue());
            sumVo.setProvisionValue(sumVo.getProvisionValue() + v.getProvisionValue());
            sumVo.setNetWorth(sumVo.getNetWorth() + v.getNetWorth());
            sumVo.setResidualPrice(sumVo.getResidualPrice() + v.getResidualPrice());
            sumVo.setMonthProvision(sumVo.getMonthProvision() + v.getMonthProvision());
            sumVo.setPrice(sumVo.getPrice() + v.getPrice());
            sumVo.setAmount(sumVo.getAmount() + v.getAmount());
            sumVo.setName("合计");
        }
        list.add(sumVo);

        try {
            wb = createWorkbook(new File("").getCanonicalPath() + "\\attach\\excelModel\\AssetDivide.xlsx");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        XSSFSheet sheet = wb.getSheet("Sheet1");
        //报表
        XSSFRow row1 = sheet.getRow(1);
        row1.createCell(2).setCellValue(yymm.substring(0, 4) + "年" + yymm.substring(4, 6) + "月");
        row1.getCell(10).setCellValue(organName);

        XSSFRow row2 = sheet.getRow(2);
        row2.createCell(10).setCellValue(new SimpleDateFormat("yyyy年MM月dd日").format(new Date()));
        row2.getCell(13).setCellValue(MySysUser.nickName());


        Field[] cls = new DepreciationVO().getClass().getDeclaredFields();
        //循环生成表格内容
        for (int i = 0; i < list.size(); i++) {
            XSSFRow row = sheet.createRow(i + 4);
            DepreciationVO vo = list.get(i);
            try {
                if (i == list.size() - 1) {
                    for (int j = 0; j <= cls.length; j++) {

                        Field f = cls[0];
                        if (j >= 1) {
                            f = cls[j - 1];
                            f.setAccessible(true);
                        }

                        XSSFCell cell = row.createCell(j);
                        if (j == 0) {
                            cell.setCellStyle(finLeftStyle);
                        } else if (j == cls.length) {
                            cell.setCellStyle(finRightStyle);
                        } else if (j == 1 || j == 2 || j == 4 || j == 9) {
                            cell.setCellStyle(sumStyle);
                        } else {
                            if (f.getType().equals(java.lang.Double.class)) {
                                cell.setCellStyle(finNumberStyle);
                                cell.setCellValue(Double.valueOf(String.valueOf(f.get(vo))));
                            }else{
                                cell.setCellStyle(sumStyle);
                                cell.setCellValue(String.valueOf(f.get(vo)));
                            }
                        }
                    }
                } else {
                    for (int j = 0; j <= cls.length; j++) {
                        Field f = cls[0];
                        if (j >= 1) {
                            f = cls[j - 1];
                            f.setAccessible(true);
                        }
                        XSSFCell cell = row.createCell(j);
                        if (j == 0) {
                            cell.setCellStyle(leftStyle);
                            cell.setCellValue(i + 1);
                        } else if (j == cls.length) {
                            cell.setCellStyle(inStyle);
                            cell.setCellValue(String.valueOf(f.get(vo) != null ? sdf2.format(f.get(vo)) : ""));
                        } else if (j == 1) {
                            cell.setCellStyle(rightStyle);
                            cell.setCellValue(String.valueOf(f.get(vo) != null ? sdf.format(f.get(vo)) : ""));
                        } else {
                            if (f.getType().equals(java.lang.Double.class)) {
                                cell.setCellStyle(numberStyle);
                                cell.setCellValue(Double.valueOf(String.valueOf(f.get(vo))));
                            }else{
                                cell.setCellStyle(inStyle);
                                cell.setCellValue(String.valueOf(f.get(vo)));
                            }

                        }

                    }
                }
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }

        outputExcel(wb,"assetDivide" + namesdf.format(new Date()),response);
    }

    public void exportAssetListExcel(List<AssetListVO> list, String organName, String classifyName, HttpServletResponse response, HttpServletRequest request) {
        try {
            wb = createWorkbook(new File("").getCanonicalPath() + "\\attach\\excelModel\\AssetList.xlsx");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        XSSFSheet sheet = wb.getSheet("Sheet1");

        XSSFRow row1 = sheet.getRow(1);
        row1.getCell(9).setCellValue(classifyName);
        row1.getCell(14).setCellValue(organName);

        XSSFRow row2 = sheet.getRow(2);
        row2.createCell(14).setCellValue(new SimpleDateFormat("yyyy年MM月dd日").format(new Date()));
        row2.createCell(17).setCellValue(MySysUser.nickName());

        Field[] cls = new AssetListVO().getClass().getDeclaredFields();
        try {
            for (int i = 0; i < list.size(); i++) {
                XSSFRow row = sheet.createRow(i + 4);
                AssetListVO vo = list.get(i);
                if (i == list.size() - 1) {
                    for (int j = 0; j <= cls.length - 3; j++) {
                        Field f = cls[0];
                        if (j >= 1) {
                            f = cls[j - 1];
                            f.setAccessible(true);
                        }

                        XSSFCell cell = row.createCell(j);
                        if (j == 0) {
                            cell.setCellStyle(finLeftStyle);
                        } else if (j == cls.length - 3) {
                            cell.setCellStyle(finRightStyle);
                        } else {
                            if (f.getType().equals(java.lang.Double.class)) {
                                cell.setCellStyle(finNumberStyle);
                                cell.setCellValue((Double)(f.get(vo)));
                            }else{
                                cell.setCellStyle(sumStyle);
                                cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                            }

                        }

                    }
                } else {
                    for (int j = 0; j <= cls.length - 3; j++) {
                        Field f = cls[0];
                        if (j >= 1) {
                            f = cls[j - 1];
                            f.setAccessible(true);
                        }
                        XSSFCell cell = row.createCell(j);
                        if (j == 0) {
                            cell.setCellStyle(leftStyle);
                            cell.setCellValue(i + 1);
                        } else if (j == cls.length - 3) {
                            cell.setCellStyle(rightStyle);
                            cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                        } else {

                            if (f.getType().equals(java.lang.Double.class)) {
                                cell.setCellStyle(numberStyle);
                                cell.setCellValue((Double)(f.get(vo)));
                            }else{
                                cell.setCellStyle(inStyle);
                                cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                            }
                        }
                    }
                }
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }

        outputExcel(wb,"assetList" + namesdf.format(new Date()),response);

    }

    public void exportAssetListDetailExcel(List<AssetListVO> list, String organName, String classifyName, boolean isDetail, HttpServletResponse response, HttpServletRequest request) {
        try {
            wb = createWorkbook(new File("").getCanonicalPath() + "\\attach\\excelModel\\AssetListDetail.xlsx");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        XSSFSheet sheet = wb.getSheet("Sheet1");

        XSSFRow row1 = sheet.getRow(1);
        row1.getCell(9).setCellValue(classifyName);
        row1.getCell(14).setCellValue(organName);

        XSSFRow row2 = sheet.getRow(2);
        row2.createCell(14).setCellValue(new SimpleDateFormat("yyyy年MM月dd日").format(new Date()));
        row2.createCell(17).setCellValue(MySysUser.nickName());

        Field[] cls = new AssetListVO().getClass().getDeclaredFields();

        int rowNum = 4;//行数
        int rowSize = list.size();
        int cellNum = 34;//列数

        for (int i = 0; i < list.size() - 1; i++) {
            AssetListVO v = list.get(i);
            if (v.getSoftwareInfos().size() >= 2) {
                rowSize += v.getSoftwareInfos().size() - 1;
            }
        }
        createAssetListVoidRow(sheet, rowSize, 37);

        try {
            for (int i = 0; i < list.size(); i++) {
                XSSFRow row = sheet.getRow(rowNum);
                AssetListVO vo = list.get(i);
                int cellIndex = 0;
                for (int j = 0; j <= cls.length; j++) {
                    Field f = cls[0];
                    if (j >= 1) {
                        f = cls[j - 1];
                        f.setAccessible(true);
                    }
                    XSSFCell cell = row.getCell(j);
                    if (j <= cls.length - 3) {
                        if (j == 0) {
                        } else if (j == 1 || j == 2) {
                            cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                            row.getCell(j + 18).setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                        } else if (j == cls.length - 3) {
                            cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                        } else {
                            if (f.getType().equals(java.lang.Double.class)) {
                                cell.setCellStyle(numberStyle);
                                cell.setCellValue((Double)(f.get(vo)));
                            }else{
                                cell.setCellStyle(inStyle);
                                cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                            }
                        }
                        cellIndex++;
                    } else if (f.getName() == "pcInfo") {
                        PcInfoVO pcInfo = (PcInfoVO) f.get(vo);
                        Field[] pcCls = new PcInfoVO().getClass().getDeclaredFields();
                        if (pcInfo != null) {

                            for (int a = 0; a < pcCls.length; a++) {
                                Field pcf = pcCls[a];
                                pcf.setAccessible(true);
                                row.getCell(cellIndex + 3).setCellValue(String.valueOf(pcf.get(pcInfo) != null ? pcf.get(pcInfo) : ""));
                                cellIndex++;
                            }
                        } else {
                            cellIndex += pcCls.length;
                        }
                    } else if (f.getName() == "netInfo") {
                        NetInfoVO netInfo = (NetInfoVO) f.get(vo);
                        Field[] netCls = new NetInfoVO().getClass().getDeclaredFields();
                        if (netInfo != null) {
                            for (int a = 0; a < netCls.length; a++) {
                                Field netf = netCls[a];
                                netf.setAccessible(true);
                                row.getCell(cellIndex + 3).setCellValue(String.valueOf(netf.get(netInfo) != null ? netf.get(netInfo) : ""));
                                cellIndex++;
                            }
                        } else {
                            cellIndex += netCls.length;
                        }
                    } else if (f.getName() == "softwareInfos") {
                        List<SoftwareInfoVO> softwareInfos = (List<SoftwareInfoVO>) f.get(vo);
                        if (softwareInfos != null) {
                            if (softwareInfos.size() > 0) {
                                int a = 0;
                                for (; a < softwareInfos.size(); a++) {
                                    int c = cellIndex;
                                    row = sheet.getRow(rowNum + a);
                                    SoftwareInfoVO soft = softwareInfos.get(a);
                                    Field[] softCls = new SoftwareInfoVO().getClass().getDeclaredFields();
                                    for (int b = 0; b < softCls.length; b++) {
                                        Field softf = softCls[b];
                                        softf.setAccessible(true);
                                        row.getCell(c + 3).setCellValue(String.valueOf(softf.get(soft) != null ? softf.get(soft) : ""));
                                        c++;
                                    }
                                }
                                rowNum += a - 1;
                            }
                        }
                    }
                }
                rowNum++;
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        outputExcel(wb,"assetListDetail" + namesdf.format(new Date()),response);
    }

    public void createAssetListVoidRow(XSSFSheet sheet, int rowSize, int cellSize) {
        int rowNum = 4;
        for (int i = 0; i < rowSize; i++) {
            XSSFRow row = sheet.createRow(rowNum);
            rowNum += 1;
            if (i == rowSize - 1) {
                for (int j = 0; j < cellSize; j++) {
                    XSSFCell cell = row.createCell(j);
                    if (j == 0 || j == 18) {
                        cell.setCellStyle(finLeftStyle);
                        cell.setCellValue(i + 1);
                    } else if (j == 20 || j == 26 || j == 29 || j == 32 || j == 36) {
                        cell.setCellStyle(finRightStyle);
                    } else {
                        cell.setCellStyle(sumStyle);
                    }
                }
            } else {
                for (int j = 0; j < cellSize; j++) {
                    XSSFCell cell = row.createCell(j);
                    if (j == 0 || j == 18) {
                        cell.setCellStyle(leftStyle);
                        cell.setCellValue(i + 1);
                    } else if (j == 20 || j == 26 || j == 29 || j == 32 || j == 36) {
                        cell.setCellStyle(rightStyle);
                    } else {
                        cell.setCellStyle(inStyle);
                    }
                }
            }
        }
    }

    public void exportAssetExamineDetail(List<AssetExamineDetailVO> list, AssetExamine examine, String organName, HttpServletResponse response, HttpServletRequest request) {
        try {
            wb = createWorkbook(new File("").getCanonicalPath() + "\\attach\\excelModel\\AssetExamineDetail.xlsx");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        XSSFSheet sheet = wb.getSheet("Sheet1");
        //报表
        XSSFRow row1 = sheet.getRow(1);
        row1.createCell(9).setCellValue(examine.getName());
        row1.getCell(13).setCellValue(organName);

        XSSFRow row2 = sheet.getRow(2);
        row2.createCell(9).setCellValue(new SimpleDateFormat("yyyy年MM月dd日").format(examine.getExamineBeginDate()) + "至" + new SimpleDateFormat("yyyy年MM月dd日").format(examine.getExamineEndDate()));
        row2.createCell(13).setCellValue(new SimpleDateFormat("yyyy年MM月dd日").format(new Date()));
        row2.createCell(16).setCellValue(MySysUser.nickName());

        Field[] cls = new AssetExamineDetailVO().getClass().getDeclaredFields();
        try {
            int noCount = 0;
            int ngCount = 0;
            int okCount = 0;
            for (int i = 0; i < list.size(); i++) {
                XSSFRow row = sheet.createRow(i + 4);
                AssetExamineDetailVO vo = list.get(i);
                for (int j = 0; j < cls.length; j++) {
                    Field f = cls[j];
                    f.setAccessible(true);
                    XSSFCell cell = row.getCell(0);
                    if (j < cls.length - 1) {
                        cell = row.createCell(j);
                        cell.setCellStyle(inStyle);
                        if(f.getType().equals(java.lang.Double.class)){
                            cell.setCellStyle(numberStyle);
                        }
                    }
                    if (i == list.size() - 1) {
                        if (j == 0) {
                            cell.setCellStyle(finLeftStyle);
                        } else if (j == cls.length - 1) {
                            cell = row.createCell(j + 2);
                            cell.setCellStyle(finRightStyle);
                        } else if (j == 13) {
                            cell.setCellStyle(sumStyle);
                            cell.setCellValue(noCount);
                            XSSFCell cell1 = row.createCell(j + 1);
                            cell1.setCellStyle(sumStyle);
                            cell1.setCellValue(okCount);
                            XSSFCell cell2 = row.createCell(j + 2);
                            cell2.setCellStyle(sumStyle);
                            cell2.setCellValue(ngCount);
                        } else {
                            if (f.getType().equals(java.lang.Double.class)) {
                                cell.setCellStyle(finNumberStyle);
                                cell.setCellValue((Double)(f.get(vo)));
                            }else{
                                cell.setCellStyle(sumStyle);
                                cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                            }
                        }
                    } else {
                        if (j == 0) {
                            cell.setCellValue(i + 1);
                            cell.setCellStyle(leftStyle);
                        } else if (j == cls.length - 1) {
                            cell = row.createCell(j + 2);
                            cell.setCellStyle(rightStyle);
                            cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                        } else if (j == 13) {
                            XSSFCell cell2 = row.createCell(j + 1);
                            cell2.setCellStyle(inStyle);
                            XSSFCell cell3 = row.createCell(j + 2);
                            cell3.setCellStyle(inStyle);
                            if (f.get(vo).equals("未点检")) {
                                noCount += 1;
                                cell.setCellValue("√");
                            } else if (f.get(vo).equals("OK")) {
                                okCount += 1;
                                cell2.setCellValue("√");
                            } else if (f.get(vo).equals("NG")) {
                                ngCount += 1;
                                cell3.setCellValue("√");
                            }
                        } else {
                            if (f.getType().equals(java.lang.Double.class)) {
                                cell.setCellStyle(numberStyle);
                                cell.setCellValue((Double)(f.get(vo)));
                            }else{
                                cell.setCellStyle(inStyle);
                                cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                            }
                        }
                    }
                }
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        outputExcel(wb,"AssetExamineDetail"+namesdf.format(new Date()),response);
    }

    //报废excel
    public void exportAssetDiscardExcel(List<AssetDiscardVO> list, String yymm, boolean isReserveFlag, String organName, HttpServletResponse response, HttpServletRequest request) {
        String reName = "";
        try {
            String url = new File("").getCanonicalPath() + "\\attach\\excelModel\\";
            if (isReserveFlag) {
                url += "AssetDiscardListInfact.xlsx";
                reName = "AssetDiscardListInfact" + namesdf.format(new Date()) + ".xlsx";
            } else {
                url += "AssetDiscardList.xlsx";
                reName = "AssetDiscardList" + namesdf.format(new Date()) + ".xlsx";
            }
            wb = createWorkbook(url);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


        XSSFSheet sheet = wb.getSheet("Sheet1");
        //报表
        XSSFRow row1 = sheet.getRow(1);
        XSSFRow row2 = sheet.getRow(2);
        String nowDate = new SimpleDateFormat("yyyy年MM月dd日").format(new Date());
        String userName = MySysUser.nickName();
        if (isReserveFlag) {
            //实际  比预定多一个字段实际报废日 actualScrapDate
            row1.getCell(12).setCellValue(organName);
            row2.createCell(12).setCellValue(nowDate);
            row2.createCell(15).setCellValue(userName);
        } else {
            //预定
            row1.getCell(11).setCellValue(organName);
            row2.createCell(11).setCellValue(nowDate);
            row2.createCell(14).setCellValue(userName);
        }
        row1.createCell(6).setCellValue(yymm);

        Field[] cls = new AssetDiscardVO().getClass().getDeclaredFields();
        if (!isReserveFlag) {
            Field field = cls[10];
            Field[] newCls = {};
            int reLength = 0;

            Field[] tmp = new Field[cls.length - 1];
            int idx = 0;
            for (int i = 0; i < cls.length; i++) {
                if (i == 10) {
                    continue;
                }
                tmp[idx++] = cls[i];
            }
            cls = tmp;
        }
        try {
            for (int i = 0; i < list.size(); i++) {
                XSSFRow row = sheet.createRow(i + 4);
                AssetDiscardVO vo = list.get(i);
                for (int j = 0; j < cls.length; j++) {
                    Field f = cls[j];
                    f.setAccessible(true);
                    XSSFCell cell = row.getCell(0);
                    cell = row.createCell(j);
                    if (f.getType().equals(java.lang.Double.class)) {
                        cell.setCellType(CellType.NUMERIC);
                        if(j==cls.length-1){
                            cell.setCellStyle(finNumberStyle);
                        }else{
                            cell.setCellStyle(numberStyle);
                        }
                    }else{
                        cell.setCellStyle(inStyle);
                    }

                    if (i == list.size() - 1) {
                        if (j == 0) {
                            cell.setCellStyle(finLeftStyle);
                        } else if (j == cls.length - 1) {
                            cell = row.createCell(j);
                            cell.setCellStyle(finRightStyle);
                        } else {
                            if (f.getType().equals(java.lang.Double.class)) {
                                cell.setCellStyle(finNumberStyle);
                                cell.setCellValue((Double)(f.get(vo)));
                            }else{
                                cell.setCellStyle(sumStyle);
                                cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                            }
                        }
                    } else {
                        if (j == 0) {
                            cell.setCellValue(i + 1);
                            cell.setCellStyle(leftStyle);
                        } else if (j == cls.length - 1) {
                            cell.setCellStyle(rightStyle);
                            cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                        } else {
                            if (f.getType().equals(java.lang.Double.class)) {
                                cell.setCellValue((Double)(f.get(vo)));
                            }else{
                                cell.setCellValue(String.valueOf(f.get(vo) != null ? f.get(vo) : ""));
                            }
                        }
                    }
                }
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }

        outputExcel(wb,reName,response);
    }

    //资产模板
    public void exportAssetInfoModel(List<Dict> dicts, List<Organization> organizations,HttpServletResponse response){
        XSSFWorkbook wb = new XSSFWorkbook();
        InputStream in = null;
        try {
            in = new FileInputStream(new File("").getCanonicalPath() + "\\attach\\excelModel\\AssetInfo.xlsx");
            wb = new XSSFWorkbook(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
        XSSFSheet sheet=wb.getSheet("下拉数据");
        XSSFRow row1=sheet.createRow(0);//资产分类的下拉项
        XSSFRow row2=sheet.createRow(1);
        for (int i=0;i<dicts.size();i++){
            row1.createCell(i).setCellValue(dicts.get(i).getLabel());
            row2.createCell(i).setCellValue(dicts.get(i).getValue());
        }

        XSSFRow row3=sheet.createRow(2);
        for (int i=0;i<5;i++){
            row3.createCell(i).setCellValue(i+1);
        }

        XSSFRow row4=sheet.createRow(3);
        XSSFRow row5=sheet.createRow(4);

        for (int i=0;i<organizations.size();i++ ){
            row4.createCell(i).setCellValue(organizations.get(i).getName());
            row5.createCell(i).setCellValue(organizations.get(i).getId().toString());
        }
        outputExcel(wb,"AssetInfo"+namesdf.format(new Date()),response);
    }


    //流导出excel文件到浏览器下载
    public void outputExcel(XSSFWorkbook wb,String fileName,HttpServletResponse response){
        OutputStream os = null;
        try {
            os = response.getOutputStream();
            response.reset();
            response.setHeader("Content-disposition", "attachment;filename=" + fileName+ ".xlsx"); //定义下载的类型，标明是excel文件
            response.setContentType("application/vnd.ms-excel"); //这时候把创建好的excel写入到输出流
            wb.write(os);
            os.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
