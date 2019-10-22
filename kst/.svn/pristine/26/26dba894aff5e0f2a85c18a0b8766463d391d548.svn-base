package com.kst.common.utils;

import com.kst.common.constant.Setting;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Date;
import java.util.List;

//输出文件工具类
public class DocumentOutUtils {

    /**
     * CSV文件生成方法
     * @param head
     * @param dataList
     * @return
     */
    public static File createCSVFile(List<Object> head, List<List<Object>> dataList) {
        File csvFile = null;
        BufferedWriter csvWtriter = null;
        try {
            csvFile = new File(Setting.BASEFLODER +"/temporary" + File.separator + FileUtils.createFileName() + ".csv");
            File parent = csvFile.getParentFile();
            if (parent != null && !parent.exists()) {
                parent.mkdirs();
            }
            csvFile.createNewFile();

            OutputStreamWriter osw=new OutputStreamWriter(new FileOutputStream(csvFile), "UTF-8");
            osw.write(new String(new byte[] { (byte) 0xEF, (byte) 0xBB,(byte) 0xBF }));
            // GB2312使正确读取分隔符","
            csvWtriter = new BufferedWriter(osw);
            // 写入文件头部
            writeRow(head, csvWtriter);

            // 写入文件内容
            for (List<Object> row : dataList) {
                writeRow(row, csvWtriter);
            }
            csvWtriter.flush();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                csvWtriter.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return csvFile;
    }

    /**
     * 写一行数据方法
     * @param row
     * @param csvWriter
     * @throws IOException
     */
    private static void writeRow(List<Object> row, BufferedWriter csvWriter) throws IOException {
        // 写入文件头部
        for (Object data : row) {
            StringBuffer sb = new StringBuffer();
            String rowStr = sb.append("\"").append(data).append("\",").toString();
            csvWriter.write(rowStr);
        }
        csvWriter.newLine();
    }

    /**
     * excel文件输出方法（本方法只适用于输出无样式的excel文件）
     * @param head 列头
     * @param dataList 数据
     * @param response
     * @param fileName 文件名
     */
    public static void createExcel(List<Object> head, List<List<Object>> dataList, HttpServletResponse response,String fileName){
        XSSFWorkbook wb=new XSSFWorkbook();
        XSSFSheet sheet= wb.createSheet("sheet1");

        XSSFRow row=sheet.createRow(0);
        writeExcelRow(head,row);

        for (int i=0;i<dataList.size();i++){
            XSSFRow r=sheet.createRow(i+1);
            writeExcelRow(dataList.get(i),r);
        }

        OutputStream os = null;
        try {
            os = response.getOutputStream();
            response.reset();
            response.setHeader("Content-disposition", "attachment;filename="+fileName+ new Date().getTime() + ".xlsx"); //定义下载的类型，标明是excel文件
            response.setContentType("application/vnd.ms-excel"); //这时候把创建好的excel写入到输出流
            wb.write(os);
            os.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //excel写入行内数据
    private static void writeExcelRow(List<Object> data, XSSFRow row){
        for (int i=0;i<data.size();i++){
            row.createCell(i).setCellValue(String.valueOf(data.get(i)));
        }

    }

}
