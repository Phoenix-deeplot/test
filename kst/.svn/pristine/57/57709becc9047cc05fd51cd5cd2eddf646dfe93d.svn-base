package com.kst.pjs.controller;

import com.alibaba.fastjson.JSON;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.pjs.service.IPjsUserGroupService;
import com.kst.sys.api.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("pjs/userGroup")
public class PjsUserGroupController extends BaseController{

    @Autowired
    private IPjsUserGroupService userGroupService;

    @PostMapping("loadUser")
    @ResponseBody
    //加载组织用户
    public DataTable<UserVO> loadUser(@RequestBody DataTable dt){
        DataTable<UserVO> users=new DataTable<UserVO>();
        if(dt.getSearchParams().size()==0){
        }else{
            users=userGroupService.selectUserByPage(dt);
            System.out.println("用户："+ JSON.toJSONString(users));
        }
        return users;
    }

    @PostMapping("addUserToUserGroup")
    @ResponseBody
    public RestResponse addUserToOrgan(@RequestBody List<UserVO> list){
        System.out.println("添加用户到用户组"+list.size());
        for (UserVO u:list){
            userGroupService.insertUserToUserGroup(u.getOrganizationId(),u.getId());
        }
        return RestResponse.success();
    }

    @PostMapping("deleteSomeUser")
    @ResponseBody
    public RestResponse deleteSomeUser(@RequestBody List<Map<String,Long>> list){
        for (Map<String,Long> ou:list){
            userGroupService.deleteUserFromUserGroup(ou.get("userGroupId"),ou.get("userId"));
        }
        return RestResponse.success();
    }

}
