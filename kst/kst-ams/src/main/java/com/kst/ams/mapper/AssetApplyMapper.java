package com.kst.ams.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.ams.entity.AssetApply;
import com.kst.ams.entity.AssetInfo;
import com.kst.ams.vo.AssetApplyVO;
import com.kst.common.base.vo.DataTable;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AssetApplyMapper extends BaseMapper<AssetApply> {
    List<AssetApplyVO> selectAssetApplyByStatus(DataTable dt);

    Integer selectAssetApplyCountByStatus(DataTable dt);
}
