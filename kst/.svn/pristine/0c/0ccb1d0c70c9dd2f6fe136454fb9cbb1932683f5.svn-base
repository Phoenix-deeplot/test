package com.kst.pjs.service.impl;

import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.pjs.entity.SchDetail;
import com.kst.pjs.mapper.SchDetailMapper;
import com.kst.pjs.service.ISchDetailService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class SchDetailServiceImpl extends BaseService<SchDetailMapper,SchDetail> implements ISchDetailService {
    @Override
    public DataTable<SchDetail> selectSchDetailByPage(DataTable<SchDetail> dt) {
        dt.setRows(this.baseMapper.selectSchDetailByPage(dt));
        dt.setTotal(this.baseMapper.selectSchDetailTotal(dt));
        return dt;
    }

    @Override
    public List<SchDetail> selectSchDetailByMap(Map<String, Object> params) {
        return this.baseMapper.selectSchDetailByMap(params);
    }
}
