package com.kst.ams.service;

import com.kst.ams.vo.ChartVO;
import com.kst.common.base.service.IBaseService;
import com.kst.sys.api.entity.Dict;

import java.util.Date;
import java.util.List;
import java.util.Map;


public interface IChartService{

    List<ChartVO> selectPieData(Map<String,Object> params);

    List<ChartVO> selectUseRatio(Map<String,Object> params);

    List<ChartVO> selectDivideAssetOnLastYear(List<Dict> dicts, Date selectDate);

    List<ChartVO> selectNextYearAssetData(List<Dict> dicts, Date selectDate);

}
