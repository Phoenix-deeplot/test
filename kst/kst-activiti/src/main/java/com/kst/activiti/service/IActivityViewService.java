package com.kst.activiti.service;

import com.kst.activiti.dto.ActReModelDto;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;

import java.util.List;

public interface IActivityViewService extends IBaseService<ActReModelDto> {
    int activityViewCount(String key, String value);

    void deleteactivityView(ActReModelDto assetInfo);

    void deleteactivityViews(List<ActReModelDto> assetInfos);

    void returnactivityView(List<ActReModelDto> assetInfos);

    List<ActReModelDto> getActivityViewList();

    DataTable<ActReModelDto> selectActivityViewList(DataTable dt);
}
