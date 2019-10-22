package com.kst.pjs.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.sys.api.entity.User;
import com.kst.pjs.entity.PjsUserGroup;
import com.kst.sys.api.vo.UserVO;

import java.util.List;
import java.util.Map;

public interface IPjsUserGroupService extends IBaseService<PjsUserGroup> {

    List<ZtreeVO> selectAllUserGroup();

    PjsUserGroup selectUserGroupById(Long id);

    Integer insertUserGroup(PjsUserGroup userGroup);

    Integer selectNameIsExist(PjsUserGroup userGroup);

    DataTable<UserVO> selectUserByPage(DataTable dt);

    Integer insertUserToUserGroup(Long groupId, Long userId);

    Integer deleteUserFromUserGroup(Long groupId, Long userId);

    List<UserVO> selectAllUserAndUserGroup(List<User> list);

    List<UserVO> selectUserOfUserGroup(Map<String, Object> params);

}
