package com.kst.ams.controller;

import com.kst.ams.entity.AssetInfo;
import com.kst.ams.entity.AssetMoveManager;
import com.kst.ams.entity.AssetMoveOutManager;
import com.kst.ams.service.IAssetInfoService;
import com.kst.ams.service.IAssetMoveManageService;
import com.kst.ams.service.IAssetMoveOutManageService;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import java.util.List;

/**
 * Created by zjf on 2019/06/03.
 */
@Controller
@RequestMapping("ams/assetOutLocation")
public class AssetMoveOutManageController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetMoveOutManageController.class);
    @Autowired
    private IAssetMoveOutManageService assetMoveOutManageService;

    @Autowired
    private IAssetInfoService assetInfoService;

    @GetMapping("list")
    @SysLog("跳转资产转移列表页面")
    public String list(Model model) {
        List<AssetInfo> asssetInfoList = assetInfoService.getAll();
        model.addAttribute("assetlist", asssetInfoList);
        return "assetOutLocation/list";
    }

    @RequiresPermissions("ams:assetOutLocation:list")
    @PostMapping("list")
    @ResponseBody
    public DataTable<AssetMoveOutManager> list(@RequestBody DataTable dt, ServletRequest request) {
        return assetMoveOutManageService.pageSearch(dt);
    }

    @GetMapping("add")
    public String add(Model model) {
        AssetMoveOutManager AssetMoveOutManager = new AssetMoveOutManager();
        model.addAttribute("AssetMoveOutManager", AssetMoveOutManager);
        return "assetOutLocation/detail";
    }

    @RequiresPermissions("ams:assetOutLocation:add")
    @PostMapping("add")
    @ResponseBody
    @SysLog("保存资产转移新增数据")
    public RestResponse add(@RequestBody AssetMoveOutManager assetMoveOutManager) {
        assetMoveOutManageService.save(assetMoveOutManager);
        AssetInfo assetInfo = new AssetInfo();
        assetInfo.setNo(assetMoveOutManager.getNo());
        assetInfo.setLocationId(assetMoveOutManager.getLocationId());
        assetInfoService.updateById(assetInfo);
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model) {
        AssetMoveOutManager assetMoveOutManager = assetMoveOutManageService.getById(id);
        model.addAttribute("assetMoveOutManager", assetMoveOutManager);
        return "assetOutLocation/detail";
    }

    @RequiresPermissions("ams:assetOutLocation:edit")
    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存资产转移编辑数据")
    public RestResponse edit(@RequestBody AssetMoveOutManager assetMoveOutManager) {
        assetMoveOutManageService.updateById(assetMoveOutManager);
        return RestResponse.success();
    }

//    @PostMapping("checkNoExist/{mode}")
//    @ResponseBody
//    @SysLog("资产编号存在验证")
//    public RestResponse checkNoExist(@PathVariable("mode") Integer mode, String No, Long id){
//        boolean result = true;
//
//        if (1 == mode) {    //新增场合
//            if(assetApplyService.assetApplyCount("name",name)>0){
//                result = false;
//            }
//        }else if (2 == mode) {  //编辑场合
//            AssetApply oldAssetInfo = assetApplyService.getById(id);
//            if(StringUtils.isNotBlank(name)){
//                if(!name.equals(oldAssetInfo.getNo())){
//                    if(assetApplyService.assetApplyCount("name",name)>0){
//                        result = false;
//                    }
//                }
//            }
//        }
//        RestResponse restResponse = new RestResponse();
//        restResponse.put("valid", result);
//        return restResponse;
//    }
//
////    @PostMapping("checkMailExist/{mode}")
////    @ResponseBody
////    @SysLog("邮箱地址存在验证")
////    public RestResponse checkMailExist(@PathVariable("mode") Integer mode, String mail, Long id){
////        boolean result = true;
////
////        if (1 == mode) {    //新增场合
////            if(supplierService.supplierCount("mail", mail)>0){
////                result = false;
////            }
////        }else if (2 == mode) {  //编辑场合
////            Supplier oldSupplier = supplierService.getById(id);
////            if(StringUtils.isNotBlank(mail)){
////                if(!mail.equals(oldSupplier.getMail())){
////                    if(supplierService.supplierCount("mail", mail)>0){
////                        result = false;
////                    }
////                }
////            }
////        }
////        RestResponse restResponse = new RestResponse();
////        restResponse.put("valid", result);
////        return restResponse;
////    }
////
////    @PostMapping("checkTelExist/{mode}")
////    @ResponseBody
////    @SysLog("手机号码存在验证")
////    public RestResponse checkTelExist(@PathVariable("mode") Integer mode, String tel, Long id){
////        boolean result = true;
////
////        if (1 == mode) {    //新增场合
////            if(supplierService.supplierCount("tel", tel)>0){
////                result = false;
////            }
////        }else if (2 == mode) {  //编辑场合
////            Supplier oldSupplier = supplierService.getById(id);
////            if(StringUtils.isNotBlank(tel)){
////                if(!tel.equals(oldSupplier.getTel())){
////                    if(supplierService.supplierCount("tel", tel)>0){
////                        result = false;
////                    }
////                }
////            }
////        }
////        RestResponse restResponse = new RestResponse();
////        restResponse.put("valid", result);
////        return restResponse;
////    }
////
////    @PostMapping("checkPhoneExist/{mode}")
////    @ResponseBody
////    @SysLog("手机号码存在验证")
////    public RestResponse checkPhoneExist(@PathVariable("mode") Integer mode, String phone, Long id){
////        boolean result = true;
////
////        if (1 == mode) {    //新增场合
////            if(supplierService.supplierCount("phone", phone)>0){
////                result = false;
////            }
////        }else if (2 == mode) {  //编辑场合
////            Supplier oldSupplier = supplierService.getById(id);
////            if(StringUtils.isNotBlank(phone)){
////                if(!phone.equals(oldSupplier.getPhone())){
////                    if(supplierService.supplierCount("phone", phone)>0){
////                        result = false;
////                    }
////                }
////            }
////        }
////        RestResponse restResponse = new RestResponse();
////        restResponse.put("valid", result);
////        return restResponse;
////    }
//
    @RequiresPermissions("ams:assetOutLocation:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除资产申请信息数据(单个)")
    public RestResponse delete(@RequestParam(value = "id", required = false) Long id) {
        if (id == null || id == 0 || id == 1) {
            return RestResponse.failure("参数错误");
        }
        AssetMoveOutManager assetMoveOutManager = assetMoveOutManageService.getById(id);
        if (assetMoveOutManager == null) {
            return RestResponse.failure("资产申请不存在");
        }
        assetMoveOutManageService.deleteAssetMoveManager(assetMoveOutManager);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:assetOutLocation:delete")
    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("删除资产申请信息数据(多个)")
    public RestResponse deleteSome(@RequestBody List<AssetMoveOutManager> assetMoveOutManagers) {
        assetMoveOutManageService.deleteAssetMoveManagers(assetMoveOutManagers);
        return RestResponse.success();
    }
}
