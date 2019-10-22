package com.kst.sys.controller;

import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.vo.DictVO;
import com.kst.sys.api.service.IDictService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import java.util.List;


@Controller
@RequestMapping("sys/dict")
public class DictController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(DictController.class);

    @Autowired
    private IDictService dictService;

    @GetMapping("list")
    @RequiresPermissions("sys:dict:list")
    @SysLog("跳转系统系统字典列表页面")
    public String list(){
        return "sys/dict/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<User> list(@RequestBody DataTable dt, ServletRequest request){
        return dictService.pageSearch(dt);
    }

    //添加窗口
    @GetMapping("add")
    public String add(Model model){
        DictVO vo=new DictVO();
        vo.setSort(null);
        model.addAttribute("dict",vo);
        return "sys/dict/detail";
    }

    //添加TYPE
    @RequiresPermissions("sys:dict:add")
    @GetMapping("addType")
    public String addType(Model model){
        DictVO vo=new DictVO();
        vo.setSort(null);
        model.addAttribute("dict",vo);
        return "sys/dict/typeInfo";
    }

    @PostMapping("add")
    @ResponseBody
    @SysLog("保存新增系统字典数据")
    public RestResponse add(@RequestBody DictVO dict){
        dictService.saveOrUpdateDict(dict);
        if(dict.getId() == null || dict.getId() == 0){
            return RestResponse.failure("保存系统字典出错");
        }
        return RestResponse.success();
    }

    @PostMapping("addType")
    @ResponseBody
    @SysLog("保存新增系统字典数据")
    public RestResponse addType(@RequestBody DictVO dict){
        dictService.saveOrUpdateDict(dict);
        if(dict.getId() == null || dict.getId() == 0){
            return RestResponse.failure("保存类型出错");
        }
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model){
        Dict dict=this.dictService.selectDictById(id);
        model.addAttribute("dict",dict);
        return "sys/dict/detail";
    }

    @RequiresPermissions("sys:dict:edit")
    @GetMapping("editType/{id}")
    public String editType(@PathVariable("id") Long id, Model model){
        Dict dict=this.dictService.selectDictById(id);
        model.addAttribute("dict",dict);
        return "sys/dict/typeInfo";
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存系统字典编辑数据")
    public RestResponse edit(@RequestBody Dict dict){
        dictService.updateById(dict);
        return RestResponse.success();
    }

    @PostMapping("editType")
    @ResponseBody
    @SysLog("保存TYPE数据")
    public RestResponse editType(@RequestBody DictVO dict){
        dictService.updateByType(dict.getOldType(),dict.getType());
        return RestResponse.success();
    }

    @RequiresPermissions("sys:dict:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除系统字典数据(单个)")
    public RestResponse delete(@RequestParam(value = "id",required = false)Long id){
        dictService.deleteDict(id);
        return RestResponse.success();
    }

    @RequiresPermissions("sys:dict:delete")
    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("删除系统字典数据(多个)")
    public RestResponse deleteSome(@RequestBody List<Dict> dicts){
        for (Dict d : dicts){
            dictService.deleteDict(d.getId());
        }
        return RestResponse.success();
    }

    @PostMapping("checkTypeExist/{mode}")
    @ResponseBody
    @SysLog("TYPE存在验证")
    public RestResponse checkTypeExist(@PathVariable("mode") Integer mode, String type, Long id){
        boolean result = true;

        if (1 == mode) {    //新增场合
            if(dictService.getCountByType(type)>0){
                result = false;
            }
        }else if (2 == mode) {  //编辑场合
            if(StringUtils.isNotBlank(type)){
                if(dictService.getCountByType(type)>0){
                    result = false;
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }
}
