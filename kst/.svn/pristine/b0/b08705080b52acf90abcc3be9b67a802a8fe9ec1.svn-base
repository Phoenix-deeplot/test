package com.kst.pjs.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.pjs.entity.*;
import com.kst.pjs.service.*;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.UserGroup;
import com.kst.sys.api.service.IDictService;
import com.kst.sys.api.service.IOrganizationService;
import com.kst.sys.api.service.IUserGroupService;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 项目信息控制器
 */
@Controller
@RequestMapping("pjs/project")
public class ProjectController {

    @Autowired
    private IDictService dictService;

    @Autowired
    private IPjMainService pjMainService;

    @Autowired
    private IPjFactInfoService pjFactInfoService;

    @Autowired
    private IProjectHistoryService projectHistoryService;

    @Autowired
    private IPjKindService pjKindService;

    @Autowired
    private IProjectGroupService projectGroupService;

    @Autowired
    private IOrganizationService organizationService;

    @Autowired
    private IUserGroupService userGroupService;

    @GetMapping("list")
    @RequiresPermissions("pjs:project:list")
    @SysLog("转跳项目管理主页")
    public String list(Model model){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","pjs_pj_status");
        wrapper.eq("del_flag",false);
        model.addAttribute("status",this.dictService.list(wrapper));
        return "project/list";
    }

    @PostMapping("list")
    @ResponseBody
    @SysLog("分页查询项目信息")
    public DataTable<PjMain> list(@RequestBody DataTable dt){
        this.pjMainService.selectPjMainByPage(dt);
        return dt;
    }

    @GetMapping("add")
    @SysLog("进入添加项目页面")
    public String add(Model model){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","pjs_pj_status");
        wrapper.eq("del_flag",false);
        List<Dict> status=this.dictService.list(wrapper);

        wrapper=new QueryWrapper();
        wrapper.eq("type","pjs_kind_type");
        List<Dict> kindFlg=this.dictService.list(wrapper);
        model.addAttribute("status",status);
        model.addAttribute("kindFlg",kindFlg);
        return "project/detail";
    }

