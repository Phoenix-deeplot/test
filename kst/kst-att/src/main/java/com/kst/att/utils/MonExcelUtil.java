package com.kst.att.utils;

import com.kst.att.vo.SignVO;
import com.kst.sys.api.entity.Calandar;
import com.kst.sys.api.service.IDailyService;
import com.kst.sys.api.vo.DailyVO;
import com.kst.sys.service.impl.DailyServiceImpl;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;


public class MonExcelUtil {
    XSSFWorkbook wb;
    /**
     * 生成Excel
     */
    // List<Calandar> calandars
    public void monExcelXLSX(IDailyService iDailyService,Long dailyUserid,Integer totalNum,String attUserid,List<Calandar> calandars,  Date date, String username, List<DailyVO> info) throws Exception {
        wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("0");

        /**
         * 单元格 样式
         */
        Font font = wb.createFont();
        font.setFontHeightInPoints((short) 24);

        CellStyle cellStyle = wb.createCellStyle();
        cellStyle.setBorderTop(BorderStyle.THIN);
        cellStyle.setBorderLeft(BorderStyle.THIN);
        cellStyle.setBorderRight(BorderStyle.THIN);
        cellStyle.setBorderBottom(BorderStyle.THIN);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        /**
         * 标题样式 样式
         */
        XSSFFont titleFont = wb.createFont();
        titleFont.setFontHeight(24);
        titleFont.setBold(true);
        CellStyle titleCellStyle = wb.createCellStyle();
        titleCellStyle.setFont(titleFont);
        titleCellStyle.setBorderTop(BorderStyle.THIN);
        titleCellStyle.setBorderLeft(BorderStyle.THIN);
        titleCellStyle.setBorderRight(BorderStyle.THIN);
        titleCellStyle.setBorderBottom(BorderStyle.THIN);
        titleCellStyle.setAlignment(HorizontalAlignment.CENTER); // 水平对齐
        titleCellStyle.setVerticalAlignment(VerticalAlignment.CENTER); // 垂直对齐


        /**
         * 主 标题 在这里插入主标题
         */
        Row titleRow;
        Cell titleCell;
        sheet.addMergedRegion(new CellRangeAddress((short) 0, (short) 2, (short) 0, (short) 17));
        for (int i = 0; i < 3; i++) {
            titleRow = sheet.createRow(i);
            for (int j = 0; j <=17; j++) {
                titleCell = titleRow.createCell(j);
                titleCell.setCellValue("工作月报表");
                titleCell.setCellStyle(titleCellStyle);
            }
        }

        CellStyle borderStyle = wb.createCellStyle();
        borderStyle.setBorderBottom(BorderStyle.THIN);// 设置下边框


        CellStyle fontCellStyle = wb.createCellStyle();
        Font fontStyle=wb.createFont();//字体
        fontStyle.setBold(true);
        fontCellStyle.setFont(fontStyle);
        fontCellStyle.setBorderTop(BorderStyle.THIN);
        fontCellStyle.setBorderLeft(BorderStyle.THIN);
        fontCellStyle.setBorderRight(BorderStyle.THIN);
        fontCellStyle.setBorderBottom(BorderStyle.THIN);
        fontCellStyle.setAlignment(HorizontalAlignment.CENTER);
        fontCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);



        /**
         * 列 标题 在这里插入标题
         */
        Row rowLabel = sheet.createRow(3);

