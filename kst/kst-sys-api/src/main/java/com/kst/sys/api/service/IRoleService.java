package com.kst.sys.api.service;

import com.kst.common.base.service.IBaseService;
import com.kst.sys.api.entity.Menu;
import com.kst.sys.api.entity.Role;

import java.util.List;
import java.util.Set;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
public interface IRoleService extends IBaseService<Role> {

    Role saveRole(Role role);

    Role getRoleById(Long id);

    void updateRole(Role role);

    void deleteRole(Role role);

    void saveRoleMenus(Long id, Set<Menu> menuSet);

    void dropRoleMenus(Long id);

    Integer getRoleNameCount(String name);

    List<Role> selectAll();
	
}
