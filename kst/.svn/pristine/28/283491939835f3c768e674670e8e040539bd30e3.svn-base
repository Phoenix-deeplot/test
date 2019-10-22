package com.kst.sys.service.impl;


import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Calandar;
import com.kst.sys.api.service.ICalandarService;
import com.kst.sys.mapper.CalandarMapper;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class CalandarServiceImpl extends BaseService<CalandarMapper, Calandar> implements ICalandarService {


    @Override
    public DataTable<Calandar> selectCalandarByPage(DataTable<Calandar> dt) {
        dt.setRows(this.baseMapper.selectCalandarByPage(dt));
        dt.setTotal(this.baseMapper.selectCalandarTotal(dt));
        return dt;
    }

    @Override
    public Calandar selectCalandarById(Long id) {
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        return this.baseMapper.selectCalandarByMap(params).get(0);
    }
}
