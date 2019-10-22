package com.kst.ams.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.AssetExamine;
import com.kst.ams.entity.AssetExamineDetail;
import com.kst.ams.entity.AssetInfo;
import com.kst.ams.service.IAssetExamineDetailService;
import com.kst.ams.service.IAssetExamineService;
import com.kst.ams.service.IAssetInfoService;
import com.kst.ams.vo.AssetExamineVO;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IDictService;

import com.kst.sys.api.service.IOrganizationService;
import com.kst.sys.api.service.IUserService;
import com.kst.sys.api.vo.UserVO;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by zjf on 2019/06/03.
 */
@Controller
@RequestMapping("ams/examine")
public class AssetExamineController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssetExamineController.class);
    @Autowired
    private IAssetExamineService assetExamineService;
    @Autowired
    private IAssetExamineDetailService assetExamineDetailService;
    @Autowired
    private IDictService dictService;
    @Autowired
    private IAssetInfoService assetInfoService;
    @Autowired
    private IUserService userService;
    @Autowired
    private IOrganizationService organizationService;

    @GetMapping("list")
    @RequiresPermissions("ams:examine:list")
    @SysLog("跳转资产转移列表页面")
    public String list() {
        return "examine/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<AssetExamine> list(@RequestBody DataTable dt, ServletRequest request) {
        return assetExamineService.pageSearch(dt);
    }

    @GetMapping("add")
    public String add(Model model) {
        AssetExamine assetExamine = new AssetExamine();
        model.addAttribute("assetExamine", assetExamine);
        return "examine/detail";
    }


    @RequiresPermissions("ams:examine:add")
    @PostMapping("add")
    @ResponseBody
    @SysLog("增加点检对象")
    public RestResponse add(@RequestParam Map<String,Object> params) {
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[]{"yyyy-MM-dd", "yyyy-MM-dd"}));
        JSONObject object = JSONObject.fromObject(params.get("examine"));
        AssetExamine assetExamine = (AssetExamine) JSONObject.toBean(object, AssetExamine.class);
        String type=(String) params.get("type");
        QueryWrapper wrapper=new QueryWrapper();
        if(type.equals("normal")){
            if(params.get("data").equals("1")){
                wrapper.isNotNull("apply_userid");
            }
        }else if(type.equals("user")){
            wrapper.in("apply_userid",((String)params.get("data")).split(","));
        }else if(type.equals("organization")){
            List<Long> ids=new ArrayList<>();
            for (String id:((String)params.get("data")).split(",")){
                Map<String,Object> params2=new HashMap<>();
                params2.put("organIds",((String)params.get("data")).split(","));
                for (UserVO user:this.organizationService.selectAllUserAndOrgan(params2)){
                    ids.add(user.getId());
                }
            }
            wrapper.in("apply_userid",ids);
        }else if(type.equals("location")){
            wrapper.in("location_id",((String)params.get("data")).split(","));
        }

        wrapper.ne("status_property",3);
        wrapper.eq("del_flag",false);
        List<AssetInfo>  list = assetInfoService.list(wrapper);
        for (int i = 0; i < list.size(); i++) {
            AssetInfo info = list.get(i);
            //添加点检对象检查资产是否有点检对象的，有的话直接添加进来。
            if ("1".equalsIgnoreCase(info.getExamineTarget())) {
                AssetExamineDetail detail = new AssetExamineDetail();
                detail.setNo(assetExamine.getNo());//点检NO
                detail.setAssetNo(info.getAssetInputNo());
                detail.setExamineResultId("4");
                assetExamineDetailService.save(detail);
            }
        }
        assetExamine.setExamineCreateDate(getNowDate());
        assetExamineService.save(assetExamine);
        return RestResponse.success();
    }

    @PostMapping("selectExamineAsset")
    @ResponseBody
    public DataTable<AssetInfo> list(@RequestBody DataTable dt) {
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("examine_no",dt.getSearchParams().get("no"));
        List<AssetExamineDetail> list=this.assetExamineDetailService.list(wrapper);
        List<String> ids=new ArrayList<>();
        for (AssetExamineDetail de:list){
            ids.add(de.getAssetNo());
        }
        if(ids.size()>0){
            dt.getSearchParams().put("search_not_in_asset_input_no",ids);
        }
        return assetInfoService.pageSearch(dt);
    }



    @GetMapping("addDetail/{id}")
    public String addDetail(@PathVariable("id") String id,Model model) {
        AssetExamineDetail assetExaminedt = new AssetExamineDetail();
        assetExaminedt.setNo(id);
        //考试类型
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_examineResult_type");
        dictQueryWrapper.eq("del_flag",false);
        //题目类型
        List<Dict> examineResultType = this.dictService.list(dictQueryWrapper);

        model.addAttribute("examineResultType", examineResultType);//资产类型
        model.addAttribute("assetExaminedt", assetExaminedt);
        return "examine/addDetail";
    }

    @RequiresPermissions("ams:examine:addDetail")
    @PostMapping("addDetail")
    @ResponseBody
    @SysLog("增加点检明细对象")
    public RestResponse addDetail(@RequestBody List<AssetExamineDetail> assetExamineDetails) {

        for (AssetExamineDetail detail:assetExamineDetails){
            assetExamineDetailService.save(detail);
        }
        return RestResponse.success();
    }

    @GetMapping("editDetail/{id}")
    public String editDetail(@PathVariable("id") Long id, Model model) {
        AssetExamineDetail assetExaminedt = assetExamineDetailService.getById(id);
        //考试类型
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_examineResult_type");
        dictQueryWrapper.eq("del_flag",false);
        //题目类型
        List<Dict> examineResultType = this.dictService.list(dictQueryWrapper);

        QueryWrapper wrapper2 = new QueryWrapper();
        wrapper2.eq("login_name", assetExaminedt.getExaminerId());
        User user = this.userService.getOne(wrapper2);
        if (user != null) {
            model.addAttribute("userName", user.getNickName());
        }

        model.addAttribute("examineResultType", examineResultType);//资产类型
        model.addAttribute("assetExaminedt", assetExaminedt);
        return "examine/addDetail";
    }

    @RequiresPermissions("ams:examine:editDetail")
    @PostMapping("editDetail")
    @ResponseBody
    @SysLog("保存资产点检数据")
    public RestResponse editDetail(@RequestBody List<AssetExamineDetail> assetExamineDetail,ServletRequest request) {
        for (AssetExamineDetail asset : assetExamineDetail) {
            //asset.setExaminerId(user.getLoginName());
            asset.setExamineDate(getNowDate());
            assetExamineDetailService.saveOrUpdate(asset);
        }
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model) {
        AssetExamine assetExamine = assetExamineService.getById(id);
        assetExamine.setExamineCreateDate(getNowDate());
        model.addAttribute("assetExamine", assetExamine);
        return "examine/detail";
    }

    @RequiresPermissions("ams:examine:edit")
    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存资产点检数据")
    public RestResponse edit(@RequestParam Map<String,Object> params) {
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[]{"yyyy-MM-dd", "yyyy-MM-dd"}));
        JSONObject object = JSONObject.fromObject(params.get("examine"));
        AssetExamine assetExamine = (AssetExamine) JSONObject.toBean(object, AssetExamine.class);
        String type=(String) params.get("type");
        QueryWrapper wrapper=new QueryWrapper();
        System.out.println("数据："+((String)params.get("data"))+"  "+((String)params.get("data")).split(",")[0].equals(""));
        if(type.equals("normal")){
            if(params.get("data").equals("1")){
                wrapper.isNotNull("apply_userid");
            }
        }else if(type.equals("user")){
            String[] str=((String)params.get("data")).split(",");
            if(!str[0].equals("")){
                wrapper.in("apply_userid",str);
            }else{
                wrapper.eq("apply_userid",-1);
            }
        }else if(type.equals("organization")){
            List<String> names=new ArrayList<>();
            String[] str=((String)params.get("data")).split(",");
            if(!str[0].equals("")){
                Map<String,Object> params2=new HashMap<>();
                params2.put("organIds",((String)params.get("data")).split(","));
                for (UserVO user:this.organizationService.selectAllUserAndOrgan(params2)){
                    names.add(user.getLoginName());
                }
            }
            if(names.size()>0){
                wrapper.in("apply_userid",names);
            }else{
                wrapper.eq("apply_userid",-1);
            }
        }else if(type.equals("location")){
            String[] str=((String)params.get("data")).split(",");
            if(!str[0].equals("")){
                wrapper.in("location_id",str);
            }else {
                wrapper.eq("location_id", -1);
            }
        }

        //删除原有的点检对象
        if(params.get("editExamine").equals("0")){
            QueryWrapper wrapper1=new QueryWrapper();
            wrapper1.eq("EXAMINE_NO",assetExamine.getNo());
            this.assetExamineDetailService.remove(wrapper1);

            wrapper.ne("status_property",3);
            wrapper.eq("del_flag",false);
            List<AssetInfo>  list = assetInfoService.list(wrapper);
            for (int i = 0; i < list.size(); i++) {
                AssetInfo info = list.get(i);
                //添加点检对象检查资产是否有点检对象的，有的话直接添加进来。
                if ("1".equalsIgnoreCase(info.getExamineTarget())) {
                    AssetExamineDetail detail = new AssetExamineDetail();
                    detail.setNo(assetExamine.getNo());//点检NO
                    detail.setAssetNo(info.getAssetInputNo());
                    detail.setExamineResultId("4");
                    assetExamineDetailService.save(detail);
                }
            }
        }
        assetExamineService.updateById(assetExamine);
        return RestResponse.success();
    }

    @GetMapping("research/{id}")
    public String research(@PathVariable("id") String id, Model model) {
        Long examineId  = Long.MIN_VALUE;
        if (id != null) {
            examineId = Long.valueOf(id.split("&")[0]);
        }
        List<Map<String,Object>> rstList = new ArrayList<>();
        List<AssetInfo> asssetInfoList = assetInfoService.getAll();
        List<User> userList = userService.list();
        AssetExamineVO vo = assetExamineService.getAssetExamineVOList(examineId);
        List<AssetExamineDetail> list = assetExamineDetailService.getAssetExamineDetailList(examineId);
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","ams_examineResult_type");
        wrapper.eq("del_flag",false);
        List<Dict> dictList=this.dictService.list(wrapper);
        vo.setAssetExamineDetailList(list);
        model.addAttribute("id",examineId);
        model.addAttribute("editAbleFlg",id.split("&")[1]);//1:不可编辑，2：可编辑
        model.addAttribute("assetlist", asssetInfoList);
        model.addAttribute("examineList",dictList);
        model.addAttribute("userList", userList);
        return "examine/examineDetail";
    }

    @RequiresPermissions("ams:examine:research")
    @PostMapping("research")
    @ResponseBody
    @SysLog("点检明细")
    public DataTable<AssetExamineDetail> research(@RequestBody DataTable dt, ServletRequest request) {
        return assetExamineDetailService.selectExamineDetailByPage(dt);
    }

    @RequiresPermissions("ams:examine:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除资产申请信息数据(单个)")
    public RestResponse delete(@RequestParam(value = "id", required = false) Long id) {
        if (id == null || id == 0 || id == 1) {
            return RestResponse.failure("参数错误");
        }
        AssetExamine assetExamine = assetExamineService.getById(id);
        if (assetExamine == null) {
            return RestResponse.failure("资产申请不存在");
        }
        assetExamineService.deleteAssetExamine(assetExamine);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:examine:delete")
    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("删除资产申请信息数据(多个)")
    public RestResponse deleteSome(@RequestBody List<AssetExamine> assetExamines) {
        assetExamineService.deleteAssetExamines(assetExamines);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:examine:deleteDetail")
    @PostMapping("deleteDetail")
    @ResponseBody
    @SysLog("删除资产申请信息数据(单个)")
    public RestResponse deleteDetail(@RequestParam(value = "id", required = false) Long id) {
        if (id == null || id == 0 || id == 1) {
            return RestResponse.failure("参数错误");
        }
        AssetExamineDetail assetExaminedt = assetExamineDetailService.getById(id);
        if (assetExaminedt == null) {
            return RestResponse.failure("资产申请不存在");
        }
        assetExamineDetailService.removeById(id);
        return RestResponse.success();
    }

    @RequiresPermissions("ams:examine:delete")
    @PostMapping("deleteSomeDetail")
    @ResponseBody
    @SysLog("删除资产申请信息数据(多个)")
    public RestResponse deleteSomeDetail(@RequestBody List<AssetExamineDetail> assetExamineDetail) {
        assetExamineDetailService.deleteAssetExaminesDetails(assetExamineDetail);
        return RestResponse.success();
    }

    public static Date getNowDate(){
        SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
        String s = formater.format(new Date());
        Date nowDate = null;
        try {
            nowDate = formater.parse(s);
        } catch (Exception e){
            e.getMessage();
        }
        return nowDate;
    }
}
