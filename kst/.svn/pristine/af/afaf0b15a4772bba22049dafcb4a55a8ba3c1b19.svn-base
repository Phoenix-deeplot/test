package com.kst.att.service.impl;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.att.entity.AttRfid;
import com.kst.att.mapper.AttRfidMapper;
import com.kst.att.service.IAttRfidService;
import com.kst.att.vo.RfidVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Rfid;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class AttRfidServiceImpl extends BaseService<AttRfidMapper, AttRfid> implements IAttRfidService {
    @Override
    public DataTable<RfidVO> selectAttRfidByPage(DataTable dt) {
        dt.setRows(this.baseMapper.selectAttRfidByPage(dt));
        dt.setTotal(this.baseMapper.selectAttRfidTotal(dt));
        return dt;
    }

    @Override
    public List<RfidVO> selectAttRfid() {
        Map<String,Object> params=new HashMap<>();
        params.put("useflg",1);
        return this.baseMapper.selectAllAttRfid(params);
    }
}
