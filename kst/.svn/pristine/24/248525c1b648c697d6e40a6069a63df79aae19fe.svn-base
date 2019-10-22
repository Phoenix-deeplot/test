package com.kst.sys.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Organization;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IOrganizationService;
import com.kst.sys.api.service.IUserService;
import com.kst.sys.api.vo.OrganizationVO;
import com.kst.sys.api.vo.UserVO;
import net.sf.json.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("sys/organization")
public class OrganizationController extends BaseController {

    @Autowired
    IOrganizationService organizationService;

    @Autowired
    IUserService userService;

    @GetMapping("list")
    @RequiresPermissions("sys:organization:list")
    @SysLog("跳转组织列表页面")
    public String list() {
        return "sys/organization/list";
    }

    @PostMapping("list")
    @ResponseBody
    //加载初始树形菜单
    public List<ZtreeVO> tree() {
        List<ZtreeVO> list = organizationService.selectAll();
        return list;
    }

    @PostMapping("selectById")
    @ResponseBody
    public OrganizationVO selectById(Long id) {
        return organizationService.selectOrganizationById(id);
    }

    @PostMapping("update")
    @ResponseBody
    @SysLog("保存修改组织数据")
    public RestResponse updateOrganization(@RequestBody Organization organization) {
        if (!organizationService.updateById(organization)) {
            return RestResponse.failure("edit");
        }
        return RestResponse.success();
    }

    @PostMapping("insert")
    @ResponseBody
    @SysLog("保存添加组织数据")
    public RestResponse insertOrganization(@RequestBody Organization organization) {
        organizationService.insertOrganization(organization);
        if (organization.getId() == null || organization.getId() == 0) {
            return RestResponse.failure("add");
        }
        return RestResponse.success();
    }

    @PostMapping("delete")
    @RequiresPermissions("sys:organization:delete")
    @ResponseBody
    @SysLog("删除组织数据")
    public RestResponse deleteOrganization(@RequestBody Organization organization) {
        Organization g = (Organization) JSONObject.toBean(JSONObject.fromObject(organization), Organization.class);
        System.out.println(g.getId() + "   " + g.getParentIds());

        QueryWrapper<Organization> wrapper = new QueryWrapper<>();
        if (organization.getId() == null || organization.getId() == 0) {
            return RestResponse.failure("");
        }

        if (organization.getLevel() == 1) {
            wrapper.likeRight("parent_ids", organization.getId() + ",");
        } else {
            wrapper.like("parent_ids", "," + organization.getId() + ",");
        }
        Organization organization1 = new Organization();
        organization1.setDelFlag(true);
        organization1.setSort(null);

        this.organizationService.update(organization1, wrapper);
        this.organizationService.deleteUserFromOrganization(organization.getId(), null);
        return RestResponse.success();
    }

