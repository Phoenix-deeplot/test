package com.kst.sys.thread;

import com.kst.sys.api.entity.Rfid;
import com.kst.sys.utils.UHFUtil;

import java.io.IOException;
import java.util.Map;

public class SaveDataToRfid extends Thread {

    private String ip;

    private Integer port;

    private Rfid rfid;

    private int ret = 0;

    public int getRet() {
        return ret;
    }

    public void setRet(int ret) {
        this.ret = ret;
    }

    public Rfid getRfid() {
        return rfid;
    }

    public void setRfid(Rfid rfid) {
        this.rfid = rfid;
    }

    public SaveDataToRfid(String ip, Integer port, Rfid rfid) {
        this.ip = ip;
        this.port = port;
        this.setRfid(rfid);
    }

    public void run() {
        UHFUtil uhfUtil = new UHFUtil();
        uhfUtil.conn(ip, port);
        //查询读写器地址
        String adr = uhfUtil.getAdr();
        try {
            int oldPower=uhfUtil.getReaderPower();
            //将功率设定为5pdm 方便写数据（功率太高写数据会失败）
            uhfUtil.setReaderPower(5);
            for (Map<String, Object> param : rfid.getData()) {
                for (int i = 0; i < 3; i++) {
                    if (uhfUtil.saveDataToRfid((String) param.get("word"), (String) param.get("epc"))) {
                        System.out.println("保存数据成功");
                        ret+=1;
                        break;
                    } else {
                        System.out.println("保存数据失败");
                    }
                }
            }
            uhfUtil.setReaderPower(oldPower);
            uhfUtil.closeConn();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
