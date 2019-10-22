package com.kst.pjs.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.pjs.entity.PjMain;
import com.kst.pjs.vo.PjMainVO;

import java.util.List;
import java.util.Map;

public interface IPjMainService extends IBaseService<PjMain> {

    List<PjMain> selectPjMainByMap(Map<String,Object> params);

    DataTable<PjMainVO> selectPjMainByPage(DataTable<PjMainVO> dt);
}
