package com.kst.sys.service.impl;

import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Msg;
import com.kst.sys.api.entity.SysQuestion;
import com.kst.sys.api.service.ISysQuestionService;
import com.kst.sys.mapper.SysQuestionMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;


@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class SysQuestionServiceImpl extends BaseService<SysQuestionMapper, SysQuestion> implements ISysQuestionService {

    @Override
    public DataTable<SysQuestion> selectSysQuestionByPage(DataTable<SysQuestion> dt) {
        dt.setRows(this.baseMapper.selectSysQuestionByPage(dt));
        dt.setTotal(this.baseMapper.selectSysQuestionTotal(dt));
        return dt;
    }

    @Override
    public SysQuestion selectSysQuestionById(Long id) {
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        return this.baseMapper.selectSysQuestionByMap(params).get(0);
    }
}
