package com.kst.ams.service;

import com.kst.ams.entity.AssetExamine;
import com.kst.ams.entity.AssetExamineDetail;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;

import java.util.List;

public interface IAssetExamineDetailService extends IBaseService<AssetExamineDetail> {
    int assetExamineDetailCount(String key, String value);

    void deleteAssetExamineDetail(AssetExamineDetail assetExamineDetail);

    void deleteAssetExaminesDetails(List<AssetExamineDetail> assetExamineDetails);

    List<AssetExamineDetail> getAssetExamineDetailList(Long examineId);

    DataTable<AssetExamineDetail> selectExamineDetailByPage(DataTable dt);
}
