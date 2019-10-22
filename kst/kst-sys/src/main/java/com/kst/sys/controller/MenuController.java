package com.kst.sys.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.common.enums.SysMenuType;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Menu;
import com.kst.sys.api.service.IMenuService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by zjf on 2017/12/3.
 * todo:
 */
@Controller
@RequestMapping("sys/menu")
public class MenuController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(MenuController.class);

    @Autowired
    private IMenuService menuService;

    @GetMapping("list")
    @RequiresPermissions("sys:menu:list")
    @SysLog("跳转菜单列表")
    public String list(Model model){
        return "sys/menu/list";
    }


    @PostMapping("tree")
    @ResponseBody
    public RestResponse tree(){
        List<ZtreeVO> ztreeVOs = menuService.showTreeMenus();
        LOGGER.info(JSONObject.toJSONString(ztreeVOs));
        return RestResponse.success().setData(ztreeVOs);
    }

    @PostMapping("treelist")
    @ResponseBody
    public String treelist(){
        //Map<String,Object> map = Maps.newHashMap();
        //map.put("parentId",null);

        //List<Menu> menus = menuService.selectAllMenus(map);
        QueryWrapper<Menu> userQueryWrapper = new QueryWrapper<>();
        userQueryWrapper.eq("del_flag",false);
        userQueryWrapper.orderByAsc("sort");
        List<Menu> menus = menuService.list(userQueryWrapper);
        return JSON.toJSONString(menus);
    }

    @RequiresPermissions("sys:menu:add")
    @GetMapping("add")
    public String add(@RequestParam(value = "parentId",required = false) Long parentId, Model model){
        if(parentId != null){
            Menu menu = menuService.getById(parentId);
            model.addAttribute("parentMenu",menu);
        }
        model.addAttribute("menuTypes", SysMenuType.values());
        return "sys/menu/detail";
    }

    @PostMapping("add")
    @ResponseBody
    @SysLog("保存新增菜单数据")
    public RestResponse add(@RequestBody Menu menu){
        if(menu.getParentId() == null){
            menu.setLevel(1);
        }else{
            Menu parentMenu = menuService.getById(menu.getParentId());
            if(parentMenu==null){
                return RestResponse.failure("noFather");//父菜单不存在
            }
            menu.setParentIds(parentMenu.getParentIds());
            menu.setLevel(parentMenu.getLevel()+1);
        }
        menuService.saveOrUpdateMenu(menu);
        menu.setParentIds(StringUtils.isBlank(menu.getParentIds())?menu.getId()+",":menu.getParentIds()+menu.getId()+",");
        menuService.saveOrUpdateMenu(menu);
        return RestResponse.success();
    }

    @RequiresPermissions("sys:menu:edit")
    @GetMapping("edit")
    public String edit(Long id, Model model){
        Menu menu = menuService.getById(id);
        Menu parentMenu=menuService.getById(menu.getParentId());
        model.addAttribute("menu",menu);
        model.addAttribute("menuTypes", SysMenuType.values());
        model.addAttribute("parentMenu",parentMenu);
       return "sys/menu/detail";
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存编辑菜单数据")
    public RestResponse edit(@RequestBody Menu menu){
        menuService.saveOrUpdateMenu(menu);
        return RestResponse.success();
    }

    @PostMapping("checkPermissionExist/{mode}")
    @ResponseBody
    @SysLog("权限标识存在验证")
    public RestResponse checkPermissionExist(@PathVariable("mode") Integer mode, String permission, Long id){
        boolean result = true;

        if (1 == mode) {    //新增场合
            if(StringUtils.isNotBlank(permission)){
                if(menuService.getCountByPermission(permission)>0){
                    result = false;
                }
            }
        }else if (2 == mode) {  //编辑场合
            if (StringUtils.isNotBlank(permission)) {
                Menu oldMenu = menuService.getById(id);
                if(!oldMenu.getPermission().equals(permission)) {
                    if (menuService.getCountByPermission(permission) > 0) {
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @PostMapping("checkPermissionNameExist/{mode}")
    @ResponseBody
    @SysLog("权限名称存在验证")
    public RestResponse checkPermissionNameExist(@PathVariable("mode") Integer mode, String name, Long id){
        boolean result = true;

        if (1 == mode) {    //新增场合
            if(menuService.getCountByName(name)>0){
                result = false;
            }
        }else if (2 == mode) {  //编辑场合
            Menu oldMenu = menuService.getById(id);
            if(!oldMenu.getName().equals(name)) {
                if(menuService.getCountByName(name)>0){
                    result = false;
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @RequiresPermissions("sys:menu:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除菜单")
    public RestResponse delete(@RequestParam(value = "id",required = false)Long id){
        if(id == null){
            return RestResponse.failure("菜单ID不能为空");
        }
        Menu menu = menuService.getById(id);

        QueryWrapper<Menu> menuQueryWrapper = new QueryWrapper<>();
        menuQueryWrapper.likeRight("parent_ids",menu.getParentIds());
        List<Menu> menus =  menuService.list(menuQueryWrapper);
        menuService.deleteMenuByIds(menus);

        /*menu.setDelFlag(true);
        menuService.saveOrUpdateMenu(menu);*/
        return RestResponse.success();
    }

    @PostMapping("isShow")
    @ResponseBody
    public RestResponse isShow(@RequestParam(value = "id",required = false)Long id,
                               @RequestParam(value = "isShow",required = false)String isShow){
        if(id == null){
            return RestResponse.failure("菜单ID不能为空");
        }
        if(isShow == null){
            return RestResponse.failure("设置参数不能为空");
        }else{
            if(!"true".equals(isShow) && !"false".equals(isShow)){
                return RestResponse.failure("设置参数不正确");
            }
        }
        Boolean showFlag = Boolean.valueOf(isShow);
        Menu menu = menuService.getById(id);
        menu.setShowFlag(showFlag);
        menuService.saveOrUpdateMenu(menu);
        return RestResponse.success();

    }

}
