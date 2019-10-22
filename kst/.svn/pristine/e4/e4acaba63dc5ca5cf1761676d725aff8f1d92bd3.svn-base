package com.kst.ams.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.ams.entity.AssetInfo;
import com.kst.ams.vo.*;
import com.kst.common.base.vo.DataTable;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
@Mapper
public interface AssetInfoMapper extends BaseMapper<AssetInfo> {
    List<AssetInfoVO> selectTakeOutAsset(DataTable dt);

    Integer selectTakeOutAssetTotal(DataTable dt);

    Boolean selectSoftAmount(String assetNo);

    List<AssetListVO> selectAssetList(Map<String,Object> params);

    Integer selectSoftUseAmount(String no);

    Integer selectApplyUseAmount(String no);

    PcInfoVO selectPcInfo(String assetNo);

    NetInfoVO selectNetInfo(String assetNo);

    List<SoftwareInfoVO> selectSoftInfo(String assetNo);

    List<AssetExamineDetailVO> selectAssetExamine(String assetNo);

    List<AssetDiscardVO> selectAssetDiscardByDate(Map<String,Object> params);

    List<AssetInfoVO> selectCSVData(Map<String,Object> params);
}