    @PostMapping("checkOrganizationName")
    @ResponseBody
    @SysLog("组织名称重复验证")
    public RestResponse checkOrganizationName(Long sub, String name, Long id, Long parentId) {
        boolean result = true;
        Organization organization = new Organization();
        organization.setParentId(parentId);
        organization.setName(name);
        organization.setId(id);

        System.out.print("parentId:" + parentId + "id:" + id);
        Integer i = organizationService.selectNameIsExist(organization);
        if (i > 0) {
            //组织名已经存在
            result = false;
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @GetMapping("add/{id}")
    @RequiresPermissions("sys:organization:add")
    public String add(@PathVariable("id") Long id, Model model) {
        OrganizationVO vo = organizationService.selectOrganizationById(id);
        OrganizationVO g2 = new OrganizationVO();
        g2.setParentName(vo.getName());
        g2.setLevel(vo.getLevel() + 1);
        g2.setSort(null);
        g2.setParentId(vo.getId());
        model.addAttribute("organization", g2);

        return "sys/organization/detail";
    }

    @GetMapping("addRoot")
    @RequiresPermissions("sys:organization:add")
    public String addRoot(Model model) {
        OrganizationVO vo = new OrganizationVO();
        vo.setLevel(1);
        vo.setSort(null);
        model.addAttribute("organization", vo);
        return "sys/organization/detail";
    }

    @RequiresPermissions("sys:organization:update")
    @GetMapping("edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model) {
        OrganizationVO vo = organizationService.selectOrganizationById(id);
        model.addAttribute("organization", vo);
        return "sys/organization/detail";
    }

    @PostMapping("loadUser")
    @ResponseBody
    //加载组织用户
    public DataTable<UserVO> loadUser(@RequestBody DataTable dt) {
        DataTable<UserVO> users = new DataTable<UserVO>();
        if (dt.getSearchParams().size() == 0) {
            System.out.println("为空");
        } else {
            users = organizationService.selectUserByPage(dt);
        }
        return users;
    }

    @PostMapping("deleteOneUser")
    @ResponseBody
    @SysLog("删除组织的单个成员")
    public RestResponse deleteOne(Long userId, Long organizationId) {
        organizationService.deleteUserFromOrganization(organizationId, userId);
        return RestResponse.success();
    }


    @PostMapping("deleteSomeUser")
    @ResponseBody
    @SysLog("删除组织的多个成员")
    public RestResponse deleteSomeUser(@RequestBody List<Map<String, Long>> list) {
        for (Map<String, Long> ou : list) {
            System.out.println(ou.get("organizationId") + "  " + ou.get("userId"));
            organizationService.deleteUserFromOrganization(ou.get("organizationId"), ou.get("userId"));
        }
        return RestResponse.success();
    }

    @GetMapping("addUserToOrganization/{organId}")
    public String addUserToOrganization(Model model, @PathVariable("organId") Long id) {
        model.addAttribute("organizationId", id);
        return "sys/organization/allotUser";
    }


    @PostMapping("selectInorganizationUser")
    @ResponseBody()
    public DataTable<UserVO> selectInorganizationUser() {
        DataTable<UserVO> users = new DataTable<UserVO>();
        List<UserVO> list = organizationService.selectInorganizationUser();
        users.setRows(list);
        users.setTotal(list.size());
        return users;
    }

    @PostMapping("addUserToOrganization")
    @ResponseBody
    @SysLog("添加组织用户")
    public RestResponse addUserToOrgan(@RequestBody List<UserVO> list) {
        for (UserVO u : list) {
            organizationService.insertUserToOrganization(u.getOrganizationId(), u.getId());
        }
        return RestResponse.success();
    }

    @PostMapping("selectAllUserAndOrgan")
    @ResponseBody
    public List<UserVO> selectAllUserAndOrgan(@RequestBody List<User> list) {
        Map<String, Object> params = new HashMap<>();
        params.put("userIds", list);
        return this.organizationService.selectAllUserAndOrgan(params);
    }

    @PostMapping("selectUserByOrganIds")
    @ResponseBody
    public List<UserVO> selectUserByOrganIds(@RequestBody List<Long> organIds) {
        Map<String, Object> params = new HashMap<>();
        params.put("organIds", organIds);
        return this.organizationService.selectAllUserAndOrgan(params);
    }

    @PostMapping("moveNode")
    @ResponseBody
    public void moveNode(Long parentId, String childNodes, Long moveNodeId) {
        //查询移动后的父节点信息
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("id", parentId);
        Organization organ = this.organizationService.getOne(wrapper);

        //查询移动的节点信息
        wrapper = new QueryWrapper();
        wrapper.eq("id", moveNodeId);
        Organization moveOrgan = this.organizationService.getOne(wrapper);
        String oldParentIds = moveOrgan.getParentIds();
        Integer level= 0;//移动前后节点级别的改动
        if(organ==null){
            //如果没有父节点 则移动后为根节点
            level=1-moveOrgan.getLevel();
            moveOrgan.setParentId(null);
            moveOrgan.setParentIds(moveOrgan.getId() + ",");
            moveOrgan.setLevel(1);
        }else{
            level=organ.getLevel()+1-moveOrgan.getLevel();
            moveOrgan.setParentId(organ.getId());
            moveOrgan.setParentIds(organ.getParentIds() + moveOrgan.getId() + ",");
            moveOrgan.setLevel(organ.getLevel()+1);
        }

        //修改用户组信息
        this.organizationService.updateById(moveOrgan);

        //查询子节点信息
        wrapper = new QueryWrapper();
        wrapper.in("id", childNodes.split(","));
        List<Organization> list = this.organizationService.list(wrapper);
        //循环修改子节点信息
        for (Organization o : list) {
            if (o.getId() != moveNodeId) {
                o.setParentIds(moveOrgan.getParentIds() + o.getParentIds().substring(oldParentIds.length()));
                o.setLevel(o.getLevel()+level);
                this.organizationService.updateById(o);
            }
        }
    }

}
