package com.kst.ams.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.AssetApply;
import com.kst.ams.entity.AssetInfo;
import com.kst.ams.entity.AssetMoveManager;
import com.kst.ams.entity.AssetTakeOut;
import com.kst.ams.service.IAssetApplyService;
import com.kst.ams.service.IAssetInfoService;
import com.kst.ams.service.IAssetMoveManageService;
import com.kst.ams.service.IAssetTakeOutService;
import com.kst.ams.vo.AssetInfoVO;
import com.kst.ams.vo.AssetTakeOutVO;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IDictService;
import com.kst.sys.api.service.IUserService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by zjf on 2019/06/03.
 */
@Controller
@RequestMapping("ams/takeout")
public class AssetTakeOutController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetTakeOutController.class);
    @Autowired
    private IAssetTakeOutService assetTakeOutService;

    @Autowired
    private IAssetInfoService assetInfoService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IAssetMoveManageService assetMoveManageService;

    @Autowired
    private IAssetApplyService assetApplyService;

    @Autowired
    private IDictService dictService;

    @GetMapping("list")
    @RequiresPermissions("ams:takeout:list")
    @SysLog("跳转资产申请列表页面")
    public String list(Model model) {
        List<User> userList = userService.list();
        List<AssetInfo> asssetInfoList = assetInfoService.getAll();
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_takeOut_flg");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> takeOutStatus = this.dictService.list(dictQueryWrapper);

        QueryWrapper<Dict> dictQueryWrapper1 = new QueryWrapper<>();
        dictQueryWrapper1.eq("type", "ams_asset_type");
        dictQueryWrapper1.eq("del_flag",false);
        List<Dict> testList = this.dictService.list(dictQueryWrapper1);
        model.addAttribute("testType", testList);

        model.addAttribute("takeOutStatus",takeOutStatus);
        model.addAttribute("assetlist", asssetInfoList);
        model.addAttribute("userList", userList);
        return "takeout/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<AssetTakeOutVO> list(@RequestBody DataTable dt, ServletRequest request) {
        DataTable<AssetTakeOutVO> list = this.assetTakeOutService.selectTakeOutList(dt);
        return list;
    }
    @RequiresPermissions("ams:takeout:assetlist")
    @PostMapping("assetlist")
    @ResponseBody
    public DataTable<AssetInfoVO> assetlist(@RequestBody DataTable dt, ServletRequest request) {

        return assetInfoService.selectTakeOutAssetList(dt);
    }
    @GetMapping("add")
    public String add(Model model) {
        AssetTakeOut AssetTakeOut = new AssetTakeOut();
        AssetTakeOut.setApplyDate(new Date());
        model.addAttribute("apply", AssetTakeOut);
        QueryWrapper<Dict> dictQueryWrapper1 = new QueryWrapper<>();
        dictQueryWrapper1.eq("type", "ams_asset_type");
        dictQueryWrapper1.eq("del_flag",false);
        List<Dict> testList = this.dictService.list(dictQueryWrapper1);
        model.addAttribute("testType", testList);
        return "takeout/detail";
    }

    @RequiresPermissions("ams:takeout:add")
    @PostMapping("add")
    @ResponseBody
    @SysLog("保存资产带出数据")
    public RestResponse add(@RequestBody AssetTakeOut assetTakeOut,@RequestParam(value = "id", required = false) Long id) {
        AssetInfo assetInfo = this.assetInfoService.getById(id);
        assetInfo.setTakeoutUserid(assetTakeOut.getApplyId());
        assetInfo.setStatusProperty("2");//2:使用中
//        AssetMoveManager assetMoveManager = new AssetMoveManager();
//        assetMoveManager.setMoreInfo("[PC带出]");
//        assetMoveManager.setNo(assetTakeOut.getNo());
//        assetMoveManager.setRemoveDate(new Date());
//        assetMoveManageService.save(assetMoveManager);
        assetInfoService.updateTakeUserIdByNo(assetInfo);
        assetTakeOut.setMoreInfo(assetTakeOut.getMoreInfo()+"[PC带出]");
        assetTakeOutService.save(assetTakeOut);
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model) {
        AssetTakeOut apply = assetTakeOutService.getById(id);
        QueryWrapper wrapper2 = new QueryWrapper();
        wrapper2.eq("login_name", apply.getApplyId());
        User user = this.userService.getOne(wrapper2);
        if (user != null) {
            model.addAttribute("userName", user.getNickName());
        }
        QueryWrapper wrapper3 = new QueryWrapper();
        wrapper3.eq("asset_input_no", apply.getNo());
        AssetInfo assetInfo = this.assetInfoService.getOne(wrapper3);
        if (assetInfo != null) {
            model.addAttribute("assetName", assetInfo.getName());
        }
        model.addAttribute("apply", apply);
        QueryWrapper<Dict> dictQueryWrapper1 = new QueryWrapper<>();
        dictQueryWrapper1.eq("type", "ams_asset_type");
        dictQueryWrapper1.eq("del_flag",false);
        List<Dict> testList = this.dictService.list(dictQueryWrapper1);
        model.addAttribute("testType", testList);
        return "takeout/detail";
    }

    @RequiresPermissions("ams:takeout:edit")
    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存资产申请编辑数据")
    public RestResponse edit(@RequestBody AssetTakeOut assetApply) {
        assetTakeOutService.updateById(assetApply);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:takeout:returnAsset")
    @PostMapping("returnAsset")
    @ResponseBody
    @SysLog("带出资产数据变更")
    public RestResponse returnAsset(@RequestBody List<AssetTakeOut> assetApplys) {
        List<AssetInfo> assetInfoList = new ArrayList();
        if(assetApplys.size()>0){
            for (AssetTakeOut a : assetApplys) {
                QueryWrapper wrapper2 = new QueryWrapper();
                wrapper2.eq("asset_input_no", a.getNo());
                AssetInfo resultInfo = assetInfoService.getOne(wrapper2);
                if (resultInfo != null) {
                    resultInfo.setLocationId("root");
                    resultInfo.setTakeoutUserid(null);
                    assetInfoList.add(resultInfo);
                    assetInfoService.updateBatchById(assetInfoList);
                }

            }
            assetTakeOutService.returnTakeOut(assetApplys);
        }
        return RestResponse.success();
    }
    @RequiresPermissions("ams:takeout:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除资产申请信息数据(单个)")
    public RestResponse delete(@RequestParam(value = "id", required = false) Long id) {
        if (id == null || id == 0 || id == 1) {
            return RestResponse.failure("参数错误");
        }
        AssetTakeOut assetApply = assetTakeOutService.getById(id);
        if (assetApply == null) {
            return RestResponse.failure("资产申请不存在");
        }
        assetTakeOutService.deleteAssetApply(assetApply);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:takeout:delete")
    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("删除资产申请信息数据(多个)")
    public RestResponse deleteSome(@RequestBody List<AssetTakeOut> assetApplys) {
        assetTakeOutService.deleteAssetApplys(assetApplys);
        return RestResponse.success();
    }
}
