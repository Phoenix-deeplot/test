package com.kst.sys.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.common.utils.StringUtils;
import com.kst.sys.api.entity.Rfid;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IRfidService;
import com.kst.sys.api.service.IUserService;
import com.kst.sys.thread.SaveDataToRfid;
import com.kst.sys.thread.SelectRfid;
import com.kst.sys.thread.TestConnection;
import com.kst.sys.utils.UHFUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("sys/rfid")
public class RfidController {

    @Autowired
    private IRfidService rfidService;

    @Autowired
    private IUserService userService;

    @GetMapping("list")
    public String list() {
        return "sys/rfid/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<Rfid> list(@RequestBody DataTable dt) {
        this.rfidService.pageSearch(dt);
        return dt;
    }

    @GetMapping("add")
    public String add() {
        return "sys/rfid/detail";
    }

    @PostMapping("add")
    @ResponseBody
    public RestResponse add(@RequestBody Rfid rfid) {
        rfid.setUseflg(false);
        rfid.setCanuse(false);
        if (!this.rfidService.save(rfid)) {
            return RestResponse.failure("addFail");
        }
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    public String edit(Model model, @PathVariable("id") Long id) {
        Rfid rfid = rfidService.getById(id);
        model.addAttribute("rfid", rfid);
        return "sys/rfid/detail";
    }

    @PostMapping("edit")
    @ResponseBody
    public RestResponse edit(@RequestBody Rfid rfid) {
        if (!this.rfidService.updateById(rfid)) {
            return RestResponse.failure("editFail");
        }
        return RestResponse.success();
    }

    @PostMapping("delete")
    @ResponseBody
    public RestResponse delete(Long id) {
        Rfid rfid = this.rfidService.getById(id);
        rfid.setDelFlag(true);
        if (!this.rfidService.updateById(rfid)) {
            return RestResponse.failure("fail");
        }
        return RestResponse.success();
    }

    @PostMapping("deleteSome")
    @ResponseBody
    public RestResponse deleteSome(@RequestBody List<Rfid> rfids) {
        for (Rfid rfid : rfids) {
            rfid.setDelFlag(true);
            if (!this.rfidService.updateById(rfid)) {
                return RestResponse.failure("fail");
            }
        }
        return RestResponse.success();
    }

    //判断ip地址是否存在
    @PostMapping("checkIpExist/{mode}")
    @ResponseBody
    public RestResponse checkNameExist(@PathVariable("mode") Integer mode, String ip, Long id) {
        boolean result = true;
        QueryWrapper wrapper = new QueryWrapper();
        System.out.println("ip地址" + ip);
        wrapper.eq("rfid_ip", ip);
        if (1 == mode) {    //新增场合
            if (this.rfidService.count(wrapper) > 0) {
                result = false;
            }
        } else if (2 == mode) {  //编辑场合
            Rfid rfid = this.rfidService.getById(id);
            if (StringUtils.isNotBlank(ip)) {
                if (!ip.equals(rfid.getIp())) {
                    if (rfidService.count(wrapper) > 0) {
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    //测试连接
    @PostMapping("testConnection")
    @ResponseBody
    public RestResponse testConnection(@RequestBody Rfid rfid) {
        try {
            TestConnection conn = new TestConnection(rfid.getIp(), rfid.getCom());
            conn.start();
            conn.join();
            if(!conn.getRet()){
                return RestResponse.failure("fail");
            }
            conn.interrupt();
        } catch (Exception e) {
            e.printStackTrace();
            return RestResponse.failure("fail");
        }
        return RestResponse.success();
    }

    //进入选择电子标签页面
    @GetMapping("choiceRfid/{userIds}")
    public String testName(@PathVariable("userIds") String userIds, Model model) {
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.in("id", userIds.split(","));
        List<User> users = this.userService.list(wrapper);
        wrapper = new QueryWrapper();
        wrapper.eq("del_flag", false);
        wrapper.eq("rfid_canuse", true);
        wrapper.eq("rfid_useflg", false);
        List<Rfid> rfids = this.rfidService.list(wrapper);
        model.addAttribute("users", users);
        model.addAttribute("rfids", rfids);
        return "sys/rfid/rfidSet";
    }

    //查询电子标签
    @PostMapping("selectRfid")
    @ResponseBody
    public Set<String> selectRfid(@RequestBody Rfid rfid) {
        Set<String> epc = new HashSet<>();
        try {
            SelectRfid conn = new SelectRfid(rfid.getIp(), rfid.getCom());
            conn.start();
            conn.join();
            epc = conn.getEpcs();
            conn.interrupt();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return epc;
    }

    //保存数据到电子标签
    @PostMapping("saveDataToRfid")
    @ResponseBody
    public RestResponse saveDataToRfid(@RequestBody Rfid rfid) {
        System.out.println("传递数据" + JSON.toJSONString(rfid.getData()));
        try {
            SaveDataToRfid saveDataToRfid = new SaveDataToRfid(rfid.getIp(), rfid.getCom(), rfid);
            saveDataToRfid.start();
            saveDataToRfid.join();
            if(saveDataToRfid.getRet()<rfid.getData().size()){
                return RestResponse.failure("fail");
            }
            saveDataToRfid.interrupt();
        } catch (Exception e) {
            e.printStackTrace();
            return RestResponse.failure("fail");
        }
        return RestResponse.success();
    }

}