        CellRangeAddress region=new CellRangeAddress(3,3,0,1);
        sheet.addMergedRegion(region);
        SimpleDateFormat str2 = new SimpleDateFormat("yyyy-MM-dd");
        String str = str2.format(date);
        rowLabel.createCell(0).setCellValue(str.substring(0, 4) + "年" + str.substring(5, 7) + "月度");
        rowLabel.getCell(0).setCellStyle(fontCellStyle);
        rowLabel.createCell(1).setCellStyle(fontCellStyle);
        rowLabel.createCell(3).setCellValue("("+str.substring(5,7)+"/"+str.substring(8,10)+"~"+(Integer.parseInt(str.substring(5,7))+1)+"/"+(Integer.parseInt(str.substring(8,10))-1)+")");
        rowLabel.getCell(3).setCellStyle(fontCellStyle);
        rowLabel.createCell(7).setCellValue("作成日:");
        rowLabel.getCell(7).setCellStyle(fontCellStyle);
        CellRangeAddress region13=new CellRangeAddress(3,3,5,6);
        sheet.addMergedRegion(region13);
        CellRangeAddress region1=new CellRangeAddress(3,3,8,13);
        sheet.addMergedRegion(region1);
        SimpleDateFormat sdfz = new SimpleDateFormat("yyyy年MM月dd日");
        rowLabel.createCell(8).setCellValue(sdfz.format(new Date()));
        rowLabel.getCell(8).setCellStyle(borderStyle);
        rowLabel.createCell(9).setCellStyle(borderStyle);
        rowLabel.createCell(14).setCellValue("姓名:");
        rowLabel.getCell(14).setCellStyle(fontCellStyle);
        CellRangeAddress region2 = new CellRangeAddress(3,3,15,17);
        sheet.addMergedRegion(region2);
        rowLabel.createCell(15).setCellValue(username);
        rowLabel.getCell(15).setCellStyle(borderStyle);
        rowLabel.createCell(17).setCellStyle(borderStyle);
        for(int m = 0; m<=17;m++){
            if(rowLabel.getCell(m)==null){
                rowLabel.createCell(m).setCellStyle(cellStyle);
            }else{
                rowLabel.getCell(m).setCellStyle(cellStyle);
            }
        }
        Row rowLabel1 = sheet.createRow(4);
        CellRangeAddress region3 = new CellRangeAddress(4,4,0,1);
        sheet.addMergedRegion(region3);
        rowLabel1.createCell(0).setCellValue("日期");
        sheet.setColumnWidth(0, 3300);
        sheet.setColumnWidth(1, 1500);
        rowLabel1.createCell(2).setCellValue("出勤时间");
        sheet.setColumnWidth(2, 4300);
        rowLabel1.createCell(3).setCellValue("序号");
        CellRangeAddress region4 = new CellRangeAddress(4,4,3,4);
        sheet.addMergedRegion(region4);
        rowLabel1.createCell(5).setCellValue("关联项目");
        sheet.setColumnWidth(5, 4300);
        CellRangeAddress region5 = new CellRangeAddress(4,4,5,6);
        sheet.addMergedRegion(region5);
        rowLabel1.createCell(7).setCellValue("略称");
        CellRangeAddress region6 = new CellRangeAddress(4,4,8,13);
        sheet.addMergedRegion(region6);
        rowLabel1.createCell(8).setCellValue("工作内容");
        rowLabel1.createCell(14).setCellValue("作业时间");
        rowLabel1.createCell(15).setCellValue("确认(B)");
        CellRangeAddress region7 = new CellRangeAddress(4,4,16,17);
        sheet.addMergedRegion(region7);
        rowLabel1.createCell(16).setCellValue("说明");
        sheet.setColumnWidth(16, 4500);
        for(int m = 0; m<=17;m++){
            if(rowLabel1.getCell(m)==null){
                rowLabel1.createCell(m).setCellStyle(fontCellStyle);
            }else{
                rowLabel1.getCell(m).setCellStyle(fontCellStyle);
            }
        }

        /**
         * 列 数据 在这里插入数据
         */
        Row rowCheck;
        Cell cellCheck;

        Date d1 = new SimpleDateFormat("yyyy-MM-dd").parse(str);//定义起始日期

        Date d2 = new SimpleDateFormat("yyyy-MM-dd").parse(str.substring(0,4)+"-"+(Integer.parseInt(str.substring(5,7))+1)+"-"+(Integer.parseInt(str.substring(8,10))));//定义结束日期
        Calendar c1=Calendar.getInstance();
        c1.setTime(d1);
        Calendar c2=Calendar.getInstance();
        c2.setTime(d2);
        long t1=c1.getTimeInMillis();
        long t2=c2.getTimeInMillis();
        long days=(((t2-t1)/(24*60*60*1000)));

