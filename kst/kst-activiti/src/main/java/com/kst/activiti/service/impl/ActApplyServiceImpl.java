package com.kst.activiti.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.activiti.dto.ActApplyWorkFlow;
import com.kst.activiti.mapper.ActApplyMapper;
import com.kst.activiti.service.ActApplyService;
import com.kst.common.base.service.impl.BaseService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ActApplyServiceImpl extends BaseService<ActApplyMapper, ActApplyWorkFlow> implements ActApplyService {

    @Override
    public int assetApplyCount(String key, String value) {
        return 0;
    }

    @Override
    public void deleteAssetApply(ActApplyWorkFlow assetInfo) {

    }

    @Override
    public void deleteAssetApplys(List<ActApplyWorkFlow> assetInfos) {

    }

    @Override
    public void returnAssetApplys(List<ActApplyWorkFlow> assetInfos) {

    }
}
