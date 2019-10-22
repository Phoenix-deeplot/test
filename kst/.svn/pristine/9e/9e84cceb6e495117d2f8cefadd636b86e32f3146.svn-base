package com.kst.ams.service;

import com.kst.ams.entity.AssetMoveManager;
import com.kst.ams.vo.AssetMoveManageVO;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;

import java.util.List;

public interface IAssetMoveManageService extends IBaseService<AssetMoveManager> {
    int assetAssetMoveManagerCount(String key, String value);

    void deleteAssetMoveManager(AssetMoveManager assetMoveManager);

    void deleteAssetMoveManagers(List<AssetMoveManager> assetMoveManagers);
    
    DataTable<AssetMoveManageVO> selectAssetMoveManagerList(DataTable dt);


}

