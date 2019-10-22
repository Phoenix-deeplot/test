package com.kst.sys.api.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.entity.UserGroup;
import com.kst.sys.api.vo.OrganizationVO;
import com.kst.sys.api.vo.UserVO;

import java.util.List;
import java.util.Map;

public interface IUserGroupService extends IBaseService<UserGroup> {

    List<ZtreeVO> selectAllUserGroup();

    UserGroup selectUserGroupById(Long id);

    Integer insertUserGroup(UserGroup userGroup);

    Integer selectNameIsExist(UserGroup userGroup);

    DataTable<UserVO> selectUserByPage(DataTable dt);

    Integer insertUserToUserGroup(Long groupId,Long userId);

    Integer deleteUserFromUserGroup(Long groupId,Long userId);

    List<UserVO> selectAllUserAndUserGroup(List<User> list);

    List<UserVO> selectUserOfUserGroup(Map<String,Object> params);

}
