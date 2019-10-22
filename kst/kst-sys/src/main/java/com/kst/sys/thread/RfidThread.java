package com.kst.sys.thread;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.sys.api.entity.Rfid;
import com.kst.sys.api.service.IModuleParaService;
import com.kst.sys.api.service.IRfidService;
import com.kst.sys.utils.RfidLabel;
import com.kst.sys.utils.UHFUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;

@Component
@Order(value = 1)
/**
 * 项目启动的时候启动，新建一个线程，
 * 在线程中循环搜索标签，搜索到了标签后将标签数据添加到sys_rfid_tempData
 */
public class RfidThread extends Thread implements ApplicationRunner {

    @Autowired
    private IRfidService rfidService;

    @Autowired
    private IModuleParaService moduleParaService;

    private Rfid rfid;

    public RfidThread() { }

    public RfidThread(Rfid rfid) {
        this.rfid=rfid;
    }

    public void run() {
        while (true) {
            try {
            UHFUtil uhfUtil = new UHFUtil();
            uhfUtil.conn(this.rfid.getIp(), this.rfid.getCom());

                Set<String> data = uhfUtil.selectSomeLabelData();
                if (data.size()>0) {
                    for (String d:data){
                        saveData(d);
                    }
                    System.out.println();
                }

                Thread.sleep(100);
                uhfUtil.closeConn();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    //保存读卡数据
    public void saveData(String data) {
        System.out.println("查询到数据："+data);
        RfidLabel rfidLabel=RfidLabel.getSimpleCache();
        rfidLabel.put(data,rfid.getLocation());
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        if(this.moduleParaService.getModuleUseFlag("module03") || this.moduleParaService.getModuleUseFlag("module06")){
            System.out.println("查找读卡器设备，打开socket连接");
            QueryWrapper wrapper=new QueryWrapper();
            wrapper.eq("del_flag",false);
            wrapper.eq("rfid_canuse",true);
            wrapper.eq("rfid_useflg",true);
            List<Rfid> list=this.rfidService.list(wrapper);

            for (Rfid rfid:list){
                System.out.println("打开ip："+rfid.getIp()+"端口："+rfid.getCom());
                RfidThread rfidThread=new RfidThread(rfid);
                rfidThread.start();
            }
        }

    }
}
