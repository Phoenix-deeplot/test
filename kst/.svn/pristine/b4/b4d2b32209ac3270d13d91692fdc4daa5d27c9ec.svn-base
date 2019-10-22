package com.kst.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.UserGroup;
import com.kst.sys.api.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserGroupMapper extends BaseMapper<UserGroup> {

    List<UserGroup> selectUserGroup(Map<String,Object> params);

    Integer selectNameIsExist(UserGroup userGroup);

    List<UserVO> selectUserByPage(DataTable dt);

    Integer selectUserTotal(DataTable dt);

    Integer insertUserToUserGroup(@Param("groupId") Long groupId, @Param("userId") Long userId);

    Integer deleteUserFromUserGroup(@Param("groupId") Long groupId, @Param("userId") Long userId);

    Long selectMaxId();

    List<UserVO> selectUserOfUserGroup(Map<String,Object> params);

}
