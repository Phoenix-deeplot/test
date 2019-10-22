package com.kst.sys.thread;

import com.kst.sys.utils.UHFUtil;

//测试读写器连接
public class TestConnection extends Thread {

    private String ip;

    private Integer port;

    private UHFUtil uhfUtil;

    private Boolean ret=true;

    public Boolean getRet() {
        return ret;
    }

    public void setRet(Boolean ret) {
        this.ret = ret;
    }

    public TestConnection(String ip, Integer port) {
        this.ip = ip;
        this.port = port;
    }

    public void run() {
        try {
            uhfUtil = new UHFUtil();
            uhfUtil.conn(ip, port);
            //查询读写器地址
            String adr = uhfUtil.getAdr();
            uhfUtil.closeConn();
            if (adr != null && adr != "") {
                System.out.println("地址：" + uhfUtil.getAdr());
            }else{
                ret=false;
            }
        }catch (Exception e){
            setRet(false);
        }
    }
}
