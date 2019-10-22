package com.kst.ams.service;

import com.kst.ams.entity.AssetInfo;
import com.kst.ams.entity.Supplier;
import com.kst.ams.vo.AssetDiscardVO;
import com.kst.ams.vo.AssetExamineDetailVO;
import com.kst.ams.vo.AssetInfoVO;
import com.kst.ams.vo.AssetListVO;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */

public interface IAssetInfoService extends IBaseService<AssetInfo> {

    int assetInfoCount(String key, String value);

    void deleteAssetInfo(AssetInfo assetInfo);

    void deleteAssetInfo(List<AssetInfo> assetInfos);

    List<AssetInfo> getAll();

    int updateTakeUserIdByNo(AssetInfo assetInfo);

    String noToPageNo(AssetInfo assetInfo);

    DataTable<AssetInfoVO> selectTakeOutAssetList(DataTable dt);

    Boolean selectSoftAmount(String assetNo);

    List<AssetListVO> selectAssetList(Map<String,Object> params);

    List<AssetListVO> selectAssetListDetail(Map<String,Object> params);

    List<AssetExamineDetailVO> selectAssetExamine(String assetNo);

    List<AssetDiscardVO> selectAssetDiscardByDate(Map<String,Object> params);

    List<AssetInfoVO> selectCSVData(Map<String,Object> params);

}
