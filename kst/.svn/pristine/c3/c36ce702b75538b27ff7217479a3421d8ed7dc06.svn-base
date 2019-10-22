package com.kst.sys.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Organization;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.entity.UserGroup;
import com.kst.sys.api.service.IOrganizationService;
import com.kst.sys.api.service.IUserGroupService;
import com.kst.sys.api.vo.OrganizationVO;
import com.kst.sys.api.vo.UserVO;
import net.sf.json.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("sys/userGroup")
public class UserGroupController {

    @Autowired
    private IUserGroupService userGroupService;

    @Autowired
    private IOrganizationService organizationService;

    @GetMapping("list")
    @RequiresPermissions("sys:userGroup:list")
    @SysLog("转跳用户组管理页面")
    public String list(){
        return "sys/userGroup/list";
    }

    @PostMapping("list")
    @ResponseBody
    public List<ZtreeVO> tree(){
        //查询所有用户组
        return this.userGroupService.selectAllUserGroup();
    }

    @GetMapping("add/{id}")
    @RequiresPermissions("sys:userGroup:add")
    @SysLog("转跳新增用户组页面")
    public String add(@PathVariable("id") Long id, Model model){
        UserGroup vo=userGroupService.selectUserGroupById(id);
        UserGroup g2=new UserGroup();
        g2.setParentName(vo.getName());
        g2.setLevel(vo.getLevel()+1);
        g2.setSort(null);
        g2.setParentId(vo.getId());
        model.addAttribute("userGroup",g2);
        return "sys/userGroup/detail";
    }

    @GetMapping("addRoot")
    @RequiresPermissions("sys:userGroup:add")
    @SysLog("转跳新增根用户组页面")
    public String addRoot(Model model){
        UserGroup vo=new UserGroup();
        vo.setLevel(1);
        vo.setSort(null);
        model.addAttribute("userGroup",vo);
        return "sys/userGroup/detail";
    }

    @GetMapping("edit/{id}")
    @RequiresPermissions("sys:userGroup:edit")
    @SysLog("转跳修改用户组页面")
    public String edit(@PathVariable("id") Long id, Model model){
        UserGroup vo=userGroupService.selectUserGroupById(id);
        model.addAttribute("userGroup",vo);
        return "sys/userGroup/detail";
    }

    @PostMapping("update")
    @ResponseBody
    @SysLog("保存修改用户组数据")
    public RestResponse updateUserGroup(@RequestBody UserGroup userGroup){
        if(!userGroupService.updateById(userGroup)){
            return RestResponse.failure("修改用户组出错");
        }
        return  RestResponse.success();
    }

    @PostMapping("insert")
    @ResponseBody
    @SysLog("保存添加用户组数据")
    public RestResponse insertUserGroup(@RequestBody UserGroup userGroup){
        userGroupService.insertUserGroup(userGroup);
        if(userGroup.getId()==null || userGroup.getId() == 0){
            return RestResponse.failure("添加用户组出错");
        }
        return  RestResponse.success();
    }

    @PostMapping("delete")
    @ResponseBody
    @RequiresPermissions("sys:userGroup:delete")
    @SysLog("删除用户组数据")
    public RestResponse deleteUserGroup(@RequestBody UserGroup userGroup){

        QueryWrapper<UserGroup> wrapper=new QueryWrapper<>();
        if(userGroup.getId()==null || userGroup.getId()==0){
            return  RestResponse.failure("删除用户组出错");
        }


        if (userGroup.getLevel()==1){
            //一级节点
            wrapper.likeRight("parent_ids",userGroup.getId()+",");
        }else{
            //二级以上节点
            wrapper.like("parent_ids",","+userGroup.getId()+",");
        }
        UserGroup userGroup1=new UserGroup();
        userGroup1.setDelFlag(true);
        userGroup1.setSort(null);

        this.userGroupService.update(userGroup1,wrapper);
        this.userGroupService.deleteUserFromUserGroup(userGroup.getId(),null);
        return RestResponse.success();
    }

