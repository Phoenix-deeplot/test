package com.kst.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.sys.api.entity.Calandar;
import com.kst.sys.api.service.ICalandarService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("sys/calandar")
public class CalandarController extends BaseController {
    @Autowired
    ICalandarService calandarService;
    @RequiresPermissions("sys:calandar:list")
    @GetMapping("list")
    public String list(){
        return "sys/calandar/list";
    }
    @PostMapping("list")
    @ResponseBody
    public DataTable<Calandar> list(@RequestBody DataTable dt){
        return this.calandarService.selectCalandarByPage(dt);  //pageSearch(dt);
    }
    @GetMapping("add")
    public String add(){
        return "sys/calandar/detail";
    }
    @PostMapping("add")
    @ResponseBody
    public RestResponse add(@RequestBody Calandar calandar){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("cal_date",new SimpleDateFormat("yyyy-MM-dd").format(calandar.getCalDate()));
        List<Calandar> calandars = this.calandarService.list(wrapper);
        if(calandars.size()==0){
            this.calandarService.save(calandar);
        }else{
            this.calandarService.update(calandar,wrapper);
        }
        return RestResponse.success();
    }
    @GetMapping("edit")
    public String edit(Model model, Long id){
        Calandar calandar = this.calandarService.selectCalandarById(id);
        model.addAttribute("calandar",calandar);
        return "calandar/detail";
    }
    @PostMapping("edit")
    @ResponseBody
    public RestResponse edit(@RequestBody Calandar calandar){
        this.calandarService.updateById(calandar);
        return RestResponse.success();
    }
    //删除日期信息
    @ResponseBody
    @PostMapping("deleteCal/{id}")
    public RestResponse deleteCal(@PathVariable("id") Long id){
        Calandar cal=this.calandarService.selectCalandarById(id);
        cal.setDelFlag(true);
        if(!this.calandarService.updateById(cal)){
            return RestResponse.failure("删除日期失败");
        }
        return RestResponse.success();
    }

    @ResponseBody
    @PostMapping("deleteCalSome")
    public RestResponse deleteQusSome(@RequestBody List<Calandar> calandars){
        for (Calandar c : calandars){
            c.setDelFlag(true);
            if(!this.calandarService.updateById(c)){
                return RestResponse.failure("删除日期失败");
            }
        }
        return RestResponse.success();
    }
}
