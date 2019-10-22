package com.kst.pjs.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.Query;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.pjs.entity.PjFactInfo;
import com.kst.pjs.entity.ProjectGroup;
import com.kst.pjs.service.IPjFactInfoService;
import com.kst.pjs.service.IProjectGroupService;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.entity.UserGroup;
import com.kst.sys.api.service.IOrganizationService;
import com.kst.sys.api.service.IUserGroupService;
import com.kst.sys.api.service.IUserService;
import com.kst.sys.api.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 项目体制控制器
 */
@Controller
@RequestMapping("pjs/projectGroup")
public class ProjectGroupController {

    @Autowired
    private IProjectGroupService projectGroupService;

    @Autowired
    private IUserGroupService userGroupService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IOrganizationService organizationService;

    @Autowired
    private IPjFactInfoService pjFactInfoService;

    /**
     * 加载项目体制信息
     * @param id 项目id
     * @return
     */
    @PostMapping("ztree")
    @ResponseBody
    public List<ZtreeVO> ztree(Long id){
        if(id==null){
            id=Long.valueOf(String.valueOf(0));
        }
        Map<String,Object> params=new HashMap<>();
        params.put("pjId",id);
        return this.projectGroupService.selectProjectGroupTree(params);
    }

    @GetMapping("addRootNode")
    @SysLog("进入添加项目体制根目录页面")
    public String addRootNode(Model model){
        ProjectGroup projectGroup=new ProjectGroup();
        projectGroup.setLevel(1);
        projectGroup.setSort(null);
        model.addAttribute("projectGroup",projectGroup);
        return "/project/groupDetail";
    }

    @GetMapping("addChildNode/{id}")
    @SysLog("进入添加项目体制子目录页面")
    public String addChildNode(@PathVariable("id") Long id, Model model){
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        ProjectGroup g=this.projectGroupService.selectProjectGroup(params).get(0);
        ProjectGroup g2=new ProjectGroup();
        g2.setLevel(g.getLevel()+1);
        g2.setParentId(g.getId());
        g2.setSort(null);
        model.addAttribute("projectGroup",g2);

        return "/project/groupDetail";
    }

    /**
     * 添加节点
     * @param projectGroup 项目体制对象
     * @return
     */
    @PostMapping("addNode")
    @ResponseBody
    public RestResponse addChildNode(@RequestBody ProjectGroup projectGroup){
        if(this.projectGroupService.insertProjectGroup(projectGroup)==0){
            return RestResponse.failure("添加失败");
        }
        return RestResponse.success();
    }

    @GetMapping("editNode/{id}")
    @SysLog("进入修改体制信息节点页面")
    public String editNode(@PathVariable("id") Long id, Model model){
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        ProjectGroup projectGroup=this.projectGroupService.selectProjectGroup(params).get(0);
        model.addAttribute("projectGroup",projectGroup);
        return "/project/groupDetail";
    }

    @PostMapping("editNode")
    @ResponseBody
    //修改节点
    public RestResponse editNode(@RequestBody ProjectGroup projectGroup){
        if(!this.projectGroupService.updateById(projectGroup)){
            return RestResponse.failure("修改失败");
        }
        return RestResponse.success();
    }

    @PostMapping("selectProjectUser")
    @ResponseBody
    public DataTable<User> selectProjectUser(@RequestBody DataTable dt){
        this.projectGroupService.selectProjectGroupUserPage(dt);
        return dt;
    }

    @PostMapping("deleteNode")
    @ResponseBody
    public RestResponse deleteNode(Long id,Long userGroupId,String pjId){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("id",id);
        ProjectGroup projectGroup=this.projectGroupService.getOne(wrapper);
        if(!this.projectGroupService.removeById(id)){
            return RestResponse.failure("删除失败");
        }
        //如果是修改状态，则同时删除用户组内的成员
        if (pjId!=null && !pjId.equals("")){
            this.userGroupService.deleteUserFromUserGroup(userGroupId,projectGroup.getUserId());
        }
       return RestResponse.success();
    }

    @PostMapping("loadUsersNotInProject")
    @ResponseBody
    public DataTable<User> selectUserNotInProjectGroup(@RequestBody DataTable dt){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("pj_id",dt.getSearchParams().get("pjId"));
        List<ProjectGroup> projectGroups=this.projectGroupService.list(wrapper);
        List<Long> ids=new ArrayList<>();
        for (ProjectGroup projectGroup:projectGroups){
            ids.add(projectGroup.getUserId());
        }
        if (ids.size()>0){
            dt.getSearchParams().put("search_not_in_id",ids);
        }
        dt.getSearchParams().remove("pjId");
        this.userService.pageSearch(dt);
        return dt;
    }

    //天假节点
    @PostMapping("addMultiNode")
    @ResponseBody
    public RestResponse addMultiNode(String nodeIds,String pjId,Integer level,String parentIds,Long parentId){
        Map<String,Object> params=new HashMap<>();
        params.put("organIds",nodeIds.split(","));
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("pj_id",pjId);
        List<Long> ids=new ArrayList<>();
        for (ProjectGroup pg:(List<ProjectGroup>)this.projectGroupService.list(wrapper)){
            ids.add(pg.getUserId());
        }

        //循环用户组节点id
        List<UserVO> users=this.organizationService.selectAllUserAndOrgan(params);
        ProjectGroup projectGroup=new ProjectGroup();
        projectGroup.setPjId(Long.parseLong(pjId));
        projectGroup.setPosition("");
        projectGroup.setLevel(level);
        projectGroup.setParentIds(parentIds);
        projectGroup.setParentId(parentId);

        PjFactInfo info=this.pjFactInfoService.getOne(wrapper);

        for (UserVO user:users){
            if(ids.indexOf(user.getId())==-1){
                projectGroup.setUserId(user.getId());
                this.projectGroupService.insertProjectGroup(projectGroup);
                this.userGroupService.insertUserToUserGroup(info.getUserGroupId(),user.getId());
            }
        }
        return RestResponse.success();
    }

}
