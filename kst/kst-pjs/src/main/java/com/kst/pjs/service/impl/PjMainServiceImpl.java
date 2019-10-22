package com.kst.pjs.service.impl;

import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.pjs.entity.PjMain;
import com.kst.pjs.mapper.PjMainMapper;
import com.kst.pjs.service.IPjMainService;
import com.kst.pjs.vo.PjMainVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class PjMainServiceImpl extends BaseService<PjMainMapper, PjMain> implements IPjMainService {
    @Override
    public List<PjMain> selectPjMainByMap(Map<String, Object> params) {
        return this.baseMapper.selectPjMainByMap(params);
    }

    @Override
    public DataTable<PjMainVO> selectPjMainByPage(DataTable<PjMainVO> dt) {
        dt.setRows(this.baseMapper.selectPjMainByPage(dt));
        dt.setTotal(this.baseMapper.selectPjMainTotal(dt));
        return dt;
    }
}
