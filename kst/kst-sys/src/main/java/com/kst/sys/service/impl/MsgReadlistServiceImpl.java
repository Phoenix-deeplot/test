package com.kst.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.service.impl.BaseService;
import com.kst.sys.api.entity.MsgReadlist;
import com.kst.sys.api.service.IMsgReadlistService;
import com.kst.sys.mapper.MsgReadlistMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class MsgReadlistServiceImpl extends BaseService<MsgReadlistMapper, MsgReadlist> implements IMsgReadlistService {

    @Override
    public Integer insertMsgReadlist(Map<String, Object> params) {
        return this.baseMapper.insertMsgReadList(params);
    }
}
