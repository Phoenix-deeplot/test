package com.kst.ams.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.ams.entity.AssetApply;
import com.kst.ams.entity.AssetTakeOut;
import com.kst.ams.vo.AssetTakeOutVO;
import com.kst.common.base.vo.DataTable;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AssetTakeOutMapper extends BaseMapper<AssetTakeOut> {
    List<AssetTakeOutVO> selectTakeOutByStatus(DataTable dt);

    Integer selectTakeOutTatolByStatus(DataTable dt);
}
