package com.kst.activiti.service.impl;

import com.kst.activiti.dto.ActApplyWorkFlow;
import com.kst.activiti.mapper.MyApplyMapper;
import com.kst.activiti.service.MyApplyService;
import com.kst.activiti.vo.MyApplyVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class MyApplyServiceImpl extends BaseService<MyApplyMapper, ActApplyWorkFlow> implements MyApplyService {

    @Override
    public void save(DataTable dt) throws Exception {
        baseMapper.save(dt);
    }

    @Override
    public void delete(DataTable dt) throws Exception {
        baseMapper.delete(dt);
    }

    @Override
    public void edit(DataTable dt) throws Exception {
        baseMapper.edit(dt);
    }

    @Override
    public List<MyApplyVO> list(DataTable dt) throws Exception {
        return baseMapper.datalistPage(dt);
    }

    @Override
    public MyApplyVO findById(DataTable dt) throws Exception {
        return baseMapper.findById(dt);
    }

    @Override
    public void deleteAll(String[] ArrayDATA_IDS) throws Exception {
        baseMapper.deleteAll(ArrayDATA_IDS);
    }
}
