package com.kst.ams.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.ams.vo.ChartVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ChartMapper{

    List<ChartVO> selectPieData(Map<String,Object> params);

    List<ChartVO> selectUseRatio(Map<String,Object> params);

    List<ChartVO> selectDivideAssetOnLastYear(Map<String,Object> params);

    List<ChartVO> selectAssetByLastYear(Map<String,Object> params);

    List<ChartVO> selectAssetByNextYear(Map<String,Object> params);
}
