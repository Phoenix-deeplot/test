package com.kst.pjs.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.service.impl.BaseService;
import com.kst.pjs.entity.ProjectHistory;

import java.util.Map;

public interface IProjectHistoryService extends IBaseService<ProjectHistory> {

    Integer insertProjectHistory(Map<String,Object> params);

}
