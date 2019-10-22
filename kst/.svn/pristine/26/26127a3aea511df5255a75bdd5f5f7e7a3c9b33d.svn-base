package com.kst.ams.service;

import com.kst.ams.entity.AssetApply;
import com.kst.ams.vo.AssetApplyVO;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;

import java.util.List;

public interface IAssetApplyService extends IBaseService<AssetApply> {
    int assetApplyCount(String key, String value);

    void deleteAssetApply(AssetApply assetInfo);

    void deleteAssetApplys(List<AssetApply> assetInfos);

    void returnAssetApplys(List<AssetApply> assetInfos);

    DataTable<AssetApplyVO> selectAssetApplysList(DataTable dt);
}
