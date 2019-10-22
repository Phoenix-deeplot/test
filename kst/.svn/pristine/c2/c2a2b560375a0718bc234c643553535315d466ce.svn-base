package com.kst.ams.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.*;
import com.kst.ams.service.*;
import com.kst.ams.vo.AssetApplyVO;
import com.kst.ams.vo.LocationVO;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IDictService;
import com.kst.sys.api.service.IUserService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import java.util.*;

/**
 * Created by zjf on 2019/06/03.
 */
@Controller
@RequestMapping("ams/apply")
public class AssetApplyController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetApplyController.class);
    @Autowired
    private IAssetApplyService assetApplyService;

    @Autowired
    private IAssetInfoService assetInfoService;

    //移动履历管理
    @Autowired
    private IAssetMoveManageService assetMoveManageService;

    @Autowired
    private ILocationService locationService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IDictService dictService;

    @Autowired
    private IAssetTakeOutService takeOutService;

    public static final String ROOT = "root";
    @GetMapping("list")
    @RequiresPermissions("ams:apply:list")
    @SysLog("跳转资产申请列表页面")
    public String list(Model model) {
        List<AssetInfo> list = assetInfoService.getAll();
        List<User> userList = userService.list();
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_apply_status");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> assetStatus = this.dictService.list(dictQueryWrapper);
        model.addAttribute("assetStatus",assetStatus);
        model.addAttribute("testType", list);
        model.addAttribute("userList", userList);
        return "apply/list";
    }


    @PostMapping("list")
    @ResponseBody
    public DataTable<AssetApplyVO> list(@RequestBody DataTable dt, ServletRequest request) {
        return assetApplyService.selectAssetApplysList(dt);
    }

    @GetMapping("add")
    public String add(Model model) {
        QueryWrapper wrapper3=new QueryWrapper<>();
        wrapper3.eq("type","ams_asset_type");
        wrapper3.eq("del_flag",false);
        List<Dict> dicts=this.dictService.list(wrapper3);
        model.addAttribute("assetType",dicts);

        AssetApply assetApply = new AssetApply();
        assetApply.setApplyDate(new Date());
        model.addAttribute("apply", assetApply);
        return "apply/detail";
    }

    @RequiresPermissions("ams:apply:add")
    @PostMapping("add")
    @ResponseBody
    @SysLog("保存资产申请新增数据")
    public RestResponse add(@RequestBody AssetApply assetApply,@RequestParam(value = "id", required = false) Long id,@RequestParam(value = "locationId", required = false) String locationId,@RequestParam(value = "applyId", required = false) String applyId) {
        //保存资产领用表
        assetApply.setMoreInfo(assetApply.getMoreInfo()+"[PC领用]");
        System.out.println("申请日期"+assetApply.getApplyDate());
        assetApplyService.save(assetApply);
        //applyId
        AssetInfo info = this.assetInfoService.getById(id);
        info.setLocationId(locationId);
        info.setApplyUserid(applyId);
        info.setStatusProperty("2");
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.isNull("DELETE_DATE");
        wrapper.eq("no",assetApply.getNo());
        AssetMoveManager oldAssetMove=this.assetMoveManageService.getOne(wrapper);
        if(oldAssetMove!=null){
            oldAssetMove.setRemoveDate(new Date());
            this.assetMoveManageService.updateById(oldAssetMove);
        }

        AssetMoveManager assetMoveManager = new AssetMoveManager();
        assetMoveManager.setNo(assetApply.getNo());
        assetMoveManager.setLocationId(locationId);
        assetMoveManager.setStorageDate(new Date());
        assetMoveManager.setMoreInfo("[PC领用]");
        assetMoveManageService.save(assetMoveManager);
        assetInfoService.updateById(info);
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    public String edit(@PathVariable("id") String id, Model model) {
        Long applyId = Long.parseLong(id.split("&")[0]);
        String assetNo = id.split("&")[1];
        AssetApply apply = assetApplyService.getById(id);
        QueryWrapper<AssetInfo> wrapper = new QueryWrapper<>();
        wrapper.eq("asset_input_no",assetNo);
        AssetInfo info = assetInfoService.getOne(wrapper);

        if(info!=null){
            QueryWrapper wrapper1 = new QueryWrapper();
            wrapper1.eq("id", info.getLocationId());
            Location location = this.locationService.getOne(wrapper1);
            if (location != null) {
                model.addAttribute("locationName", location.getName());
            }
            model.addAttribute("locationId", info.getLocationId());
        }

        QueryWrapper wrapper2 = new QueryWrapper();
        wrapper2.eq("login_name", apply.getApplyId());
        User user = this.userService.getOne(wrapper2);
        if (user != null) {
            model.addAttribute("userName", user.getNickName());
        }

        model.addAttribute("assetInfo", info);
        model.addAttribute("apply", apply);
        return "apply/detail";
    }

    @RequiresPermissions("ams:apply:edit")
    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存资产申请编辑数据")
    public RestResponse edit(@RequestBody AssetApply assetApply,@RequestParam(value = "locationId", required = false) String locationId) {
        AssetInfo assetInfo = new AssetInfo();
        QueryWrapper wrapper2 = new QueryWrapper();
        wrapper2.eq("asset_input_no", assetApply.getNo());
        AssetInfo resultInfo = assetInfoService.getOne(wrapper2);
        assetInfo.setId(resultInfo.getId());
        assetInfo.setLocationId(locationId);
        assetInfoService.updateById(assetInfo);
        assetApplyService.updateById(assetApply);
        return RestResponse.success();
    }

    @RequestMapping(value = "/noToPageNo", method = RequestMethod.GET)
    @ResponseBody
    @SysLog("NO转换InputNo")
    public Map<String,String> noToPageNo(@RequestParam(value = "no", required = false) String no) {
        Map<String, String> map=new HashMap<>();
        AssetInfo info = new AssetInfo();
        info.setNo(no);
        String inputNo = assetInfoService.noToPageNo(info);
        map.put("inputNo", inputNo);
        return map;
    }

    @RequiresPermissions("ams:apply:returnAsset")
    @PostMapping("returnAsset")
    @ResponseBody
    @SysLog("归还资产信息新增数据")
    public RestResponse returnAsset(@RequestBody List<AssetApply> assetApplys) {
        List<AssetInfo> assetInfoList = new ArrayList();
        for (AssetApply a : assetApplys) {
            if(a.getReturnDate()==null){
                //资产主表更新
                System.out.println(JSON.toJSONString(a));
                QueryWrapper wrapper2 = new QueryWrapper();
                wrapper2.eq("asset_input_no", a.getNo());
                AssetInfo resultInfo = assetInfoService.getOne(wrapper2);
                resultInfo.setStatusProperty("1");
                resultInfo.setLocationId(null);
                resultInfo.setApplyUserid(null);
                resultInfo.setTakeoutUserid(null);
                assetInfoList.add(resultInfo);
                //移动履历表更新
                wrapper2=new QueryWrapper();
                wrapper2.eq("no",a.getNo());
                wrapper2.isNull("DELETE_DATE");
                AssetMoveManager assetMoveManager = this.assetMoveManageService.getOne(wrapper2);
                if(assetMoveManager!=null){
                    assetMoveManager.setMoreInfo(a.getMoreInfo() + "[PC归还]");
                    assetMoveManager.setRemoveDate(new Date());
                    assetMoveManageService.updateById(assetMoveManager);
                }
                //带出表更新
                QueryWrapper wrapper=new QueryWrapper();
                wrapper.eq("NO",a.getNo());
                wrapper.isNull("return_date");
                wrapper.eq("del_flag",false);
                AssetTakeOut out=this.takeOutService.getOne(wrapper);
                if(out!=null){
                    out.setReturnDate(new Date());
                    out.setMoreInfo(out.getMoreInfo()+"[PC归还]");
                    this.takeOutService.updateById(out);
                }

            }
        }
        assetApplyService.returnAssetApplys(assetApplys);
        if(assetInfoList.size()>0){
            assetInfoService.updateBatchById(assetInfoList);
        }
        return RestResponse.success();
    }

    @RequiresPermissions("ams:apply:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除资产申请信息数据(单个)")
    public RestResponse delete(@RequestParam(value = "id", required = false) Long id) {
        if (id == null || id == 0 || id == 1) {
            return RestResponse.failure("参数错误");
        }
        AssetApply assetApply = assetApplyService.getById(id);
        if (assetApply == null) {
            return RestResponse.failure("资产申请不存在");
        }
        assetApplyService.deleteAssetApply(assetApply);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:apply:delete")
    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("删除资产申请信息数据(多个)")
    public RestResponse deleteSome(@RequestBody List<AssetApply> assetApplys) {
        assetApplyService.returnAssetApplys(assetApplys);
        return RestResponse.success();
    }
}
