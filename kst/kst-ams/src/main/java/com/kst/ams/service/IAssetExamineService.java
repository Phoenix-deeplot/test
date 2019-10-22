package com.kst.ams.service;

import com.kst.ams.entity.AssetExamine;
import com.kst.ams.entity.AssetMoveManager;
import com.kst.ams.vo.AssetExamineVO;
import com.kst.common.base.service.IBaseService;

import java.util.List;

public interface IAssetExamineService extends IBaseService<AssetExamine> {
    int assetExamineCount(String key, String value);

    void deleteAssetExamine(AssetExamine assetExamine);

    void deleteAssetExamines(List<AssetExamine> assetExamines);
    //根据点检ID查询点检明细
    AssetExamineVO getAssetExamineVOList(Long examineId);
}
