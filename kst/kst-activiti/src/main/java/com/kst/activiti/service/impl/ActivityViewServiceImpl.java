package com.kst.activiti.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.activiti.dto.ActReModelDto;
import com.kst.activiti.mapper.ActivityViewMapper;
import com.kst.activiti.service.IActivityViewService;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;


@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ActivityViewServiceImpl extends BaseService<ActivityViewMapper, ActReModelDto> implements IActivityViewService {
    @Override
    public int activityViewCount(String key, String value) {
        QueryWrapper<ActReModelDto> wrapper = new QueryWrapper<>();
        wrapper.eq(key,value);
        int count = baseMapper.selectCount(wrapper);
        return count;
    }

    @Override
    public void deleteactivityView(ActReModelDto assetInfo) {

    }

    @Override
    public void deleteactivityViews(List<ActReModelDto> assetInfos) {

    }

    @Override
    public void returnactivityView(List<ActReModelDto> assetInfos) {

    }

    @Override
    public List<ActReModelDto> getActivityViewList() {
        return null;
    }

    @Override
    public DataTable<ActReModelDto> selectActivityViewList(DataTable dt) {
        return null;
    }
}
