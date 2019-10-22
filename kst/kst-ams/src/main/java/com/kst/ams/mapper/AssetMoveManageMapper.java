package com.kst.ams.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.ams.entity.AssetMoveManager;
import com.kst.ams.vo.AssetMoveManageVO;
import com.kst.common.base.vo.DataTable;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AssetMoveManageMapper extends BaseMapper<AssetMoveManager> {
    List<AssetMoveManageVO> selectAssetMoveByStatus(DataTable dt);

    Integer selectAssetMoveTotalByStatus(DataTable dt);
}
