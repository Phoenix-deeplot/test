package com.kst.ams.service;

import com.kst.ams.entity.AssetApply;
import com.kst.ams.entity.AssetTakeOut;
import com.kst.ams.vo.AssetTakeOutVO;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;

import java.util.List;

public interface IAssetTakeOutService extends IBaseService<AssetTakeOut> {
    int assetApplyCount(String key, String value);

    void deleteAssetApply(AssetTakeOut assetInfo);

    void deleteAssetApplys(List<AssetTakeOut> assetInfos);

    void returnTakeOut(List<AssetTakeOut> assetInfos);

    DataTable<AssetTakeOutVO> selectTakeOutList(DataTable dt);
}
