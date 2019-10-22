package com.kst.ams.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.common.collect.Lists;
import com.kst.ams.service.ISupplierService;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
//import com.kst.common.utils.QRCodeUtil;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.ams.entity.Supplier;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by zjf on 2019/06/03.
 *
 */
@Controller
@RequestMapping("ams/supplier")
public class SupplierController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(SupplierController.class);

    @Autowired
    private ISupplierService supplierService;

    @GetMapping("list")
    @SysLog("跳转系统用户列表页面")
    public String list(){
        return "supplier/list";
    }

    @RequiresPermissions("ams:supplier:list")
    @PostMapping("list")
    @ResponseBody
    public DataTable<Supplier> list(@RequestBody DataTable dt, ServletRequest request){
        return supplierService.pageSearch(dt);
    }

    @GetMapping("add")
    public String add(Model model){
        Supplier supplier = new Supplier();
        model.addAttribute("supplier",supplier);
        return "supplier/detail";
    }

    @RequiresPermissions("ams:supplier:add")
    @PostMapping("add")
    @ResponseBody
    @SysLog("保存供应商新增数据")
    public RestResponse add(@RequestBody Supplier supplier){
        supplierService.save(supplier);
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model){
        Supplier supplier = supplierService.getById(id);
        model.addAttribute("supplier",supplier);
        return "supplier/detail";
    }

    @RequiresPermissions("ams:supplier:edit")
    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存供应商编辑数据")
    public RestResponse edit(@RequestBody Supplier supplier){
        supplierService.updateById(supplier);
        return RestResponse.success();
    }


    @PostMapping("checkNameExist/{mode}")
    @ResponseBody
    @SysLog("供应商名称存在验证")
    public RestResponse checkNameExist(@PathVariable("mode") Integer mode, String name, Long id){
        boolean result = true;

        if (1 == mode) {    //新增场合
            if(supplierService.supplierCount("name",name)>0){
                result = false;
            }
        }else if (2 == mode) {  //编辑场合
            Supplier oldSupplier = supplierService.getById(id);
            if(StringUtils.isNotBlank(name)){
                if(!name.equals(oldSupplier.getName())){
                    if(supplierService.supplierCount("name",name)>0){
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @PostMapping("checkMailExist/{mode}")
    @ResponseBody
    @SysLog("邮箱地址存在验证")
    public RestResponse checkMailExist(@PathVariable("mode") Integer mode, String mail, Long id){
        boolean result = true;

        if (1 == mode) {    //新增场合
            if(supplierService.supplierCount("mail", mail)>0){
                result = false;
            }
        }else if (2 == mode) {  //编辑场合
            Supplier oldSupplier = supplierService.getById(id);
            if(StringUtils.isNotBlank(mail)){
                if(!mail.equals(oldSupplier.getMail())){
                    if(supplierService.supplierCount("mail", mail)>0){
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @PostMapping("checkTelExist/{mode}")
    @ResponseBody
    @SysLog("手机号码存在验证")
    public RestResponse checkTelExist(@PathVariable("mode") Integer mode, String tel, Long id){
        boolean result = true;

        if (1 == mode) {    //新增场合
            if(supplierService.supplierCount("tel", tel)>0){
                result = false;
            }
        }else if (2 == mode) {  //编辑场合
            Supplier oldSupplier = supplierService.getById(id);
            if(StringUtils.isNotBlank(tel)){
                if(!tel.equals(oldSupplier.getTel())){
                    if(supplierService.supplierCount("tel", tel)>0){
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @PostMapping("checkPhoneExist/{mode}")
    @ResponseBody
    @SysLog("手机号码存在验证")
    public RestResponse checkPhoneExist(@PathVariable("mode") Integer mode, String phone, Long id){
        boolean result = true;

        if (1 == mode) {    //新增场合
            if(supplierService.supplierCount("phone", phone)>0){
                result = false;
            }
        }else if (2 == mode) {  //编辑场合
            Supplier oldSupplier = supplierService.getById(id);
            if(StringUtils.isNotBlank(phone)){
                if(!phone.equals(oldSupplier.getPhone())){
                    if(supplierService.supplierCount("phone", phone)>0){
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @RequiresPermissions("ams:supplier:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除供应商数据(单个)")
    public RestResponse delete(@RequestParam(value = "id",required = false)Long id){
        if(id == null || id == 0 || id == 1){
            return RestResponse.failure("参数错误");
        }
        Supplier supplier = supplierService.getById(id);
        if(supplier == null){
            return RestResponse.failure("供应商不存在");
        }

        supplierService.deleteSupplier(supplier);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:supplier:delete")
    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("删除供应商数据(多个)")
    public RestResponse deleteSome(@RequestBody List<Supplier> suppliers){
        supplierService.deleteSupplier(suppliers);
        return RestResponse.success();
    }

    @PostMapping("selectSupplierList")
    @ResponseBody
    public List<Supplier> selectSupplierList(){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("del_flag",false);
        return this.supplierService.list(wrapper);
    }

}
