package com.kst.att.utils;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.att.entity.Sign;
import com.kst.att.service.ISignService;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IUserService;
import com.kst.sys.utils.RfidLabel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.*;

//循环查询RfidLabel（单例） 内的数据，判断是否为用户打卡数据 以此添加打卡数据到 att_sign
@Component
@Order(value = 2)
public class AttSignThread extends Thread implements ApplicationRunner {

    @Autowired
    private ISignService signService;

    @Autowired
    private IUserService userService;

    public AttSignThread() {
    }

    public AttSignThread(ISignService signService, IUserService userService) {
        this.signService = signService;
        this.userService = userService;
    }

    public void run() {
        while (true) {
            try {
                RfidLabel rfidLabel = RfidLabel.getSimpleCache();
                //查询所有临时数据
                Map<String, Object> map = rfidLabel.getAll();
                //keySet获取map集合key的集合  然后在遍历key即可

                List<Long> delId = new ArrayList<>();
                Set<Long> userId = new HashSet<>();
                for (String key : map.keySet()) {
                    String value = map.get(key).toString();//
                    System.out.println("key:" + key + " vlaue:" + value);
                    QueryWrapper wrapper = new QueryWrapper();
                    wrapper.eq("id", Long.parseLong(key));
                    User user = this.userService.getOne(wrapper);
                    if (user != null) {
                        delId.add(user.getId());//将该临时数据id保存
                        //如果这次循环已经添加过该用户，则不再添加该用户的数据
                        if (!userId.contains(user.getId())) {
                            userId.add(user.getId());
                            saveData(value, user);
                        }
                    }
                }
                //删除临时数据
                if (delId.size() > 0) {
                    for (Long d:delId){
                        rfidLabel.remove(String.valueOf(d));
                    }
                }
                rfidLabel.removeAllEpcs();
                Thread.sleep(5000);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }

    //保存数据到数据库
    public void saveData(String location, User user) {
        Sign sign = new Sign();
        sign.setAttUserid(user.getLoginName());
        sign.setAttSigntime(new Date());
        sign.setAttLocname(location);
        sign.setAttFlag("0");
        sign.setcreateBy(user.getLoginName());
        sign.setCreateDate(new Date());
        sign.setUpdateBy(user.getLoginName());
        sign.setUpdateDate(new Date());
        sign.setRemarks("");
        sign.setDelFlag(false);
        this.signService.insertSign(sign);
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        AttSignThread rfidThread = new AttSignThread(signService, userService);
        System.out.println("考勤系统监听线程启动！");
        rfidThread.start();
    }
}
