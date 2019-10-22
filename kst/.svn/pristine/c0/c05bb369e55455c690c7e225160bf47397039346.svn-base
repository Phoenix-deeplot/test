package com.kst.ams.utils;

import com.kst.common.utils.ServletUtils;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;


//@Component
//@Order(value = 2)
public class TestListener implements ApplicationRunner {

    @Override
    public void run(ApplicationArguments args) throws Exception {
        System.out.println("资产测试读写器启动！");
        TestAmsThread testAmsThread=new TestAmsThread();
        testAmsThread.start();
        System.out.println("结束Ams");
    }
}
