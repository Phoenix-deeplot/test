package com.kst.att.utils;
import com.kst.att.vo.SignVO;
import com.kst.sys.api.entity.Calandar;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;


public class ExcelUtil {
    XSSFWorkbook wb;
    /**
     * 生成Excel
     */
    public void zxExprotExcelXLSX(Integer totalTimes,String attUserid,List<Calandar> calandars, Date date, String username, List<SignVO> info) throws Exception {
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
        sheet.addMergedRegion(new CellRangeAddress((short) 0, (short) 2, (short) 0, (short) 13));
        for (int i = 0; i < 3; i++) {
            titleRow = sheet.createRow(i);
            for (int j = 0; j <=13; j++) {
                titleCell = titleRow.createCell(j);
                titleCell.setCellValue("出勤时间记录表");
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
        rowLabel.createCell(2).setCellValue("("+str.substring(5,7)+"/"+str.substring(8,10)+"~"+(Integer.parseInt(str.substring(5,7))+1)+"/"+(Integer.parseInt(str.substring(8,10))-1)+")");
        rowLabel.getCell(2).setCellStyle(fontCellStyle);
        rowLabel.createCell(6).setCellValue("作成日:");
        rowLabel.getCell(6).setCellStyle(fontCellStyle);
        CellRangeAddress region1=new CellRangeAddress(3,3,7,8);
        sheet.addMergedRegion(region1);
        SimpleDateFormat sdfz = new SimpleDateFormat("yyyy年MM月dd日");
        rowLabel.createCell(7).setCellValue(sdfz.format(new Date()));
        rowLabel.getCell(7).setCellStyle(borderStyle);
        rowLabel.createCell(8).setCellStyle(borderStyle);
        rowLabel.createCell(10).setCellValue("姓名:");
        rowLabel.getCell(10).setCellStyle(fontCellStyle);
        CellRangeAddress region2 = new CellRangeAddress(3,3,11,13);
        sheet.addMergedRegion(region2);
        rowLabel.createCell(11).setCellValue(username);
        rowLabel.getCell(11).setCellStyle(borderStyle);
        rowLabel.createCell(12).setCellStyle(borderStyle);
        for(int m = 0; m<=13;m++){
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
        rowLabel1.createCell(2).setCellValue("打卡地点");
        sheet.setColumnWidth(2, 4300);
        rowLabel1.createCell(3).setCellValue("确认");
        rowLabel1.createCell(4).setCellValue("打卡时间");
        sheet.setColumnWidth(4, 4300);
        rowLabel1.createCell(5).setCellValue("出勤时间");
        rowLabel1.createCell(6).setCellValue("工作时间");
        rowLabel1.createCell(7).setCellValue("休息时间");
        rowLabel1.createCell(8).setCellValue("确认(T)");
        rowLabel1.createCell(9).setCellValue("休假(B)");
        rowLabel1.createCell(10).setCellValue("加班(B)");
        rowLabel1.createCell(11).setCellValue("确认(B)");
        CellRangeAddress region4 = new CellRangeAddress(4,4,12,13);
        sheet.addMergedRegion(region4);
        rowLabel1.createCell(12).setCellValue("说明");
        sheet.setColumnWidth(12, 4500);
        for(int m = 0; m<=13;m++){
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
        long days=(t2-t1)/(24*60*60*1000);

        Calendar dd = Calendar.getInstance();//定义日期实例
        dd.setTime(d1);//设置日期起始时间
        for(int i=5;i<=days+4;i++){
            CellRangeAddress region12 = new CellRangeAddress(i,i,12,13);
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


            rowCheck = sheet.createRow(i);
            cellCheck = rowCheck.createCell(0);
            cellCheck.setCellStyle(cellStyle);
            for(int n = 0;n<=13;n++) {
                if (rowCheck.getCell(n) == null) {
                    rowCheck.createCell(n).setCellStyle(fontCellStyle);
                } else {
                    rowCheck.getCell(n).setCellStyle(fontCellStyle);
                }
            }



            String nowDate = sdf.format(new Date());
            if(strDate.equals(nowDate)){
                break;
            }else{
                //2018-09-10
                //cellCheck.setCellValue(strDate.substring((strDate.lastIndexOf("-"))+1,strDate.length()));
                cellCheck.setCellValue(strDate);
            }
            dd.add(Calendar.DATE,1);//进行当前日期加1
            cellCheck=rowCheck.createCell(1);
            cellCheck.setCellFormula("TEXT(A"+(i+1)+",\"aaa\")");
            cellCheck.setCellStyle(cellStyle);

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
                    cellCheck = rowCheck.createCell(12);
                    cellCheck.setCellValue(c.getCalContent());
                    cellCheck.setCellStyle(setStyle2);
                    for(int m = 0; m<=13;m++){
                        if(rowCheck.getCell(m)==null){
                            rowCheck.createCell(m).setCellStyle(setStyle2);
                        }else{
                            rowCheck.getCell(m).setCellStyle(setStyle2);

                        }
                    }

                }
            }
            rowCheck = sheet.getRow(i);
            for(SignVO signVO : info) {
                String signTime = sdf.format(signVO.getAttSigntime());
                SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm:ss");
                String beginTime = sdf2.format(signVO.getBeginWork());
                String hours = beginTime.substring(0,2);
                String mm = beginTime.substring(3,5);
                String ss = beginTime.substring(6,8);
                String endBegintime = hours+":"+mm+":"+ss;
                String endTime = sdf2.format(signVO.getEndWork());
                String hour = endTime.substring(0,2);
                String mme = endTime.substring(3,5);
                String sse = endTime.substring(6,8);
                String time = hour+":"+mme+":"+sse;
                if (strDate.equals(signTime)) {
                    cellCheck.setCellStyle(cellStyle);
                    cellCheck = rowCheck.createCell(2);
                    cellCheck.setCellValue(signVO.getAttLocname());
                    cellCheck.setCellStyle(cellStyle);
                    cellCheck = rowCheck.createCell(4);
                    cellCheck.setCellValue(endBegintime+" ~ "+time);
                    cellCheck.setCellStyle(cellStyle);
                    cellCheck = rowCheck.createCell(5);
                    cellCheck.setCellValue(signVO.getTurnTime());
                    cellCheck.setCellStyle(cellStyle);
                    cellCheck = rowCheck.createCell(6);
                    cellCheck.setCellValue(signVO.getWorkTime());
                    cellCheck.setCellStyle(cellStyle);
                    cellCheck = rowCheck.createCell(7);
                    cellCheck.setCellValue(signVO.getOutTime());
                    cellCheck.setCellStyle(cellStyle);
                }
            }


            if(weekDay.substring(1,2).equals("六") || weekDay.substring(1,2).equals("日")){
                for(int j = 0; j<=13;j++){
                    if(rowCheck.getCell(j)==null){
                        rowCheck.createCell(j).setCellStyle(setStyle);
                    }else{
                        rowCheck.getCell(j).setCellStyle(setStyle);
                    }
                }
            }
            sheet.getRow(3).setHeightInPoints(30);
            sheet.getRow(4).setHeightInPoints(30);
            sheet.getRow(i).setHeightInPoints(30);

        }





        CellStyle fontCellStyleF = wb.createCellStyle();
        Font fontStyleF=wb.createFont();//字体
        fontStyle.setBold(true);
        fontCellStyleF.setFont(fontStyle);
        fontCellStyleF.setAlignment(HorizontalAlignment.CENTER);
        fontCellStyleF.setVerticalAlignment(VerticalAlignment.CENTER);

        int row5 = (int)(days+7);
        Row rowLabel2 = sheet.createRow(row5);
        CellRangeAddress region5 = new CellRangeAddress(row5,row5,0,1);
        sheet.addMergedRegion(region5);
        rowLabel2.createCell(0).setCellValue("出勤时间：(H)");
        rowLabel2.getCell(0).setCellStyle(fontCellStyleF);
        CellRangeAddress region6 = new CellRangeAddress(row5,row5,3,4);
        sheet.addMergedRegion(region6);
        rowLabel2.createCell(2).setCellValue(totalTimes);
        rowLabel2.getCell(2).setCellStyle(fontCellStyleF);
        rowLabel2.createCell(3).setCellValue("勤务外时间：(H)");
        rowLabel2.getCell(3).setCellStyle(fontCellStyleF);
        rowLabel2.createCell(5).setCellStyle(borderStyle);
        rowLabel2.createCell(6).setCellStyle(borderStyle);
        CellRangeAddress region7 = new CellRangeAddress(row5,row5,9,10);
        sheet.addMergedRegion(region7);
        rowLabel2.createCell(9).setCellValue("总务确认：");
        rowLabel2.getCell(9).setCellStyle(fontCellStyleF);
        rowLabel2.createCell(11).setCellStyle(borderStyle);
        rowLabel2.createCell(12).setCellStyle(borderStyle);
        CellRangeAddress region8 = new CellRangeAddress(row5,row5,11,13);
        sheet.addMergedRegion(region8);

        int rowFinal = (int)(days+8);
        Row rowLabel3 = sheet.createRow(rowFinal);
        CellRangeAddress region9 = new CellRangeAddress(rowFinal,rowFinal,0,1);
        sheet.addMergedRegion(region9);
        rowLabel3.createCell(0).setCellValue("加班时间：(日)");
        rowLabel3.getCell(0).setCellStyle(fontCellStyleF);
        CellRangeAddress region10 = new CellRangeAddress(rowFinal,rowFinal,3,4);
        sheet.addMergedRegion(region10);
        rowLabel3.createCell(3).setCellValue("休假：(日)");
        rowLabel3.getCell(3).setCellStyle(fontCellStyleF);
        rowLabel3.createCell(5).setCellStyle(borderStyle);
        rowLabel3.createCell(6).setCellStyle(borderStyle);
        CellRangeAddress region11 = new CellRangeAddress(rowFinal,rowFinal,9,10);
        sheet.addMergedRegion(region11);
        rowLabel3.createCell(9).setCellValue("最终确认：");
        rowLabel3.getCell(9).setCellStyle(fontCellStyleF);
        rowLabel3.createCell(11).setCellStyle(borderStyle);
        rowLabel3.createCell(12).setCellStyle(borderStyle);
        CellRangeAddress region12 = new CellRangeAddress(rowFinal,rowFinal,11,13);
        sheet.addMergedRegion(region12);

        /**
         * 页脚
         */

        setExcelFooterName(str.substring(0, 4)+str.substring(5, 7) , 0, wb);

        /**
         * 进行导出
         */
        Random random = new Random();
        int ends = random.nextInt(99);
        //exportOutPutExcel(new File("").getCanonicalPath()+"\\出勤表"+String.format("%02d",ends)+".xlsx", wb);
        //exportOutPutExcel("C:\\出勤表"+String.format("%02d",ends)+".xlsx", wb);
        exportOutPutExcel("C:\\出勤表"+attUserid+str.substring(0, 4)+str.substring(5, 7)+".xlsx", wb);
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
