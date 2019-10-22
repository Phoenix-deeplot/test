package com.kst.common.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 设置ip和端口号  建立通讯 读写器命令类
 */
public class RfidUtil{

    private String ip;//ip地址

    private int port;//端口号

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }


    Socket socket = null;
    InputStream in = null;
    OutputStream out = null;

    public RfidUtil() { }

    public RfidUtil(String ip, Integer port) {
        this.ip = ip;
        this.port = port;
        openSocket();
    }

    //socket 链接ip端口 打开通讯
    public void openSocket() {
        try {
            socket = new Socket(getIp(), getPort());
            in = socket.getInputStream();
            out = socket.getOutputStream();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //关闭链接
    public void closeSocket() throws IOException {
        //System.out.println("关闭连接:" + getIp() + ":" + getPort());
        in.close();
        out.close();
        socket.close();
    }

    //发送命令
    public byte[] sendCmd(String cmd) throws IOException {
        byte[] retBytes = new byte[]{};
        out.write(hexStrToBinaryStr(Crc16Util.getSendStr(cmd)));
        byte[] buf = new byte[1000];
        int length = in.read(buf);
        retBytes = transArray(buf, length);
        return retBytes;
    }

    /**
     * 查询多张标签
     *
     * @param adr     读写器地址
     * @param qValue  询查EPC标签时使用的初始Q值 Q值的设置应为场内的标签数量约等于2Q。Q值的范围为0～15
     * @param session 1个字节，询查EPC标签时使用的Session值 0x00：Session使用S0；0x01：Session使用S1；0x02：Session使用S2；0x03：Session使用S3。
     * @return
     * @throws IOException
     */
    public List<byte[]> selectSomeG2(String adr, byte qValue, byte session) throws IOException {
        String cmd = "06 " + adr + " 01 " + byteToHexString(qValue) + " " + byteToHexString(session);
        List<byte[]> labels = new ArrayList();
        byte[] bytes = sendCmd(cmd);
        Integer length = Integer.valueOf(bytes[5]);//查询到的标签数量
        int lastLength = 6;
        //System.out.println("查询到标签数量："+bytes[5]);
        for (int i = 0; i < length; i++) {
            int epcLength = bytes[lastLength];
            byte[] b = new byte[epcLength];
            System.arraycopy(bytes, lastLength + 1, b, 0, epcLength);
            labels.add(b);
            lastLength += epcLength + 2;
        }
        return labels;
    }

    //查询单张标签
    public byte[] selectOneG2(String adr) throws IOException {
        String cmd = "04 " + adr + " 0f";
        byte[] bytes = sendCmd(cmd);
        byte[] epc = new byte[0];
        if (bytes[3] == 1) {
            if (bytes[5] > 0) {
                epc = new byte[bytes[6]];
                System.arraycopy(bytes, 7, epc, 0, bytes[6]);
                //System.out.println("epc号  " + bytesToHexString(epc).replace(" ", ""));
            }
        }

        return epc;
    }

    /**
     * 读取标签里的数据
     *
     * @param adr     读写器地址
     * @param epc     标签epc号
     * @param mem     储存区号 0x00：保留区；0x01：EPC存储区；0x02：TID存储区；0x03：用户存储区
     * @param wordPtr 开始读取的位置
     * @param num     要读取的字个数
     * @return
     * @throws IOException
     */
    public String readData(String adr, byte[] epc, byte mem, byte wordPtr, byte num) throws IOException {
        String len = byteToHexString((byte) (12 + epc.length));
        String cmd = len + " " + adr + " 02 " + byteToHexString((byte) (epc.length / 2)) + " " + bytesToHexString(epc) + " " + byteToHexString(mem) + " " + byteToHexString(wordPtr) + " " + byteToHexString(num) + " 00 00 00 00";
        byte[] retBytes = new byte[num * 2];
        String ret = "";
        byte[] bytes = sendCmd(cmd);
        //System.out.println(bytesToHexString(bytes));
        if (bytes[3] == 0) {
            for (int i = 4; i < num + 4; i++) {
                retBytes[(i - 4) * 2] = bytes[(i - 4) * 2 + 4];
                retBytes[(i - 4) * 2 + 1] = bytes[(i - 4) * 2 + 4 + 1];
            }
        }

        ret = hexToString(retBytes);
        return ret;
    }

    /**
     * 写数据到 标签里
     *
     * @param epc     标签epc 号
     * @param word    要写入标签的字符 最大32位
     * @param mem     要写入的储存区  0x00：保留区；0x01：EPC存储区；0x02：TID存储区；0x03：用户存储区
     * @param wordPtr 写入数据起始位置
     */
    public boolean writeData(String adr, byte[] epc, String word, byte mem, byte wordPtr) throws IOException {
        byte[] wdt = stringToHex(word);
        String len = byteToHexString((byte) (12 + wdt.length + epc.length));
        String cmd = len + " " + adr + " 03 " + byteToHexString((byte) (wdt.length / 2)) + " " + byteToHexString((byte) (epc.length / 2)) +
                " " + bytesToHexString(epc).trim() + " " + byteToHexString(mem) + " " + byteToHexString(wordPtr) + " " + bytesToHexString(wdt).trim() + " 00 00 00 00";
        byte[] bytes = sendCmd(cmd);
        System.out.println(bytesToHexString(bytes));
        if (bytes[3] == 0) {
            return true;
        } else {
            return false;
        }
    }


    //获得读写器的信息 返回读写器地址
    public byte[] getReaderInformation() throws IOException {
        String cmd = "04 ff 21";
        byte[] bytes = sendCmd(cmd);
        return bytes;
    }

    //设置读写模块地址
    public byte[] setAddress(String adr) throws IOException {
        String cmd = "05 " + adr + " 24";
        byte[] bytes = sendCmd(cmd);
        return bytes;
    }

    //设置询查命令最大查询时间
    public byte[] setInventoryScanTime(String adr) throws IOException {
        String cmd = "05 " + adr + " 25 ";
        byte[] bytes = sendCmd(cmd);
        return bytes;
    }

    //设置波特率
    public byte[] setBaudrate(String adr, String baudrate) throws IOException {
        String cmd = "05 " + adr + " 28 " + baudrate;
        byte[] bytes = sendCmd(cmd);
        return bytes;
    }

    //设置读写器功率
    public byte[] setReaderPower(String adr, String pwr) throws IOException {
        String cmd = "05 " + adr + " 2f " + pwr;
        byte[] bytes = sendCmd(cmd);
        return bytes;
    }

    //设置蜂鸣器开关 0关 1开
    public byte[] setBeepNotification(String adr, String check) throws IOException {
        String cmd = "05 " + adr + " 40 " + check;
        byte[] bytes = sendCmd(cmd);
        return bytes;
    }

    //获取设备序列号
    public String getSeriaNo(String adr) throws IOException {
        String cmd = "04 " + adr + " 4c";
        String seriaNo = "";
        byte[] bytes = sendCmd(cmd);
        for (int i = 4; i <= 7; i++) {
            seriaNo += bytes[i];
        }
        return seriaNo;
    }

    //设置缓存的EPC/TID长度
    public int setSaveLen(String adr, String length) throws IOException {
        String cmd = "05 " + adr + " 70 " + length;
        byte[] bytes = sendCmd(cmd);
        return 0;
    }

    //获取缓存的EPC/TID长度
    public int getSaveLen(String adr) throws IOException {
        String cmd = "04 " + adr + " 71";
        byte[] bytes = sendCmd(cmd);
        return bytes[4];
    }

    //缓存数据获取
    public String getSaveData(String adr) throws IOException {
        String cmd = "04" + adr + " 72";
        byte[] bytes = sendCmd(cmd);
        return "";
    }

    //清除缓存数据
    public int cleanSaveData(String adr) throws IOException {
        String cmd = "04 " + adr + " 73";
        byte[] bytes = sendCmd(cmd);
        return 0;
    }

    //查询缓存区标签数量
    public int getSaveLabelCount(String adr) throws IOException {
        String cmd = "04 " + adr + "74";
        int boundcount = 0;
        byte[] re = new byte[2];
        byte[] bytes = sendCmd(cmd);
        re[0] = bytes[4];
        re[1] = bytes[5];
        return (int) re[1] | ((int) re[0] << 8);
    }


    //将长byte数组内的所有有效内容存到一个大小相等的数组内
    public byte[] transArray(byte[] bytes, int length) {
        byte[] ret = new byte[length];
        for (int i = 0; i < length; i++) {
            ret[i] = bytes[i];
        }
        return ret;
    }

    //将传递的命令转化为byte数组
    public byte[] hexStrToBinaryStr(String hexString) {
        if (StringUtils.isEmpty(hexString)) {
            return null;
        }
        hexString = hexString.replaceAll(" ", "");
        int len = hexString.length();
        int index = 0;
        byte[] bytes = new byte[len / 2];
        while (index < len) {
            String sub = hexString.substring(index, index + 2);
            bytes[index / 2] = (byte) Integer.parseInt(sub, 16);
            index += 2;
        }
        return bytes;
    }

    //byte数组转化为16进制字符串
    public String bytesToHexString(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            String hex = Integer.toHexString(0xFF & bytes[i]).toUpperCase();
            if (hex.length() == 1) {
                sb.append('0');
            }
            sb.append(hex + " ");
        }
        return sb.toString();
    }

    //byte转换为16进制字符串
    public String byteToHexString(byte b) {
        StringBuffer sb = new StringBuffer();
        String hex = Integer.toHexString(0xFF & b).toUpperCase();
        if (hex.length() == 1) {
            sb.append('0');
        }
        sb.append(hex);
        return sb.toString();
    }

    //将字符串转换为16进制 每个字符占两字节
    public byte[] stringToHex(String str) throws UnsupportedEncodingException {
        String[] c = str.split("");
        byte[] newBytes = new byte[str.length() * 2];
        for (int i = 0; i < c.length; i++) {
            byte[] bytes = c[i].getBytes("GBK");
            if (bytes.length > 1) {
                newBytes[i * 2] = bytes[0];
                newBytes[i * 2 + 1] = bytes[1];
            } else {
                newBytes[i * 2] = 0x00;
                newBytes[i * 2 + 1] = bytes[0];
            }
        }
        return newBytes;
    }

    //将16进制数据转换为String 每两个字节转换为一个字符
    public String hexToString(byte[] bytes) throws UnsupportedEncodingException {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < bytes.length / 2; i++) {
            byte[] temp = new byte[2];
            if (bytes[i * 2] == 0 && bytes[i * 2 + 1] == 0) {
                //该字符为空格
                sb.append(" ");
            } else if (bytes[i * 2] == 0 && bytes[i * 2 + 1] != 0) {
                sb.append(new String(new byte[]{bytes[i * 2 + 1]}, "GBK"));
            } else if (bytes[i * 2] != 0 && bytes[i * 2 + 1] != 0) {
                sb.append(new String(new byte[]{bytes[i * 2], bytes[i * 2 + 1]}, "GBK"));
            }
        }
        return sb.toString();
    }
}