        Calendar dd = Calendar.getInstance();//定义日期实例
        dd.setTime(d1);//设置日期起始时间

        int rowNum=5;
        for(int i=5;i <= days+4;i++){
            CellRangeAddress region9 = new CellRangeAddress(rowNum,rowNum,3,4);
            sheet.addMergedRegion(region9);
            CellRangeAddress region10 = new CellRangeAddress(rowNum,rowNum,5,6);
            sheet.addMergedRegion(region10);
            CellRangeAddress region11 = new CellRangeAddress(rowNum,rowNum,8,13);
            sheet.addMergedRegion(region11);
            CellRangeAddress region12 = new CellRangeAddress(rowNum,rowNum,16,17);
            sheet.addMergedRegion(region12);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            String strDate = sdf.format(dd.getTime());
            //获取星期几
            SimpleDateFormat formatter = new SimpleDateFormat("E");
            String weekDay = formatter.format(dd.getTime());

            /*if(Integer.valueOf(strDate)<10){
                cellCheck.setCellValue(strDate.substring(strDate.length()-1,strDate.length()));
            }else{
                cellCheck.setCellValue(strDate);
            }*/

            CellStyle setStyle = wb.createCellStyle();
            Font fontStyle2=wb.createFont();//字体
            fontStyle2.setBold(true);
            setStyle.setFont(fontStyle2);
            setStyle.setFillForegroundColor(IndexedColors.LIME.getIndex());// 设置背景色
            setStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            setStyle.setBorderTop(BorderStyle.THIN);
            setStyle.setBorderLeft(BorderStyle.THIN);
            setStyle.setBorderRight(BorderStyle.THIN);
            setStyle.setBorderBottom(BorderStyle.THIN);
            setStyle.setAlignment(HorizontalAlignment.CENTER);
            setStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            //创建行
            rowCheck = sheet.createRow(rowNum);

            cellCheck = rowCheck.createCell(0);
            cellCheck.setCellStyle(cellStyle);
            for(int n = 0;n<=17;n++) {
                if (rowCheck.getCell(n) == null) {
                    rowCheck.createCell(n).setCellStyle(fontCellStyle);
                } else {
                    rowCheck.getCell(n).setCellStyle(fontCellStyle);
                }
            }

            String nowDate = sdf.format(new Date());
            if(strDate.equals(nowDate) || strDate.equals(sdf.format(d2))){
                break;
            }else{
                cellCheck.setCellValue(strDate);
                List<DailyVO> li = new ArrayList<>();
                for(int j=0;j<info.size();j++) {
                    if(j>0 && info.get(j).getBeginTime()!=null){
                        DailyVO dailyVO = info.get(j);
                        SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm:ss");
                        String beginTime = sdf2.format(dailyVO.getBeginTime());
                        String hours = beginTime.substring(0,2);
                        String mm = beginTime.substring(3,5);
                        String ss = beginTime.substring(6,8);
                        String endBegintime = hours+":"+mm+":"+ss;
                        String endTime = sdf2.format(dailyVO.getEndTime());
                        String hour = endTime.substring(0,2);
                        String mme = endTime.substring(3,5);
                        String sse = endTime.substring(6,8);
                        String time = hour+":"+mme+":"+sse;
                        String strs = sdf.format(info.get(j).getDate());
                        if (strDate.equals(strs)) {
                            li =iDailyService.selectDailyUserid(dailyUserid,info.get(j).getDate());
                            cellCheck=rowCheck.createCell(1);
                            cellCheck.setCellFormula("TEXT(A"+(rowCheck.getRowNum()+1)+",\"aaa\")");
                            sheet.getRow(rowCheck.getRowNum()).setHeightInPoints(30);
                            cellCheck = rowCheck.createCell(2);
                            cellCheck.setCellValue(endBegintime+" ~ "+time);
                            cellCheck.setCellStyle(cellStyle);
                            cellCheck = rowCheck.createCell(3);
                            cellCheck.setCellValue(info.get(j).getProjectId());
                            cellCheck.setCellStyle(cellStyle);
                            cellCheck = rowCheck.createCell(5);
                            cellCheck.setCellValue(info.get(j).getPjName());
                            cellCheck.setCellStyle(cellStyle);
                            cellCheck = rowCheck.createCell(7);
                            cellCheck.setCellValue(info.get(j).getPjNames());
                            cellCheck.setCellStyle(cellStyle);
                            cellCheck = rowCheck.createCell(8);
                            cellCheck.setCellValue(info.get(j).getContent());
                            cellCheck.setCellStyle(cellStyle);
                            cellCheck = rowCheck.createCell(14);
                            cellCheck.setCellValue(info.get(j).getWorkTimes());
                            cellCheck.setCellStyle(cellStyle);
                        }

                    }

                }
                for(int m = 0; m<=17;m++){
                    if(rowCheck.getCell(m)==null){
                        rowCheck.createCell(m).setCellStyle(fontCellStyle);
                    }else{
                        rowCheck.getCell(m).setCellStyle(fontCellStyle);
                    }
                }

                cellCheck=rowCheck.createCell(1);
                cellCheck.setCellFormula("TEXT(A"+(rowCheck.getRowNum()+1)+",\"aaa\")");
                cellCheck.setCellStyle(cellStyle);

                //创建新行
                for(int x=0;x<li.size()-1;x++){
                    rowNum++;
                    rowCheck = sheet.createRow(rowNum);
                    sheet.getRow(rowCheck.getRowNum()).setHeightInPoints(30);
                    CellRangeAddress region14 = new CellRangeAddress(rowNum,rowNum,3,4);
                    sheet.addMergedRegion(region14);
                    CellRangeAddress region15 = new CellRangeAddress(rowNum,rowNum,5,6);
                    sheet.addMergedRegion(region15);
                    CellRangeAddress region16 = new CellRangeAddress(rowNum,rowNum,8,13);
                    sheet.addMergedRegion(region16);
                    CellRangeAddress region17 = new CellRangeAddress(rowNum,rowNum,16,17);
                    sheet.addMergedRegion(region17);
                    cellCheck = rowCheck.createCell(3);
                    cellCheck.setCellValue(li.get(x).getProjectId());
                    cellCheck.setCellStyle(cellStyle);
                    cellCheck = rowCheck.createCell(5);
                    cellCheck.setCellValue(li.get(x).getPjName());
                    cellCheck.setCellStyle(cellStyle);
                    cellCheck = rowCheck.createCell(7);
                    cellCheck.setCellValue(li.get(x).getPjNames());
                    cellCheck.setCellStyle(cellStyle);
                    cellCheck = rowCheck.createCell(8);
                    cellCheck.setCellValue(li.get(x).getContent());
                    cellCheck.setCellStyle(cellStyle);
                    cellCheck = rowCheck.createCell(14);
                    cellCheck.setCellValue(li.get(x).getWorkTimes());
                    cellCheck.setCellStyle(cellStyle);
                    for(int m = 0; m<=17;m++){
                        if(rowCheck.getCell(m)==null){
                            rowCheck.createCell(m).setCellStyle(fontCellStyle);
                        }else{
                            rowCheck.getCell(m).setCellStyle(fontCellStyle);
                        }
                    }
                }

            }
            dd.add(Calendar.DATE,1);//进行当前日期加1

            CellStyle setStyle2 = wb.createCellStyle();
            Font fontStyle3=wb.createFont();//字体
            fontStyle3.setBold(true);
            setStyle2.setFont(fontStyle3);
            setStyle2.setFillForegroundColor(IndexedColors.SKY_BLUE.getIndex());// 设置背景色
            setStyle2.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            setStyle2.setBorderTop(BorderStyle.THIN);
            setStyle2.setBorderLeft(BorderStyle.THIN);
            setStyle2.setBorderRight(BorderStyle.THIN);
            setStyle2.setBorderBottom(BorderStyle.THIN);
            setStyle2.setAlignment(HorizontalAlignment.CENTER);
            setStyle2.setVerticalAlignment(VerticalAlignment.CENTER);

            //特殊节日
            for(Calandar c : calandars){
                String calDate = sdf.format(c.getCalDate());
                if(strDate.equals(calDate)){
                    cellCheck = rowCheck.createCell(16);
                    cellCheck.setCellValue(c.getCalContent());
                    cellCheck.setCellStyle(setStyle2);
                    for(int m = 0; m<=17;m++){
                        if(rowCheck.getCell(m)==null){
                            rowCheck.createCell(m).setCellStyle(setStyle2);
                        }else{
                            rowCheck.getCell(m).setCellStyle(setStyle2);

                        }
                    }

                }
            }

            if(weekDay.substring(1,2).equals("六") || weekDay.substring(1,2).equals("日")){
                for(int j = 0; j<=17;j++){
                    if(rowCheck.getCell(j)==null){
                        rowCheck.createCell(j).setCellStyle(setStyle);
                    }else{
                        rowCheck.getCell(j).setCellStyle(setStyle);
                    }
                }
            }

            sheet.getRow(3).setHeightInPoints(30);
            sheet.getRow(4).setHeightInPoints(30);
            sheet.getRow(rowNum).setHeightInPoints(30);
            rowNum++;
        }





