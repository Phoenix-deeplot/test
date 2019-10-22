package com.kst.sys.api.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.sys.api.entity.Menu;
import com.kst.sys.api.vo.ShowMenu;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
public interface IMenuService extends IBaseService<Menu> {

    List<Menu> selectAllMenus(Map<String, Object> map);

    List<ZtreeVO> showTreeMenus();

    List<ShowMenu> getShowMenuByUser(Long id);

    void saveOrUpdateMenu(Menu menu);

    int getCountByPermission(String permission);

    int getCountByName(String name);

    void deleteMenuByIds(List<Menu> menus);


}
