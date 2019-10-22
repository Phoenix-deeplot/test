package com.kst.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.sys.api.entity.Role;
import com.kst.sys.api.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;
import java.util.Set;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {

	User selectUserByMap(Map<String, Object> map);

	void saveUserRoles(@Param("userId") Long id, @Param("roleIds") Set<Role> roles);

	void dropUserRolesByUserId(@Param("userId") Long userId);

	Map selectUserMenuCount();
}