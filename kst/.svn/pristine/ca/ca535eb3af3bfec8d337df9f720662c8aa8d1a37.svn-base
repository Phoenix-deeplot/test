package com.kst.pjs.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.pjs.entity.PjsUserGroup;
import com.kst.sys.api.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface PjsUserGroupMapper extends BaseMapper<PjsUserGroup> {

    List<PjsUserGroup> selectUserGroup(Map<String, Object> params);

    Integer selectNameIsExist(PjsUserGroup userGroup);

    List<UserVO> selectUserByPage(DataTable dt);

    Integer selectUserTotal(DataTable dt);

    Integer insertUserToUserGroup(@Param("groupId") Long groupId, @Param("userId") Long userId);

    Integer deleteUserFromUserGroup(@Param("groupId") Long groupId, @Param("userId") Long userId);

    Long selectMaxId();

    List<UserVO> selectUserOfUserGroup(Map<String, Object> params);

}
