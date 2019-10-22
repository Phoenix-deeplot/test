package com.kst.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.sys.api.entity.Menu;
import com.kst.sys.api.entity.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
public interface RoleMapper extends BaseMapper<Role> {

    Role selectRoleById(@Param("id") Long id);

    void saveRoleMenus(@Param("roleId") Long id, @Param("menus") Set<Menu> menus);

    void dropRoleMenus(@Param("roleId") Long roleId);

    void dropRoleUsers(@Param("roleId") Long roleId);
}