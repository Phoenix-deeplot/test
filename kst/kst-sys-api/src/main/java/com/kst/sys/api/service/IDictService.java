package com.kst.sys.api.service;


import com.kst.common.base.service.IBaseService;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.vo.DictVO;

import java.util.List;

/**
 * <p>
 * 字典表 服务类
 * </p>
 *
 * @author zjf
 * @since 2017-11-26
 */
public interface IDictService extends IBaseService<Dict> {

    List<Dict>  getDictByType(String type);

    Integer getCountByType(String type);

    Integer getMaxSortByType(String type);

    Integer getCountByAll(String type, String label, String value);

    void saveOrUpdateDict(DictVO dict);

    String deleteDict(Long id);

    List<Dict> saveDictList(String type, List<Dict> list);

    void deleteByType(String s);

    void deleteByTableName(String tableName);

    void updateByType(String oldType, String newType);

    Dict selectDictById(Long id);
}
