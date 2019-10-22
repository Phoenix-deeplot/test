package com.kst.sys.service.impl;


import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Msg;
import com.kst.sys.api.service.IMsgService;
import com.kst.sys.mapper.MsgMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class MsgServiceImpl extends BaseService<MsgMapper, Msg> implements IMsgService {
    @Override
    public DataTable<Msg> selectMsgByPage(DataTable<Msg> dt) {
        dt.setRows(this.baseMapper.selectMsgByPage(dt));
        dt.setTotal(this.baseMapper.selectMsgTotal(dt));
        return dt;
    }

    @Override
    public Msg selectMsgById(Long id) {
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        return this.baseMapper.selectMsgByMap(params).get(0);
    }

    @Override
    public List<Msg> selectMsgByUserId(Long userId) {
        Map<String,Object> params=new HashMap<>();
        params.put("userId",userId);
        return this.baseMapper.selectMsgByMap(params);
    }

    @Override
    public Integer insertMsg(Map<String, Object> params) {
        return this.baseMapper.insertMsg(params);
    }

}
