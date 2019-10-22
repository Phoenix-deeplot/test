package com.kst.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.sys.api.entity.Menu;
import com.kst.sys.api.vo.ShowMenu;
import com.kst.sys.mapper.MenuMapper;
import com.kst.sys.api.service.IMenuService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

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
public class MenuServiceImpl extends BaseService<MenuMapper, Menu> implements IMenuService {

    @Cacheable(value = "allMenus",key = "'allMenus_isShow_'+#map['isShow'].toString()",unless = "#result == null or #result.size() == 0")
    @Override
    public List<Menu> selectAllMenus(Map<String,Object> map) {
        return baseMapper.getMenus(map);
    }

    @Caching(evict = {
            @CacheEvict(value = "allMenus",allEntries = true),
            @CacheEvict(value = "user",allEntries = true)
    })
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void saveOrUpdateMenu(Menu menu) {
        if(menu.getId()==null){
            menu.setId(this.baseMapper.selectMaxId());
        }
        saveOrUpdate(menu);
    }

    @Override
    public int getCountByPermission(String permission) {
        QueryWrapper<Menu> wrapper = new QueryWrapper<>();
        wrapper.eq("del_flag",false);
        wrapper.eq("permission",permission);
        return baseMapper.selectCount(wrapper);
    }

    @Override
    public int getCountByName(String name) {
        QueryWrapper<Menu> wrapper = new QueryWrapper<>();
        wrapper.eq("del_flag",false);
        wrapper.eq("name",name);
        return baseMapper.selectCount(wrapper);
    }

    @Override
    public List<ZtreeVO> showTreeMenus() {
        QueryWrapper<Menu> wrapper = new QueryWrapper<>();
        wrapper.eq("del_flag",false);
        //wrapper.eq("is_show",true);
        wrapper.orderByDesc("sort");
        List<Menu> totalMenus = baseMapper.selectList(wrapper);
        List<ZtreeVO> ztreeVOs = Lists.newArrayList();
        return getZTree(null,totalMenus,ztreeVOs);
    }

    @Cacheable(value = "allMenus",key = "'user_menu_'+T(String).valueOf(#id)",unless = "#result == null or #result.size() == 0")
    @Override
    public List<ShowMenu> getShowMenuByUser(Long id) {
        Map<String,Object> map = Maps.newHashMap();
        map.put("userId",id);
        map.put("parentId",null);
        return baseMapper.selectShowMenuByUser(map);
    }

    /**
     * 递归拉取菜单树的数据
     */
    private  List<ZtreeVO> getZTree(ZtreeVO tree,List<Menu> total,List<ZtreeVO> result){
        Long pid = tree  ==null?null:tree.getId();
        List<ZtreeVO> childList = Lists.newArrayList();
        for (Menu m : total){
            if(String.valueOf(m.getParentId()).equals(String.valueOf(pid))) {
                ZtreeVO ztreeVO = new ZtreeVO();
                ztreeVO.setId(m.getId());
                ztreeVO.setName(m.getName());
                ztreeVO.setPid(pid);
                childList.add(ztreeVO);
                getZTree(ztreeVO,total,result);
            }
        }
        if(tree != null){
            if (childList.size()>0){
                tree.setChildren(childList);
            }
        }else{
            result = childList;
        }
        return result;
    }

    @Caching(evict = {
            @CacheEvict(value = "allMenus",allEntries = true),
            @CacheEvict(value = "user",allEntries = true)
    })
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteMenuByIds(List<Menu> menus){
        baseMapper.deleteMenuByIds(menus);
    }

}
