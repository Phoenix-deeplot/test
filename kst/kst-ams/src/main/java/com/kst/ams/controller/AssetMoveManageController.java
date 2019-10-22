package com.kst.ams.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.AssetInfo;
import com.kst.ams.entity.AssetMoveManager;
import com.kst.ams.entity.Location;
import com.kst.ams.service.IAssetInfoService;
import com.kst.ams.service.IAssetMoveManageService;
import com.kst.ams.service.ILocationService;
import com.kst.ams.vo.AssetMoveManageVO;
import com.kst.ams.vo.LocationVO;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IDictService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import java.util.*;

/**
 * Created by zjf on 2019/06/03.
 */
@Controller
@RequestMapping("ams/assetLocation")
public class AssetMoveManageController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetMoveManageController.class);
    @Autowired
    private IAssetMoveManageService assetMoveManageService;

    @Autowired
    private IAssetInfoService assetInfoService;

    @Autowired
    private ILocationService locationService;

    @Autowired
    private IDictService dictService;

//    @PostMapping("getLocationName")
//    public List getLocationName(@PathVariable("id") String id) {
//        return locationService.getLocationName(id);
//    }
    @GetMapping("list")
    @RequiresPermissions("ams:assetLocation:list")
    @SysLog("跳转资产转移列表页面")
    public String list(Model model) {
        List<LocationVO> list = locationService.getLocationName();
        List<AssetInfo> assetlist = assetInfoService.getAll();
        model.addAttribute("assetlist", assetlist);
        model.addAttribute("testType", list);
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_status");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> assetStatus = this.dictService.list(dictQueryWrapper);
        model.addAttribute("assetStatus",assetStatus);
        return "assetLocation/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<AssetMoveManageVO> list(@RequestBody DataTable dt, ServletRequest request) {
        DataTable<AssetMoveManageVO> list = this.assetMoveManageService.selectAssetMoveManagerList(dt);
        return list;
    }

    @GetMapping("add")
    public String add(Model model) {
        QueryWrapper<Dict> wrapper = new QueryWrapper<>();
        wrapper.eq("type", "ams_asset_type");
        wrapper.eq("del_flag",false);
        //题目类型
        List<Dict> assetType = this.dictService.list(wrapper);
        System.out.println("进入资产移动");

        AssetMoveManager assetMoveManager = new AssetMoveManager();
        assetMoveManager.setStorageDate(new Date());
        assetMoveManager.setRemoveDate(new Date());
        model.addAttribute("assetType",assetType);
        model.addAttribute("assetMoveManager", assetMoveManager);
        return "assetLocation/detail";
    }

    @RequiresPermissions("ams:assetLocation:add")
    @PostMapping("add")
    @ResponseBody
    @SysLog("保存资产转移新增数据")
    public RestResponse add(@RequestBody AssetMoveManager assetMoveManager) {
        assetMoveManager.setMoreInfo(assetMoveManager.getMoreInfo()+"[PC转移]");
        QueryWrapper wq=new QueryWrapper();
        wq.eq("del_flag",false);
        wq.isNull("delete_date");
        wq.eq("no",assetMoveManager.getNo());
        List<AssetMoveManager> moveList=assetMoveManageService.list(wq);
        for(AssetMoveManager move:moveList){
            move.setRemoveDate(assetMoveManager.getStorageDate());
            this.assetMoveManageService.updateById(move);
        }
        assetMoveManageService.save(assetMoveManager);
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("asset_input_no",assetMoveManager.getNo());
        AssetInfo assetInfo = this.assetInfoService.getOne(wrapper);
        assetInfo.setNo(assetMoveManager.getNo());
        assetInfo.setLocationId(assetMoveManager.getLocationId());
        assetInfoService.updateById(assetInfo);
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    public String edit(@PathVariable("id") String id, Model model) {
        Long applyId = Long.MIN_VALUE;
        Long locationId = Long.MIN_VALUE;
        if (id != null) {
            applyId = Long.parseLong(id.split("&")[0]);
            if ("root".equals(id.split("&")[1])){
                locationId = Long.MIN_VALUE;
            } else {
                if (id.split("&")[1] != null) {
                    locationId = Long.parseLong(id.split("&")[1]);
                } else {
                    locationId = Long.MIN_VALUE;
                }

            }

        }
        Location location = locationService.getLocationName(locationId);
        AssetMoveManager assetMoveManager = assetMoveManageService.getById(applyId);
        assetMoveManager.setStorageDate(new Date());
        if (location == null) {
            model.addAttribute("locationName", "-");
        } else {
            model.addAttribute("locationName", location.getName());
        }

        QueryWrapper wrapper1 = new QueryWrapper();
        wrapper1.eq("asset_input_no", assetMoveManager.getNo());
        AssetInfo assetInfo = this.assetInfoService.getOne(wrapper1);
        if (assetInfo != null) {
            model.addAttribute("assetName", assetInfo.getName());
        }

        model.addAttribute("location", location);
        model.addAttribute("assetMoveManager", assetMoveManager);
        return "assetLocation/detail";
    }

    @RequiresPermissions("ams:assetLocation:edit")
    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存资产转移编辑数据")
    public RestResponse edit(@RequestBody AssetMoveManager assetMoveManager) {
        assetMoveManageService.updateById(assetMoveManager);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:assetLocation:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除资产申请信息数据(单个)")
    public RestResponse delete(@RequestParam(value = "id", required = false) Long id) {
        if (id == null || id == 0 || id == 1) {
            return RestResponse.failure("参数错误");
        }
        AssetMoveManager assetMoveManager = assetMoveManageService.getById(id);
        if (assetMoveManager == null) {
            return RestResponse.failure("资产申请不存在");
        }
        assetMoveManageService.deleteAssetMoveManager(assetMoveManager);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:assetLocation:delete")
    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("删除资产申请信息数据(多个)")
    public RestResponse deleteSome(@RequestBody List<AssetMoveManager> assetMoveManagers) {
        assetMoveManageService.deleteAssetMoveManagers(assetMoveManagers);
        return RestResponse.success();
    }
}
