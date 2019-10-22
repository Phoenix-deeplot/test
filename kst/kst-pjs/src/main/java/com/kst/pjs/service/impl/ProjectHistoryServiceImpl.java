package com.kst.pjs.service.impl;

import com.kst.common.base.service.impl.BaseService;
import com.kst.pjs.entity.ProjectHistory;
import com.kst.pjs.mapper.ProjectHistoryMapper;
import com.kst.pjs.service.IProjectHistoryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ProjectHistoryServiceImpl extends BaseService<ProjectHistoryMapper, ProjectHistory> implements IProjectHistoryService {
    @Override
    public Integer insertProjectHistory(Map<String, Object> params) {
        return this.baseMapper.insertProjectHistory(params);
    }
}
