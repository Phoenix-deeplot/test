package com.kst.sys.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.ModulePara;
import com.kst.sys.api.service.IDictService;
import com.kst.sys.api.service.IModuleParaService;
import com.kst.sys.api.vo.ModuleVO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.xpath.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("sys/module")
public class ModuleController {

    @Autowired
    private IModuleParaService moduleParaService;

    @Autowired
    private IDictService dictService;

    @GetMapping("list")
    public String list(Model model){
        return "sys/module/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<ModuleVO> list(){
        DataTable dt=new DataTable();
        System.out.println("进入查询模块信息");
        QueryWrapper wrapper=new QueryWrapper();
        List<ModuleVO> list=new ArrayList<>();
        wrapper.eq("para_id","moduleData");
        ModulePara modulePara=this.moduleParaService.getOne(wrapper);

        wrapper=new QueryWrapper();
        wrapper.eq("type","kst_module");
        wrapper.eq("del_flag",false);
        List<Dict> dicts=this.dictService.list(wrapper);
        if(modulePara!=null){
            JSONObject jsonObject=JSONObject.fromObject(modulePara.getParaJson());
            Map<String,String> map=jsonObject;
            for (Dict dict:dicts){
                String val=map.get(dict.getValue());
                if(val!=""){
                    boolean useFlag=false;
                    if(val.equals("1")){
                        useFlag=true;
                    }
                    ModuleVO module=new ModuleVO(dict.getLabel(),dict.getValue(),useFlag);
                    list.add(module);
                }else{
                    System.out.println("为空");
                }
            }
        }
        dt.setRows(list);
        return dt;
    }

    @PostMapping("editModule")
    @ResponseBody
    public RestResponse editModule(@RequestBody ModuleVO moduleVO){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("para_id","moduleData");
        ModulePara modulePara=this.moduleParaService.getOne(wrapper);
        JSONObject jsonObject=JSONObject.fromObject(modulePara.getParaJson());
        Map<String,String> map=jsonObject;
        String val="0";
        if(moduleVO.getUseFlag()){
            val="1";
        }
        map.put(moduleVO.getModuleNo(),val);
        modulePara.setParaJson(JSON.toJSONString(map));
        if(!this.moduleParaService.updateById(modulePara)){
            return RestResponse.failure("fail");
        }
        return RestResponse.success();
    }

    @PostMapping("getModuleUseFlag")
    @ResponseBody
    public boolean getModuleUseFlag(String moduleNo){
        return this.moduleParaService.getModuleUseFlag(moduleNo);
    }


}