    @PostMapping("checkUserGroupName")
    @ResponseBody
    @SysLog("组织名称重复验证")
    public RestResponse checkOrganizationName(Long sub,String name, Long id,Long parentId){
        boolean result=true;
        UserGroup userGroup=new UserGroup();
        userGroup.setParentId(parentId);
        userGroup.setName(name);
        userGroup.setId(id);

        Integer i=userGroupService.selectNameIsExist(userGroup);
        if(i>0){
            //组织名已经存在
            result=false;
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @PostMapping("loadUser")
    @ResponseBody
    //加载组织用户
    public DataTable<UserVO> loadUser(@RequestBody DataTable dt){
        DataTable<UserVO> users=new DataTable<UserVO>();
        if(dt.getSearchParams().size()==0){
        }else{
            users=userGroupService.selectUserByPage(dt);
        }
        return users;
    }

    @PostMapping("deleteOneUser")
    @ResponseBody
    @SysLog("删除组织的单个成员")
    public RestResponse deleteOne(Long userId,Long userGroupId){
        userGroupService.deleteUserFromUserGroup(userGroupId,userId);
        return RestResponse.success();
    }


    @PostMapping("deleteSomeUser")
    @ResponseBody
    @SysLog("删除组织的多个成员")
    public RestResponse deleteSomeUser(@RequestBody List<Map<String,Long>> list){
        for (Map<String,Long> ou:list){
            userGroupService.deleteUserFromUserGroup(ou.get("userGroupId"),ou.get("userId"));
        }
        return RestResponse.success();
    }


    @PostMapping("selectInUserGroupUser")
    @ResponseBody()
    public DataTable<UserVO> selectInUserGroupUser(Long groupId){
        //根据用户组编号，分页查询所有相关（在用户组内）的用户信息
        DataTable<UserVO> users=new DataTable<UserVO>();
        Map<String,Object> params=new HashMap<>();
        params.put("groupId",groupId);
        List<UserVO> list=userGroupService.selectUserOfUserGroup(params);
        users.setRows(list);
        users.setTotal(list.size());
        return users;
    }

    //进入分配用户页面
    @GetMapping("addUserToUserGroup/{groupId}")
    public String addUserToOrganization(Model model, @PathVariable("groupId") Long id){
        model.addAttribute("groupId",id);
        return "sys/userGroup/allotUser";
    }

    //将用户添加到用户组内
    @PostMapping("addUserToUserGroup")
    @ResponseBody
    public RestResponse addUserToOrgan(@RequestBody List<UserVO> list){
        System.out.println("添加用户到用户组"+list.size());
        for (UserVO u:list){
            userGroupService.insertUserToUserGroup(u.getOrganizationId(),u.getId());
        }
        return RestResponse.success();
    }

    @GetMapping("choiceUserByGroup")
    public String toChoiceUserByGroup(){
        return "sys/userGroup/choice";
    }

    @PostMapping("loadGroupTree")
    @ResponseBody
    public List<ZtreeVO> loadUserGroupAndOrganization(){
        List<ZtreeVO> organList=this.organizationService.selectAll();
        List<ZtreeVO> userGroupList=this.userGroupService.selectAllUserGroup();

        organList.addAll(userGroupList);
        return organList;
    }

    @PostMapping("selectUserByGroupIds")
    @ResponseBody
    public List<UserVO> selectUserByGroupIds(@RequestBody List<Long> groupIds){
        //根据用户组查询所有用户
        Map<String,Object> params=new HashMap<>();
        params.put("groupIds",groupIds);
        return this.userGroupService.selectUserOfUserGroup(params);
    }

    //移动用户组节点
    @PostMapping("moveNode")
    @ResponseBody
    public void moveNode(Long parentId, String childNodes, Long moveNodeId) {
        //查询移动后的父节点信息
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("id", parentId);
        UserGroup parentGroup = this.userGroupService.getOne(wrapper);

        //查询移动的节点信息
        wrapper = new QueryWrapper();
        wrapper.eq("id", moveNodeId);
        UserGroup moveUserGroup = this.userGroupService.getOne(wrapper);
        String oldParentIds = moveUserGroup.getParentIds();

        Integer level= 0;//移动前后节点级别的改动

        if(parentGroup==null){
            //如果没有父节点 则移动后为根节点
            level=1-moveUserGroup.getLevel();
            moveUserGroup.setParentId(null);
            moveUserGroup.setParentIds(moveUserGroup.getId() + ",");
            moveUserGroup.setLevel(1);
        }else{
            //父节点存在
            level=parentGroup.getLevel()+1-moveUserGroup.getLevel();
            moveUserGroup.setParentId(parentGroup.getId());
            moveUserGroup.setParentIds(parentGroup.getParentIds() + moveUserGroup.getId() + ",");
            moveUserGroup.setLevel(parentGroup.getLevel()+1);
        }

        //修改用户组信息
        this.userGroupService.updateById(moveUserGroup);

        //查询子节点信息
        wrapper = new QueryWrapper();
        wrapper.in("id", childNodes.split(","));
        List<UserGroup> list = this.userGroupService.list(wrapper);

        //循环修改子节点信息
        for (UserGroup o : list) {
            if (o.getId() != moveNodeId) {
                o.setParentIds(moveUserGroup.getParentIds() + o.getParentIds().substring(oldParentIds.length()));
                o.setLevel(o.getLevel()+level);
                this.userGroupService.updateById(o);
            }
        }
    }

}
