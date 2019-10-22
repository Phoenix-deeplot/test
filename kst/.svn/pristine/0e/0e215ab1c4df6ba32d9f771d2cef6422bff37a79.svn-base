package com.kst.sys.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("sys/druid")
public class DruidController {

    @RequiresPermissions("sys:druid:list")
    @GetMapping("list")
    public String index(){
        return "sys/druid/index";
    }
}
