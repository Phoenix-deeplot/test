package com.kst.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.service.impl.BaseService;
import com.kst.sys.api.entity.Menu;
import com.kst.sys.api.entity.Role;
import com.kst.sys.mapper.RoleMapper;
import com.kst.sys.api.service.IRoleService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class RoleServiceImpl extends BaseService<RoleMapper, Role> implements IRoleService {

    @Caching(
            put = {@CachePut(value = "role",key = "'role_id_'+T(String).valueOf(#result.id)",condition = "#result.id != null and #result.id != 0")},
            evict = {@CacheEvict(value = "roleAll",key = "'roleAll'" )
    })
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public Role saveRole(Role role) {
        baseMapper.insert(role);
        if(role.getMenuSet().size()>0) {
            baseMapper.saveRoleMenus(role.getId(), role.getMenuSet());
        }
        return role;
    }

    @Cacheable(value = "role",key = "'role_id_'+T(String).valueOf(#id)",unless = "#result == null")
    @Override
    public Role getRoleById(Long id) {
        Role role = baseMapper.selectRoleById(id);
        return role;
    }

    @Caching(evict = {
            @CacheEvict(value = "role",key = "'role_id_'+T(String).valueOf(#role.id)" ),
            @CacheEvict(value = "roleAll",key = "'roleAll'" ),
            @CacheEvict(value = "user",allEntries=true ),
            @CacheEvict(value = "allMenus",allEntries = true)
    })
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void updateRole(Role role) {
        baseMapper.updateById(role);
        baseMapper.dropRoleMenus(role.getId());
        if(role.getMenuSet().size()>0) {
            baseMapper.saveRoleMenus(role.getId(), role.getMenuSet());
        }
    }

    @Caching(evict = {
            @CacheEvict(value = "role",key = "'role_id_'+T(String).valueOf(#role.id)" ),
            @CacheEvict(value = "roleAll",key = "'roleAll'" ),
            @CacheEvict(value = "user",allEntries=true )
    })
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteRole(Role role) {
        role.setDelFlag(true);
        baseMapper.updateById(role);
        baseMapper.dropRoleMenus(role.getId());
        baseMapper.dropRoleUsers(role.getId());
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void saveRoleMenus(Long id, Set<Menu> menuSet) {
        baseMapper.saveRoleMenus(id,menuSet);
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void dropRoleMenus(Long id) {
        baseMapper.dropRoleMenus(id);
    }

    @Override
    public Integer getRoleNameCount(String name) {
        QueryWrapper<Role> wrapper = new QueryWrapper<>();
        wrapper.eq("name",name);
        return baseMapper.selectCount(wrapper);
    }

    @Cacheable(value = "roleAll",key = "'roleAll'",unless = "#result == null or #result.size() == 0")
    @Override
    public List<Role> selectAll() {
        QueryWrapper<Role> wrapper = new QueryWrapper<>();
        wrapper.eq("del_flag",false);
        List<Role> roleList = baseMapper.selectList(wrapper);
        return roleList;
    }
}
