package com.kst.sys.controller;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Menu;
import com.kst.sys.api.entity.Role;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IMenuService;
import com.kst.sys.api.service.IRoleService;
import com.kst.sys.api.service.IUserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

/**
 * Created by zjf on 2017/12/2.
 * todo:
 */
@Controller
@RequestMapping("sys/role")
public class RoleController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(RoleController.class);

    @Autowired
    private IRoleService roleService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IMenuService menuService;

    @GetMapping("list")
    @RequiresPermissions("sys:role:list")
    @SysLog("跳转角色列表页面")
    public String list(){
        return "sys/role/list";
    }


    @PostMapping("list")
    @ResponseBody
    public DataTable<Role> list(@RequestBody DataTable dt){
        /*JSONObject searchParams = JSONArray.parseObject(request.getParameter("searchParams"));
        EntityWrapper<Role> roleEntityWrapper = new EntityWrapper<>();
        for(String str:searchParams.keySet()){
            roleEntityWrapper.like(str.substring(2),searchParams.get(str).toString());
        }
        roleEntityWrapper.eq("del_flag",false);
        Page<Role> rolePage = roleService.selectPage(new Page<>(pageNumber,pageSize),roleEntityWrapper);
        int count = roleService.selectCount(roleEntityWrapper);

        //bootstrap-table要求服务器返回的json须包含：total，rows
        Map<String, Object> resObj  = new HashMap<String, Object>();
        resObj .put("total", count);
        resObj .put("rows", setUserToRole(rolePage.getRecords()));
        return new JsonResult(resObj);*/
        return roleService.pageSearch(dt);
    }

//    private List<Role> setUserToRole(List<Role> roles){
//        for(Role r : roles){
//            if(r.getCreateId() != null && r.getCreateId() != ""){
//                User u = userService.findUserById(r.getCreateId());
//                if(StringUtils.isBlank(u.getNickName())){
//                    u.setNickName(u.getLoginName());
//                }
//                //r.setCreateUser(u);
//            }
//            if(r.getUpdateId() != null && r.getUpdateId() != ""){
//                User u  = userService.findUserById(r.getUpdateId());
//                if(StringUtils.isBlank(u.getNickName())){
//                    u.setNickName(u.getLoginName());
//                }
//                //r.setUpdateUser(u);
//            }
//        }
//        return roles;
//    }

    @GetMapping("add")
    @RequiresPermissions("sys:role:add")
    public String add(Model model){
        List<Long> menuIds = Lists.newArrayList();
        List<ZtreeVO> menuList = menuService.showTreeMenus();
        model.addAttribute("menuList",JSONObject.toJSONString(menuList));
        model.addAttribute("menuIds",JSONObject.toJSONString(menuIds));
        return "sys/role/detail";
    }

    @PostMapping("add")
    @ResponseBody
    @SysLog("保存新增角色数据")
    public RestResponse add(@RequestBody Role role){
        roleService.saveRole(role);
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    @RequiresPermissions("sys:role:edit")
    public String edit(@PathVariable("id") Long id, Model model){
        Role role = roleService.getRoleById(id);
        //StringBuilder menuIds = new StringBuilder();
        List<Long> menuIds = Lists.newArrayList();
        if(role != null) {
            Set<Menu> menuSet = role.getMenuSet();
            if (menuSet != null && menuSet.size() > 0) {
                for (Menu m : menuSet) {
                    //menuIds.append(m.getId().toString()).append(",");
                    menuIds.add(m.getId());
                }
            }
        }
        /*Map<String,Object> map = Maps.newHashMap();
        map.put("parentId",null);
        map.put("isShow",false);
        List<Menu> menuList = menuService.selectAllMenus(map);*/
        List<ZtreeVO> menuList = menuService.showTreeMenus();
        model.addAttribute("role",role);
        model.addAttribute("menuList",JSONObject.toJSONString(menuList));
        model.addAttribute("menuIds",JSONObject.toJSONString(menuIds));
        return "sys/role/detail";
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存编辑角色数据")
    public RestResponse edit(@RequestBody Role role){
        roleService.updateRole(role);
        return RestResponse.success();
    }


    @PostMapping("checkRoleNameExist/{mode}")
    @ResponseBody
    @SysLog("角色名存在验证")
    public RestResponse checkRoleNameExist(@PathVariable("mode") Integer mode, String name, Long id){
        boolean result = true;
        if (1 == mode) {    //新增场合
            if(roleService.getRoleNameCount(name)>0){
                result = false;
            }
        }else if (2 == mode) {  //编辑场合
            Role oldRole = roleService.getRoleById(id);
            if(StringUtils.isNotBlank(name)){
                if(!oldRole.getName().equals(oldRole.getName())){
                    if(roleService.getRoleNameCount(name)>0){
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @RequiresPermissions("sys:role:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除角色数据")
    public RestResponse delete(@RequestParam(value = "id",required = false)Long id){
        Role role = roleService.getRoleById(id);
        roleService.deleteRole(role);
        return RestResponse.success();
    }

    @RequiresPermissions("sys:role:delete")
    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("多选删除角色数据")
    public RestResponse deleteSome(@RequestBody List<Role> roles){
        for (Role r : roles){
            roleService.deleteRole(r);
        }
        return RestResponse.success();
    }


}
