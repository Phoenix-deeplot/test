package com.kst.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.sys.api.entity.Menu;
import com.kst.sys.api.vo.ShowMenu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
@Mapper
public interface MenuMapper extends BaseMapper<Menu> {

    List<Menu> showAllMenusList(Map map);

    List<Menu> getMenus(Map map);

    List<ShowMenu> selectShowMenuByUser(Map<String, Object> map);

    void deleteMenuByIds(List<Menu> menus);

    Long selectMaxId();
}