package com.kst.sys.thread;

import com.kst.sys.utils.UHFUtil;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class SelectRfid extends Thread {

    private String ip;

    private Integer port;

    private Set<String> epcs;

    public Set<String> getEpcs() {
        return epcs;
    }

    public void setEpcs(Set<String> epcs) {
        this.epcs = epcs;
    }

    public SelectRfid(String ip, Integer port) {
        this.ip = ip;
        this.port = port;
    }

    public void run() {
        UHFUtil uhfUtil = new UHFUtil();
        uhfUtil.conn(ip, port);
        //查询读写器地址
        //String adr = uhfUtil.getAdr();
        epcs=new HashSet<>();
        try {
            for (int i=0;i<3;i++){
                List<String> strs=uhfUtil.selectSomeLabel();
                for (String e:strs){
                    epcs.add(e);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