        CellStyle fontCellStyleF = wb.createCellStyle();
        Font fontStyleF=wb.createFont();//字体
        fontStyle.setBold(true);
        fontCellStyleF.setFont(fontStyle);
        fontCellStyleF.setAlignment(HorizontalAlignment.CENTER);
        fontCellStyleF.setVerticalAlignment(VerticalAlignment.CENTER);

        int rowFinal = (int)(days+totalNum+8);
        Row rowLabel3 = sheet.createRow(rowFinal);
        rowLabel3.createCell(13).setCellValue("组长确认：");
        rowLabel3.getCell(13).setCellStyle(fontCellStyleF);
        rowLabel3.createCell(14).setCellStyle(borderStyle);
        rowLabel3.createCell(15).setCellStyle(borderStyle);
        CellRangeAddress region11 = new CellRangeAddress(rowFinal,rowFinal,14,15);
        sheet.addMergedRegion(region11);

        int rowFinally = (int)(days+totalNum+10);
        Row rowLabel4 = sheet.createRow(rowFinally);
        rowLabel4.createCell(13).setCellValue("最终确认：");
        rowLabel4.getCell(13).setCellStyle(fontCellStyleF);
        rowLabel4.createCell(14).setCellStyle(borderStyle);
        rowLabel4.createCell(15).setCellStyle(borderStyle);
        CellRangeAddress region12 = new CellRangeAddress(rowFinally,rowFinally,14,15);
        sheet.addMergedRegion(region12);

        /**
         * 页脚
         */

        setExcelFooterName(str.substring(0, 4)+str.substring(5, 7), 0, wb);

        /**
         * 进行导出
         * 两位随机数字
         */
        Random random = new Random();
        int ends = random.nextInt(99);
        //exportOutPutExcel(new File("").getCanonicalPath()+"\\出勤表"+String.format("%02d",ends)+".xlsx", wb);
        //exportOutPutExcel("C:\\出勤表"+String.format("%02d",ends)+".xlsx", wb);
        exportOutPutExcel("C:\\月报表"+attUserid+str.substring(0, 4)+str.substring(5, 7)+".xlsx", wb);
    }
    /**
     * 设置Excel页脚
     */
    public void setExcelFooterName(String customExcelFooterName, int setExcelFooterNumber, XSSFWorkbook wb) {
        wb.setSheetName(setExcelFooterNumber, customExcelFooterName);
    }

    /**
     * 输出流 导出Excel到桌面
     */
    public void exportOutPutExcel(String exportPositionPath, XSSFWorkbook wb) {
        try {
            File file = new File(exportPositionPath);
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            wb.write(fileOutputStream);
            fileOutputStream.close();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

}