    /**
     * 新增
     * @param params 页面传递的新增对象
     */
    @PostMapping("add")
    @ResponseBody
    public RestResponse add(@RequestParam Map<String,Object> params){
        //格式化日期类型
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[]{"yyyy-MM-dd hh:mm:ss", "yyyy-MM-dd HH:mm:ss"}));
        PjMain main=(PjMain)JSONObject.toBean(JSONObject.fromObject(params.get("main")),PjMain.class);
        this.pjMainService.save(main);//保存main信息
        PjFactInfo factInfo=(PjFactInfo)JSONObject.toBean(JSONObject.fromObject(params.get("factInfo")),PjFactInfo.class);
        factInfo.setPjId(main.getId());

        UserGroup userGroup=new UserGroup();
        userGroup.setName(main.getName()+"项目组");
        userGroup.setGroupStatus("1");
        userGroup.setLevel(1);
        this.userGroupService.insertUserGroup(userGroup);
        factInfo.setUserGroupId(userGroup.getId());
        this.pjFactInfoService.save(factInfo);//保存factinfo信息

        JSONArray arr=JSONArray.fromObject(params.get("kinds"));

        //循环保存kind信息
        for (Object o:arr){
            JSONObject jsonObject2 = JSONObject.fromObject(o);
            PjKind k=(PjKind)JSONObject.toBean(jsonObject2,PjKind.class);
            k.setPjId(main.getId());
            this.pjKindService.save(k);
        }


        //添加体制成员
        String[] nodes=((String)params.get("nodes")).split(",");
        for (String node:nodes){
            if(node!=null && !node.equals("")){
                ProjectGroup p=this.projectGroupService.getById(node);
                p.setPjId(main.getId());
                this.projectGroupService.updateById(p);
                this.userGroupService.insertUserToUserGroup(userGroup.getId(),p.getUserId());
            }
        }
        return RestResponse.success();
    }

    /**
     * 修改页面
     * @param pjId 项目id
     * @return
     */
    @GetMapping("edit/{id}")
    @SysLog("进入项目修改页面")
    public String edit(Model model,@PathVariable("id") Long pjId){
        PjMain main=this.pjMainService.getById(pjId);
        main.setOrganizationName(this.organizationService.getById(main.getOrganizationId()).getName());

        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","pjs_pj_status");
        wrapper.eq("del_flag",false);
        List<Dict> status=this.dictService.list(wrapper);

        wrapper=new QueryWrapper();
        wrapper.eq("type","pjs_kind_type");
        wrapper.eq("del_flag",false);
        List<Dict> kindFlg=this.dictService.list(wrapper);

        wrapper=new QueryWrapper();
        wrapper.eq("pj_id",pjId);
        wrapper.eq("del_flag",false);
        PjFactInfo factInfo=this.pjFactInfoService.getOne(wrapper);

        model.addAttribute("main",main);
        model.addAttribute("status",status);
        model.addAttribute("kindFlg",kindFlg);
        model.addAttribute("factInfo",factInfo);

        return "project/detail";
    }

    /**
     * 修改
     * @param params 页面传递的对象
     * @return
     */
    @PostMapping("edit")
    @ResponseBody
    public RestResponse edit(@RequestParam Map<String,Object> params){
        //格式化json数据里的日期
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[]{"yyyy-MM-dd hh:mm:ss", "yyyy-MM-dd HH:mm:ss"}));
        PjMain main=(PjMain)JSONObject.toBean( JSONObject.fromObject(params.get("main")),PjMain.class);
        this.pjMainService.updateById(main);
        PjFactInfo factInfo=(PjFactInfo)JSONObject.toBean(JSONObject.fromObject(params.get("factInfo")),PjFactInfo.class);
        this.pjFactInfoService.updateById(factInfo);

        //添加kind信息
        JSONArray arr=JSONArray.fromObject(params.get("kinds"));
        for (Object o:arr){
            JSONObject jsonObject2 = JSONObject.fromObject(o);
            PjKind k=(PjKind)JSONObject.toBean(jsonObject2,PjKind.class);
            k.setPjId(main.getId());
            System.out.println(JSON.toJSONString(k));
            this.pjKindService.saveOrUpdate(k);
        }

        //删除kind信息
        String[] dels=((String) params.get("delKind")).split(",");
        for (String id:dels){
            if(id!="" && id!=null){
                PjKind k=this.pjKindService.getById(Long.parseLong(id));
                k.setDelFlag(true);
                this.pjKindService.updateById(k);
            }
        }
        return RestResponse.success();
    }

    /**
     * 删除项目
     * @param id 项目id
     * @return
     */
    @PostMapping("delete")
    @ResponseBody
    public RestResponse delete(Long id){
        PjMain main=this.pjMainService.getById(id);
        main.setDelFlag(true);
        if(!this.pjMainService.updateById(main)){
            return RestResponse.failure("删除失败");
        }
        return RestResponse.success();
    }

    /**
     * 删除kind
     * @param id kind编号
     * @return
     */
    @PostMapping("deleteKind")
    @ResponseBody
    public RestResponse deleteKind(Long id){
        PjKind kind=this.pjKindService.getById(id);
        kind.setDelFlag(true);
        if(!this.pjKindService.updateById(kind)){
            return RestResponse.failure("删除失败");
        }
        return RestResponse.success();
    }
    /**
     * 查询kind
     * @param id kind编号
     * @return
     */
    @PostMapping("selectKinds")
    @ResponseBody
    public List<PjKind> selectKinds(Long id){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("pj_id",id);
        wrapper.eq("del_flag",false);
        wrapper.orderByAsc("pj_king_flg");
        wrapper.orderByAsc("pj_kind_id");
        return this.pjKindService.list(wrapper);
    }

    @GetMapping("projectChart/{pjId}")
    @SysLog("进入项目图表统计页面")
    public String projectChart(@PathVariable("pjId") String pjId,Model model){
        model.addAttribute("pjId",pjId);
        return "project/chart";
    }

    /**
     *
     * @param pjId 项目id
     * @return 项目历史进度统计
     */
    @PostMapping("projectChart")
    @ResponseBody
    public List<ProjectHistory> projectChart(Long pjId){
        //加载projectHistory 信息用于生成图表
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("pj_id",pjId);
        wrapper.eq("del_flag",false);
        wrapper.orderByAsc("date");
        return this.projectHistoryService.list(wrapper);
    }

}
