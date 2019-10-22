package com.kst.ams.utils;

import com.kst.common.utils.ServletUtils;
import com.kst.sys.utils.UHFUtil;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

public class TestAmsThread extends Thread {

    public void run(){

        while (true){
            UHFUtil uhfUtil=new UHFUtil();
            uhfUtil.conn("10.90.11.11",6000);
            try {
                List<String> list= uhfUtil.selectSomeLabel();
                if(list.size()>0){
                    System.out.println("资产查询条数："+list.size());
                }
                uhfUtil.closeConn();
                Thread.sleep(1000);
            } catch (IOException e) {
                e.printStackTrace();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        }
    }

}
