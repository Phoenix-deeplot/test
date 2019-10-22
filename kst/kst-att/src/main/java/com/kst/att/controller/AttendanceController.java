package com.kst.att.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.att.entity.AttLocation;
import com.kst.att.entity.Sign;
import com.kst.att.service.IAttLocationService;
import com.kst.att.service.ISignService;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.shiro.MySysUser;
import com.kst.common.utils.RestResponse;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IOrganizationService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;


@Controller
@RequestMapping("att/attendance")
public class AttendanceController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AttendanceController.class);
    @Autowired
    IOrganizationService organizationService;
    @Autowired
    ISignService iSignService;

    @Autowired
    private IAttLocationService attLocationService;

    @RequiresPermissions("att:attendance:list")
    @GetMapping("list")
    public String list(){
        return "attendance/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<User> list(@RequestBody DataTable dt) {

        dt.getSearchParams().put("loginName",MySysUser.loginName());
        this.organizationService.selectUserVOByPage(dt);
        return dt;
    }

    //进入考勤打卡页面
    @GetMapping("clockIn")
    public String clockingIn(Model model){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("del_flag",false);
        model.addAttribute("locations",this.attLocationService.list(wrapper));
        return "clockIn/list";
    }


    @PostMapping("clockIn")
    @ResponseBody
    public RestResponse clockingIn(Long id){
        AttLocation location=this.attLocationService.getById(id);
        Sign sign=new Sign();
        sign.setAttFlag("0");
        sign.setAttSigntime(new Date());
        sign.setAttUserid(MySysUser.loginName());
        sign.setAttLocname(location.getLocName());
        sign.setAttLatitude(location.getLatitude());
        sign.setAttLongitude(location.getLongitude());

        if(!this.iSignService.save(sign)){
            return RestResponse.failure("");
        }

        return RestResponse.success();
    }
}
