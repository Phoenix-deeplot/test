package com.kst.sys.api.service;

import com.kst.common.base.service.IBaseService;
import com.kst.sys.api.entity.Role;
import com.kst.sys.api.entity.User;

import java.util.Map;
import java.util.Set;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */

public interface IUserService extends IBaseService<User> {
	User findUserByLoginName(String name);

	User findUserById(Long id);

	User saveUser(User user);

	User updateUser(User user);

	void saveUserRoles(Long id, Set<Role> roleSet);

	void dropUserRolesByUserId(Long id);

	int userCount(String key, String value);

	void deleteUser(User user);

	Map selectUserMenuCount();
}
