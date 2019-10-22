package com.kst.ams.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.*;
import com.kst.ams.service.*;
import com.kst.ams.utils.DocOutUtil;
import com.kst.ams.vo.AssetInfoVO;
import com.kst.common.base.controller.BaseController;
import com.kst.common.utils.*;
import com.kst.sys.api.entity.Organization;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IDictService;
import com.kst.common.base.vo.DataTable;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.service.IOrganizationService;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.kst.sys.api.entity.Dict;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

/**
 * Created by zjf on 2019/06/03.
 */
@Controller
@RequestMapping("ams/asset")
public class AssetInfoController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetInfoController.class);

    @Autowired
    private IAssetInfoService assetInfoService;

    @Autowired
    private IDictService dictService;

    @Autowired
    private IPcInfoService pcInfoService;

    @Autowired
    private INetInfoService netInfoService;

    @Autowired
    private ISoftwareService softwareService;

    @Autowired
    private ILocationService locationService;

    @Autowired
    private IOrganizationService organizationService;

    @Autowired
    private ISupplierService supplierService;

    @Autowired
    private IAssetApplyService assetApplyService;

    @Autowired
    private IAssetTakeOutService assetTakeOutService;

    @Autowired
    private IDivideService divideService;

    @Autowired
    private IAssetMoveManageService assetMoveManageService;

    @GetMapping("list")
    @RequiresPermissions("ams:asset:list")
    @SysLog("跳转系统资产列表页面")
    public String list(Model model) {
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> testList = this.dictService.list(dictQueryWrapper);
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_apply");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> statusList = this.dictService.list(dictQueryWrapper);
        model.addAttribute("testType", testList);
        model.addAttribute("statusType", statusList);
        return "asset/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<AssetInfo> list(@RequestBody DataTable dt) {
        return assetInfoService.pageSearch(dt);
    }

    @GetMapping("add")
    public String add(Model model) {
        AssetInfo assetInfo = new AssetInfo();
        //考试类型
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_type");
        dictQueryWrapper.eq("del_flag",false);
        //题目类型
        List<Dict> testList = this.dictService.list(dictQueryWrapper);
        //pc类型
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_pc_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> pcType = this.dictService.list(dictQueryWrapper);

        //软件类型
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_soft_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> softType = this.dictService.list(dictQueryWrapper);

        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_hard_disk_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> hardDiskType = this.dictService.list(dictQueryWrapper);

        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_ram_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> ramType = this.dictService.list(dictQueryWrapper);

        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_target");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> targetType = this.dictService.list(dictQueryWrapper);

        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_status");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> assetStatus = this.dictService.list(dictQueryWrapper);

        model.addAttribute("testType", testList);//资产类型
        model.addAttribute("asset", assetInfo);//资产主信息
        model.addAttribute("pcType", pcType);//pc类型
        model.addAttribute("softType", softType);//软件类型
        model.addAttribute("hardDiskType", hardDiskType);//硬盘类型
        model.addAttribute("ramType", ramType);//内存类型
        model.addAttribute("targetType", targetType);//点检对象
        model.addAttribute("statusType", assetStatus);//状态属性
        return "asset/detail";
    }

    @RequiresPermissions("ams:asset:add")
    @PostMapping("add")
    @ResponseBody
    @SysLog("保存资产信息新增数据")
    public RestResponse add(@RequestParam Map<String, Object> params) {
        //考试类型
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[]{"yyyy-MM-dd hh:mm:ss", "yyyy-MM-dd HH:mm:ss"}));
        JSONObject object = JSONObject.fromObject(params.get("assetData"));
        AssetInfo assetInfo1 = (AssetInfo) JSONObject.toBean(object, AssetInfo.class);
        if (assetInfo1.getDivideFlag()) {
            assetInfo1.setResidualPrice(assetInfo1.getPrice() * assetInfo1.getResidualProportion() * 0.01);
            assetInfo1.setNetWorth(assetInfo1.getPrice() - assetInfo1.getResidualPrice());
        }

        if (!assetInfoService.save(assetInfo1)) {
            return RestResponse.failure("添加失败");
        }
        if (assetInfo1.getDivideFlag()) {
            this.divideAsset(assetInfo1, assetInfo1.getUseLife() * 12, 0.0, assetInfo1.getBuyDate(), true);
        }

        if (params.get("pcData") != null) {
            PcInfo pcInfo = (PcInfo) JSONObject.toBean(JSONObject.fromObject(params.get("pcData")), PcInfo.class);
            this.pcInfoService.save(pcInfo);
        }

        if (params.get("netData") != null) {
            NetInfo netInfo = (NetInfo) JSONObject.toBean(JSONObject.fromObject(params.get("netData")), NetInfo.class);
            this.netInfoService.save(netInfo);
        }

        if (params.get("softData") != null) {
            JSONArray jsonArray = JSONArray.fromObject(params.get("softData"));

            for (int i = 0; i < jsonArray.size(); i++) {
                Object o = jsonArray.get(i);
                JSONObject jsonObject2 = JSONObject.fromObject(o);
                SoftwareInfo item = (SoftwareInfo) JSONObject.toBean(jsonObject2, SoftwareInfo.class);
                item.setAssetNo(assetInfo1.getAssetInputNo());
                item.setScrapFlag(false);
                this.softwareService.save(item);
            }
        }
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model) {
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_type");
        dictQueryWrapper.eq("del_flag",false);
        //题目类型
        List<Dict> testList = this.dictService.list(dictQueryWrapper);
        //pc类型
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_pc_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> pcType = this.dictService.list(dictQueryWrapper);
        //软件类型
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_soft_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> softType = this.dictService.list(dictQueryWrapper);
        //硬盘类型
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_hard_disk_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> hardDiskType = this.dictService.list(dictQueryWrapper);
        //内存类型
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_ram_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> ramType = this.dictService.list(dictQueryWrapper);
        //是否为点检对象
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_target");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> targetType = this.dictService.list(dictQueryWrapper);
        //资产状态
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_status");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> assetStatus = this.dictService.list(dictQueryWrapper);

        AssetInfo asset = assetInfoService.getById(id);

        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("asset_no", asset.getAssetInputNo());
        wrapper.eq("del_flag", false);
        PcInfo pcInfo = this.pcInfoService.getOne(wrapper);
        model.addAttribute("pcInfo", pcInfo);
        NetInfo netInfo = this.netInfoService.getOne(wrapper);
        model.addAttribute("netInfo", netInfo);
        List<SoftwareInfo> softwareInfo = this.softwareService.list(wrapper);
        System.out.println("软件信息" + JSON.toJSONString(softwareInfo));
        model.addAttribute("softwareInfo", softwareInfo);

        QueryWrapper wrapper1 = new QueryWrapper();
        //查询上级资产名字
        wrapper1.eq("asset_input_no", asset.getSuperiorAssetNo());
        AssetInfo superiorAsset = this.assetInfoService.getOne(wrapper1);
        if (superiorAsset != null) {
            model.addAttribute("superiorAssetName", superiorAsset.getName());
        }
        //场所名字
        wrapper1 = new QueryWrapper();
        wrapper1.eq("id", asset.getLocationId());
        Location location = this.locationService.getOne(wrapper1);
        if (location != null) {
            model.addAttribute("locationName", location.getName());
        }

        //保管部门
        wrapper1 = new QueryWrapper();
        wrapper1.eq("id", asset.getKeepingDepartmentId());
        Organization organization = this.organizationService.getOne(wrapper1);
        if (organization != null) {
            model.addAttribute("keepingDepartmentName", organization.getName());
        }


        //供应商
        wrapper1 = new QueryWrapper();
        wrapper1.eq("id", asset.getSupplierId());
        Supplier supplier = this.supplierService.getOne(wrapper1);
        if (supplier != null) {
            model.addAttribute("supplierName", supplier.getName());
        }

        model.addAttribute("asset", asset);
        model.addAttribute("testType", testList);
        model.addAttribute("pcType", pcType);
        model.addAttribute("softType", softType);
        model.addAttribute("hardDiskType", hardDiskType);
        model.addAttribute("ramType", ramType);
        model.addAttribute("targetType", targetType);//点检对象
        model.addAttribute("statusType", assetStatus);//状态属性
        return "asset/detail";
    }


    @RequiresPermissions("ams:asset:edit")
    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存资产信息编辑数据")
    public RestResponse edit(@RequestParam Map<String, Object> params) {
        //考试类型
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[]{"yyyy-MM-dd hh:mm:ss", "yyyy-MM-dd HH:mm:ss"}));
        JSONObject object = JSONObject.fromObject(params.get("assetData"));

        AssetInfo assetInfo1 = (AssetInfo) JSONObject.toBean(object, AssetInfo.class);

        AssetInfo oldAssetInfo = this.assetInfoService.getById(assetInfo1.getId());
        if (assetInfo1.getDivideFlag()) {
            assetInfo1.setResidualPrice(assetInfo1.getPrice() * assetInfo1.getResidualProportion() * 0.01);
            assetInfo1.setNetWorth(assetInfo1.getPrice() - assetInfo1.getResidualPrice());
        }

        if (!assetInfoService.updateById(assetInfo1)) {
            return RestResponse.failure("添加失败");
        }

        //添加/修改pc信息
        if (params.get("pcData") != null) {
            PcInfo pcInfo = (PcInfo) JSONObject.toBean(JSONObject.fromObject(params.get("pcData")), PcInfo.class);
            this.pcInfoService.saveOrUpdate(pcInfo);
        }

        //添加修改网络信息
        if (params.get("netData") != null) {
            NetInfo netInfo = (NetInfo) JSONObject.toBean(JSONObject.fromObject(params.get("netData")), NetInfo.class);
            this.netInfoService.saveOrUpdate(netInfo);
        }

        //添加修改配件信息
        if (params.get("softData") != null) {
            JSONArray jsonArray = JSONArray.fromObject(params.get("softData"));
            for (int i = 0; i < jsonArray.size(); i++) {
                Object o = jsonArray.get(i);
                JSONObject jsonObject2 = JSONObject.fromObject(o);
                SoftwareInfo item = (SoftwareInfo) JSONObject.toBean(jsonObject2, SoftwareInfo.class);
                item.setAssetNo(assetInfo1.getAssetInputNo());
                item.setScrapFlag(false);
                this.softwareService.saveOrUpdate(item);
            }
        }
        //删除配件信息
        if (params.get("delIds") != null) {
            String[] ids = (String.valueOf(params.get("delIds")).split(","));
            for (String id : ids) {
                SoftwareInfo s = new SoftwareInfo();
                s.setId(Long.parseLong(id));
                s.setDelFlag(true);
                this.softwareService.updateById(s);
            }
        }

        //如果资产报废，则对领用，带出，移动等表造成影响
        if (assetInfo1.getStatusProperty().equals("3")) {
            QueryWrapper wrapper = new QueryWrapper();
            wrapper.eq("NO", assetInfo1.getAssetInputNo());
            wrapper.eq("del_flag", false);
            wrapper.isNull("return_date");
            assetInfo1.setApplyUserid(null);
            assetInfo1.setTakeoutUserid(null);

            QueryWrapper hisWrapper = new QueryWrapper();
            hisWrapper.eq("no", assetInfo1.getAssetInputNo());
            hisWrapper.eq("del_flag", false);
            hisWrapper.isNull("delete_date");
            //修改带出，领用，移动表数据
            AssetMoveManager manager = this.assetMoveManageService.getOne(hisWrapper);
            AssetApply apply = this.assetApplyService.getOne(wrapper);
            AssetTakeOut takeOut = this.assetTakeOutService.getOne(wrapper);
            if (apply != null) {
                System.out.println("apply不为空");
                apply.setMoreInfo(apply.getMoreInfo() + "[PC报废]");
                apply.setReturnDate(new Date());
                this.assetApplyService.updateById(apply);
            }
            if (takeOut != null) {
                System.out.println("takeOut不为空");
                takeOut.setMoreInfo(takeOut.getMoreInfo() + "[PC报废]");
                takeOut.setReturnDate(new Date());
                this.assetTakeOutService.updateById(takeOut);
            }
            if (manager != null) {
                manager.setRemoveDate(new Date());
                manager.setMoreInfo(manager.getMoreInfo() + "[PC报废]");
                this.assetMoveManageService.updateById(manager);
            }
            QueryWrapper softWrapper = new QueryWrapper();
            softWrapper.eq("asset_no", assetInfo1.getAssetInputNo());
            softWrapper.eq("del_flag", false);
            List<SoftwareInfo> softs = this.softwareService.list(softWrapper);
            if (softs.size() > 0) {
                for (SoftwareInfo soft : softs) {
                    soft.setScrapFlag(true);
                    this.softwareService.updateById(soft);
                }
            }
        } else {
            this.editDivideAsset(assetInfo1, oldAssetInfo);
        }

        return RestResponse.success();
    }

    /**
     * @param assetInfo         资产信息
     * @param month             分摊月份
     * @param provisionAllValue 剩余价值
     * @param startDate         开始计算日期
     * @param isAdd             是否为新增折旧 true 则计算系统时间所在月份的折旧 /false 则不计算
     */
    public void divideAsset(AssetInfo assetInfo, Integer month, Double provisionAllValue, Date startDate, boolean isAdd) {
        if (assetInfo.getDivideFlag()) {
            System.out.println(":" + assetInfo.getUseLife() + ":" + assetInfo.getBuyDate() + ":" + assetInfo.getPrice());
            if (month != null && assetInfo.getBuyDate() != null && assetInfo.getPrice() != null) {
                //添加
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
                Calendar date = Calendar.getInstance();
                date.setTime(startDate);
                double price = assetInfo.getPrice();//价格
                double residue = (assetInfo.getNetWorth() - provisionAllValue);//净值计算基值（若未折旧过，则为净值，若折旧过，则减去已折旧的价值）

                Double monthDevide = Double.valueOf(String.format("%.2f", residue / month));//净值每月减损
                List<Divide> list = new ArrayList<>();
                if (sdf.format(assetInfo.getBuyDate()).equals(sdf.format(startDate)) && isAdd) {
                    //System.out.println("输入本月id");
                    Divide d = new Divide();
                    d.setAssetNo(assetInfo.getAssetInputNo());
                    d.setDivideYymm(sdf.format(date.getTime()));
                    d.setMonthProvision(monthDevide);
                    d.setProvisionValue(0.0);
                    d.setProvisionAllValue(0.0);
                    d.setBalanceValue(assetInfo.getPrice());
                    list.add(d);
                }
                for (int i = 0; i < month; i++) {
                    date.add(Calendar.MONTH, 1);
                    Divide d = new Divide();
                    d.setAssetNo(assetInfo.getAssetInputNo());
                    d.setDivideYymm(sdf.format(date.getTime()));
                    d.setMonthProvision(monthDevide);
                    d.setResidualFlag(false);
                    if (i == month - 1) {
                        monthDevide = assetInfo.getNetWorth() - provisionAllValue;
                    }
                    d.setProvisionValue(monthDevide);
                    provisionAllValue += monthDevide;
                    d.setProvisionAllValue(provisionAllValue);
                    d.setBalanceValue(Double.valueOf(String.format("%.2f", price - provisionAllValue)));
                    System.out.println("年月：" + d.getDivideYymm() + " 每月：" + d.getMonthProvision() + "  本月：" + d.getProvisionValue() + "  总：" + d.getProvisionAllValue() + " 剩余：" + d.getBalanceValue());
                    list.add(d);

                }

                Double residualmonthDevide = Double.valueOf(String.format("%.2f", assetInfo.getResidualPrice() / 5));//残值值每月减损
                double residualPrice = assetInfo.getResidualPrice();//残值
                double residualAverage = Double.valueOf(String.format("%.2f", residualPrice / 5));//残值平均
                //double residualRemain = Double.valueOf(String.format("%.2f", (assetInfo.getResidualPrice()) % 5));//残值余数
                //System.out.println("残值余数" + residualRemain);
                for (int i = 0; i < 5; i++) {
                    date.add(Calendar.MONTH, 1);
                    Divide d = new Divide();
                    d.setAssetNo(assetInfo.getAssetInputNo());
                    d.setDivideYymm(sdf.format(date.getTime()));
                    d.setMonthProvision(residualAverage);
                    if (i == 4) {
                        residualmonthDevide = assetInfo.getPrice() - provisionAllValue;
                    }
                    provisionAllValue += residualmonthDevide;
                    d.setProvisionValue(residualmonthDevide);
                    d.setProvisionAllValue(provisionAllValue);
                    d.setBalanceValue(Double.valueOf(String.format("%.2f", price - provisionAllValue)));
                    d.setResidualFlag(true);
                    list.add(d);
                    //System.out.println("年月：" + d.getDivideYymm() + "  本月：" + d.getProvisionValue() + "  总：" + d.getProvisionAllValue() + " 剩余：" + d.getBalanceValue());
                }
                this.divideService.saveBatch(list);
            }
        }
    }

    //editDevide
    public void editDivideAsset(AssetInfo newAsset, AssetInfo oldAsset) {
        //是否修改divideFlag
        if (newAsset.getDivideFlag() == oldAsset.getDivideFlag()) {
            System.out.println("未修改devideFlag");
            if (newAsset.getDivideFlag()) {
                //修改了年限
                System.out.println(newAsset.getUseLife() + "  " + oldAsset.getUseLife());
                if (!newAsset.getUseLife().equals(oldAsset.getUseLife())) {
                    System.out.println("修改年限");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
                    String d = sdf.format(new Date());
                    QueryWrapper wrapper = new QueryWrapper();
                    System.out.println(d);


                    List<Divide> pass = this.divideService.selectPassDivideByYymm(oldAsset.getAssetInputNo(), d);
                    List<Divide> future = this.divideService.selectuFtureDivideByYymm(oldAsset.getAssetInputNo(), d);

                    System.out.println("数量" + pass.size() + "  " + future.size());

                    wrapper.eq("divide_yymm", d);
                    wrapper.eq("asset_no", oldAsset.getAssetInputNo());
                    wrapper.eq("del_flag", false);

                    if (future.size() > 0) {
                        for (Divide di : future) {
                            di.setDelFlag(true);
                            //System.out.println(this.divideService.updateById(di));
                        }
                        this.divideService.updateBatchById(future);
                    }


                    AssetInfo assetInfo = new AssetInfo();
                    Double provisionAllValue = 0.0;
                    if (pass.size() > 0) {
                        Divide divide = this.divideService.getOne(wrapper);
                        provisionAllValue = divide.getProvisionAllValue();
                    }
                    System.out.println(provisionAllValue);
                    divideAsset(newAsset, newAsset.getUseLife() * 12 - pass.size(), provisionAllValue, new Date(), false);
                }
            }
        } else {
            System.out.println("修改了divideFlag");
            if (newAsset.getDivideFlag()) {
                //System.out.println("0->1 新增");
                divideAsset(newAsset, newAsset.getUseLife() * 12, 0.0, newAsset.getBuyDate(), true);
            } else {
                //System.out.println("1->0 删除");
                QueryWrapper wrapper = new QueryWrapper();
                wrapper.eq("asset_no", newAsset.getAssetInputNo());
                Divide divide = new Divide();
                divide.setDelFlag(true);
                this.divideService.update(divide, wrapper);
            }
        }
    }


    //复制资产
    @GetMapping("copyAsset/{id}")
    public String copyAsset(@PathVariable("id") Long id, Model model) {
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_type");
        dictQueryWrapper.eq("del_flag",false);

        List<Dict> testList = this.dictService.list(dictQueryWrapper);
        //pc类型
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_pc_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> pcType = this.dictService.list(dictQueryWrapper);
        //软件类型
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_soft_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> softType = this.dictService.list(dictQueryWrapper);
        //硬盘类型
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_hard_disk_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> hardDiskType = this.dictService.list(dictQueryWrapper);
        //内存类型
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_ram_type");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> ramType = this.dictService.list(dictQueryWrapper);
        //是否为点检对象
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_target");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> targetType = this.dictService.list(dictQueryWrapper);
        //资产状态属性
        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_status");
        dictQueryWrapper.eq("del_flag",false);
        List<Dict> assetStatus = this.dictService.list(dictQueryWrapper);

        AssetInfo asset = assetInfoService.getById(id);

        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("asset_no", asset.getAssetInputNo());
        wrapper.eq("del_flag", false);
        PcInfo pcInfo = this.pcInfoService.getOne(wrapper);
        if (pcInfo != null) {
            pcInfo.setId(null);
            pcInfo.setAssetNo(null);
        }
        model.addAttribute("pcInfo", pcInfo);
        NetInfo netInfo = this.netInfoService.getOne(wrapper);
        if (netInfo != null) {
            netInfo.setAssetNo(null);
            netInfo.setId(null);
        }

        model.addAttribute("netInfo", netInfo);
        List<SoftwareInfo> softwareInfo = this.softwareService.list(wrapper);
        for (SoftwareInfo soft : softwareInfo) {
            soft.setId(null);
            soft.setAssetNo(null);
        }
        model.addAttribute("softwareInfo", softwareInfo);

        QueryWrapper wrapper1 = new QueryWrapper();
        //查询上级资产名字
        wrapper1.eq("asset_input_no", asset.getSuperiorAssetNo());
        AssetInfo superiorAsset = this.assetInfoService.getOne(wrapper1);
        if (superiorAsset != null) {
            model.addAttribute("superiorAssetName", superiorAsset.getName());
        }
        //场所名字
        wrapper1 = new QueryWrapper();
        wrapper1.eq("id", asset.getLocationId());
        Location location = this.locationService.getOne(wrapper1);
        if (location != null) {
            model.addAttribute("locationName", location.getName());
        }


        //保管部门
        wrapper1 = new QueryWrapper();
        wrapper1.eq("id", asset.getKeepingDepartmentId());
        Organization organization = this.organizationService.getOne(wrapper1);
        if (organization != null) {
            model.addAttribute("keepingDepartmentName", organization.getName());
        }


        //供应商
        wrapper1 = new QueryWrapper();
        wrapper1.eq("id", asset.getSupplierId());
        Supplier supplier = this.supplierService.getOne(wrapper1);
        if (supplier != null) {
            model.addAttribute("supplierName", supplier.getName());
        }


        asset.setId(null);
        asset.setNo(null);
        model.addAttribute("asset", asset);
        model.addAttribute("testType", testList);
        model.addAttribute("pcType", pcType);
        model.addAttribute("softType", softType);
        model.addAttribute("hardDiskType", hardDiskType);
        model.addAttribute("ramType", ramType);
        model.addAttribute("targetType", targetType);//点检对象
        model.addAttribute("statusType", assetStatus);//状态属性

        return "asset/detail";
    }


    @PostMapping("checkNameExist/{mode}")
    @ResponseBody
    @SysLog("资产名称存在验证")
    public RestResponse checkNameExist(@PathVariable("mode") Integer mode, String name, Long id) {
        boolean result = true;

        if (1 == mode) {    //新增场合
            if (assetInfoService.assetInfoCount("name", name) > 0) {
                result = false;
            }
        } else if (2 == mode) {  //编辑场合
            AssetInfo oldAssetInfo = assetInfoService.getById(id);
            if (StringUtils.isNotBlank(name)) {
                if (!name.equals(oldAssetInfo.getName())) {
                    if (assetInfoService.assetInfoCount("name", name) > 0) {
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @PostMapping("checkAssetInputNo/{mode}")
    @ResponseBody
    @SysLog("资产编号存在验证")
    public RestResponse checkAssetInputNo(@PathVariable("mode") Integer mode, String assetInputNo, Long id) {
        boolean result = true;
        assetInputNo = assetInputNo.toUpperCase();
        if (1 == mode) {    //新增场合
            if (assetInfoService.assetInfoCount("asset_input_no", assetInputNo) > 0) {
                result = false;
            }
        } else if (2 == mode) {  //编辑场合
            AssetInfo oldAssetInfo = assetInfoService.getById(id);
            if (StringUtils.isNotBlank(assetInputNo)) {
                if (!assetInputNo.equals(oldAssetInfo.getAssetInputNo())) {
                    if (assetInfoService.assetInfoCount("asset_input_no", assetInputNo) > 0) {
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }


    @RequiresPermissions("ams:asset:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除资产信息数据(单个)")
    public RestResponse delete(@RequestParam(value = "id", required = false) Long id) {
        if (id == null || id == 0 || id == 1) {
            return RestResponse.failure("参数错误");
        }
        AssetInfo assetInfo = assetInfoService.getById(id);
        if (assetInfo == null) {
            return RestResponse.failure("资产不存在");
        }

        assetInfoService.deleteAssetInfo(assetInfo);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:asset:delete")
    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("删除资产信息数据(多个)")
    public RestResponse deleteSome(@RequestBody List<AssetInfo> assetInfos) {
        assetInfoService.deleteAssetInfo(assetInfos);
        return RestResponse.success();
    }

    @RequestMapping("selectSoft")
    @ResponseBody
    public List<SoftwareInfo> selcetSoft(String no) {
        //根据资产no查询配件信息
        QueryWrapper<SoftwareInfo> wrapper = new QueryWrapper<>();
        wrapper.eq("asset_no", no);
        return this.softwareService.list(wrapper);
    }


    @GetMapping("divideDetail/{id}")
    public String divideDetail(@PathVariable("id") Long id, Model model) {
        AssetInfo assetInfo = this.assetInfoService.getById(id);
        model.addAttribute("assetInfo", assetInfo);
        return "asset/divideDetail";
    }

    @PostMapping("divideDetail/{assetNo}")
    @ResponseBody
    public List<Divide> divideDetail(@PathVariable("assetNo") String assetNo) {
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("asset_no", assetNo);
        wrapper.eq("del_flag", false);
        return this.divideService.list(wrapper);
    }


    @PostMapping("checkSoftAmount")
    @ResponseBody
    @SysLog("判断该配件数量是否足够")
    public Boolean checkSoftAmount(String assetNo) {
        return this.assetInfoService.selectSoftAmount(assetNo);
    }

    @GetMapping("downloadCSVFile")
    public void downloadCSVFile(String ids, HttpServletResponse response) {
        //将资产信息导出为excel文件 （之前是导出成csv文件，后来改了，所以方法名为csv）
        List<String> classList = Arrays.asList(ids.split(","));
        Map<String, Object> params = new HashMap<>();
        params.put("ids", classList);
        List<AssetInfoVO> list = this.assetInfoService.selectCSVData(params);
        String[] head = {"资产编号", "资产名称", "资产分类", "资产品牌", "供应商", "登记日", "购买日", "使用年限",
                "预定报废日", "保管部门", "存放地点", "申领者", "带出者"};
        List<Object> heads = Arrays.asList(head);
        List<List<Object>> dataList = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (AssetInfoVO li : list) {
            List<Object> l = new ArrayList<>();
            l.add(li.getAssetInputNo());
            l.add(li.getName());
            l.add(li.getClassifyName());
            l.add(li.getBrand() != null ? li.getBrand() : "");
            l.add(li.getSupplierName());
            l.add(li.getRegisterDate() != null ? sdf.format(li.getRegisterDate()) : "");
            l.add(li.getBuyDate() != null ? sdf.format(li.getBuyDate()) : "");
            l.add(li.getUseLife() != null ? li.getUseLife() : "");
            l.add(li.getReserveScrapDate() != null ? sdf.format(li.getReserveScrapDate()) : "");
            l.add(li.getOrganizationName());
            l.add(li.getLocationName());
            l.add(li.getApplyUserid() != null ? li.getApplyUserid() : "");
            l.add(li.getTakeoutUserid() != null ? li.getTakeoutUserid() : "");
            dataList.add(l);
        }
        DocumentOutUtils.createExcel(heads, dataList, response, "AssetData");
    }

    @GetMapping("exportExcelModel")
    public void exportAssetModel(HttpServletResponse response) {
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("type", "ams_asset_type");
        List<Dict> dicts = this.dictService.list(wrapper);

        wrapper = new QueryWrapper();
        wrapper.eq("del_flag", false);
        List<Organization> organizations = this.organizationService.list(wrapper);
        DocOutUtil docOutUtil = new DocOutUtil();

        docOutUtil.exportAssetInfoModel(dicts, organizations, response);
    }

    @PostMapping("uploadExcel")
    @ResponseBody
    public RestResponse uploadExcel(@RequestParam("file") MultipartFile file) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String fileName = file.getOriginalFilename();
        if (!fileName.substring(fileName.lastIndexOf(".")).equals(".xlsx")) {
            return RestResponse.failure("导入的文件不是.xlsx格式，请选择正确的文件导入");
        }

        XSSFWorkbook wb = null;
        try {
            wb = new XSSFWorkbook(file.getInputStream());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        XSSFSheet sheet = wb.getSheet("资产信息");

        if (sheet == null) {
            return RestResponse.failure("2");
        }

        System.out.println(sheet.getLastRowNum());
        List<AssetInfo> assetInfos = new ArrayList<>();
        for (int i = 6; i <= sheet.getLastRowNum(); i++) {
            XSSFRow row = sheet.getRow(i);
            if (row != null) {
                int errInt = 2;
                try {
                    XSSFCell cell = row.getCell(2);
                    if (cell != null) {
                        cell.setCellType(CellType.STRING);
                        String assetInputNo = row.getCell(2).getStringCellValue();
                        if (!assetInputNo.equals("")) {
                            QueryWrapper<AssetInfo> wrapper = new QueryWrapper();
                            wrapper.eq("asset_input_no", assetInputNo);
                            if (this.assetInfoService.getOne(wrapper) == null) {
                                AssetInfo assetInfo = new AssetInfo();


                                assetInfo.setAssetInputNo(assetInputNo);
                                errInt += 1;
                                assetInfo.setName(row.getCell(3) != null ? row.getCell(3).getStringCellValue() : "");
                                errInt += 2;
                                assetInfo.setClassify(row.getCell(5) != null ? row.getCell(5).getStringCellValue() : "");
                                errInt += 1;
                                assetInfo.setBrand(row.getCell(6) != null ? row.getCell(6).getStringCellValue() : "");
                                errInt += 1;
                                assetInfo.setRegisterDate(row.getCell(7) != null ? row.getCell(7).getDateCellValue() != null ? row.getCell(7).getDateCellValue() : new Date() : new Date());
                                errInt += 1;
                                assetInfo.setBuyDate(row.getCell(8) != null ? row.getCell(8).getDateCellValue() != null ? row.getCell(8).getDateCellValue() : new Date() : new Date());
                                errInt += 1;
                                assetInfo.setPrice(row.getCell(9) != null ? row.getCell(9).getNumericCellValue() : 0);
                                errInt += 1;
                                XSSFCell c = row.getCell(10);
                                if (c != null) {
                                    assetInfo.setAmount((int) (row.getCell(10).getNumericCellValue()));
                                } else {
                                    assetInfo.setAmount(1);
                                }

                                errInt += 1;
                                assetInfo.setUseLife((int) (row.getCell(11) != null ? row.getCell(11).getNumericCellValue() : 1));
                                errInt += 2;

                                c = row.getCell(13);
                                if (c != null) {
                                    //c.setCellType(CellType.STRING);
                                    assetInfo.setKeepingDepartmentId(row.getCell(13).getStringCellValue());
                                }
                                errInt += 1;
                                c = row.getCell(14);
                                if (c != null) {
                                    String str = c.getStringCellValue();
                                    if (str.equals("是")) {
                                        str = "1";
                                    } else if (str.equals("否")) {
                                        str = "2";
                                    } else {
                                        str = "2";
                                    }
                                    assetInfo.setExamineTarget(str);
                                } else {
                                    assetInfo.setExamineTarget("2");
                                }

                                if (assetInfo.getBuyDate() != null && assetInfo.getUseLife() != null) {
                                    Calendar calendar = Calendar.getInstance();
                                    calendar.setTime(assetInfo.getBuyDate());
                                    calendar.add(Calendar.YEAR, assetInfo.getUseLife());
                                    assetInfo.setReserveScrapDate(calendar.getTime());
                                }

                                assetInfo.setRemarks(row.getCell(15) != null ? row.getCell(15).getStringCellValue() : null);
                                assetInfo.setStatusProperty("1");
                                assetInfo.setSupplierId("");
                                assetInfo.setNo((assetInfo.getClassify() != null ? assetInfo.getClassify() : "") + String.valueOf(new Date().getTime()));
                                assetInfos.add(assetInfo);
                            }
                        }
                    }
                } catch (NullPointerException e) {
                    e.printStackTrace();
                    return RestResponse.failure(1+":"+(i + 1) + ":" + (char) (errInt + 65) + ":null");
                } catch (IllegalStateException e) {
                    e.printStackTrace();
                    return RestResponse.failure(1+":"+(i + 1) + ":" + (char) (errInt + 65) + ":type");
                } catch (Exception e) {
                    e.printStackTrace();
                    return RestResponse.failure(1+":"+(i + 1) + ":" + (char) (errInt + 65) + ":");
                }
            }
        }

        //添加资产数据
        if (assetInfos.size() > 0) {
            if (!this.assetInfoService.saveBatch(assetInfos)) {
                return RestResponse.failure("fail");
            }
        }

        return RestResponse.success();
    }

}
