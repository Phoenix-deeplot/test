package com.kst.sys.utils;


import com.kst.common.utils.RfidUtil;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

//后台 对读写器操作类
public class UHFUtil {


    private String adr;

    RfidUtil rfidUtil;

    public UHFUtil() {

    }

    public String getAdr() {
        return adr;
    }

    public void setAdr(String adr) {
        this.adr = adr;
    }

    //连接
    public void conn(String ip, Integer port) {

        try {
            //构建对象，连接socket
            rfidUtil = new RfidUtil(ip, port);
            //获取读写器地址
            this.setAdr(getReaderAdr());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //关闭连接
    public void closeConn() {
        try {
            rfidUtil.closeSocket();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //监听socket
    public void listenSocket() throws IOException {
        while (true) {
            this.searchOneLabelData();
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    //查询标签(一张)，并且读取数据
    public String searchOneLabelData() throws IOException {
        String ret = "";
        byte[] epc = rfidUtil.selectOneG2(this.getAdr());
        if (epc.length > 0) {
            //如果查询到了标签
            String str = rfidUtil.readData(this.adr, epc, (byte) 3, (byte) 0, (byte) 32);
            ret = str.trim();
        }
        return ret;
    }

    //查询多个标签，返回标签内的数据
    public Set<String> selectSomeLabelData() throws IOException {
        RfidLabel rfidLabel = RfidLabel.getSimpleCache();

        Set<String> datas = new HashSet<>();
        //查找标签的时候关闭蜂鸣器
        Set<byte[]> epcs = new HashSet<>();
        List<byte[]> list = rfidUtil.selectSomeG2(this.getAdr(), (byte) 3, (byte) 0);
        for (byte[] b : list) {
            //System.out.println("搜索到标签");
            epcs.add(b);
        }
        //查找完成后打开蜂鸣器
        if (epcs.size() > 0) {
            for (byte[] epc : epcs) {
                String r=rfidUtil.bytesToHexString(epc);
                if (!rfidLabel.isConstainsEpcs(r)) {
                    //根据epc号读取标签数据
                    setBeepNotification("01");
                    String data = rfidUtil.readData(this.adr, epc, (byte) 3, (byte) 0, (byte) 32).trim();
                    setBeepNotification("00");
                    if (data != null && !data.equals("")) {
                        rfidLabel.setEpcs(r);
                        datas.add(data);
                    }
                }
            }
        }
        return datas;
    }

    //查询多个标签，返回标签epc号
    public List<String> selectSomeLabel() throws IOException {
        List<byte[]> list = rfidUtil.selectSomeG2(this.getAdr(), (byte) 3, (byte) 0);
        List<String> epcs = new ArrayList<>();
        for (byte[] epc : list) {
            epcs.add(rfidUtil.bytesToHexString(epc).replace(" ", ""));
        }
        return epcs;
    }

    //保存数据到rfid里
    public boolean saveDataToRfid(String word, String epc) throws IOException {
        System.out.println(rfidUtil.hexStrToBinaryStr(epc));
        return this.rfidUtil.writeData(this.getAdr(), rfidUtil.hexStrToBinaryStr(epc), String.format("%-20s", word), (byte) 3, (byte) 0);
    }

    //获取读写器地址
    public String getReaderAdr() throws IOException {
        byte[] bytes = this.rfidUtil.getReaderInformation();
        String ret = "";
        if (bytes[3] == 0) {
            ret = rfidUtil.byteToHexString(bytes[1]);
        }
        return ret;
    }

    //获取读写器功率
    public int getReaderPower() throws IOException {
        byte[] bytes = this.rfidUtil.getReaderInformation();
        int ret = -1;
        if (bytes[3] == 0) {
            ret = bytes[10];
        }
        System.out.println(this.rfidUtil.bytesToHexString(bytes));
        return ret;
    }

    //设置蜂鸣器开关 "00" 关 "01"开
    public boolean setBeepNotification(String check) throws IOException {
        byte[] bytes = rfidUtil.setBeepNotification(this.getAdr(), check);
        boolean ret = false;
        if (bytes[3] == 0) {
            ret = true;
        }
        return ret;
    }

    //设置读写器功率
    public boolean setReaderPower(int power) throws IOException {
        boolean ret = false;
        byte[] bytes = this.rfidUtil.setReaderPower(this.getAdr(), rfidUtil.byteToHexString((byte) power));
        System.out.println(rfidUtil.bytesToHexString(bytes));
        if (bytes[3] == 0) {
            ret = true;
        }
        return ret;
    }

    public static void main(String[] args) {
        UHFUtil uhfUtil = new UHFUtil();
        uhfUtil.conn("10.90.11.11", 6000);
        try {
            System.out.println("前功率：" + (byte) uhfUtil.getReaderPower());
            System.out.println(uhfUtil.setReaderPower(5));
            System.out.println("后功率：" + (byte) uhfUtil.getReaderPower());
        } catch (IOException e) {
            e.printStackTrace();
        }
        uhfUtil.closeConn();
    }

}
