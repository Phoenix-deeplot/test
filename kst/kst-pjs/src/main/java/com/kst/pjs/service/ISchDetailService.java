package com.kst.pjs.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.pjs.entity.SchDetail;

import java.util.List;
import java.util.Map;

public interface ISchDetailService extends IBaseService<SchDetail> {

    DataTable<SchDetail> selectSchDetailByPage(DataTable<SchDetail> dt);

    List<SchDetail> selectSchDetailByMap(Map<String,Object> params);

}
