package com.kst.ams.service;

import com.kst.ams.entity.Divide;
import com.kst.ams.vo.DepreciationVO;
import com.kst.common.base.service.IBaseService;

import java.util.List;
import java.util.Map;

public interface IDivideService extends IBaseService<Divide> {

    List<Divide> selectPassDivideByYymm(String assetNo,String yymm);

    List<Divide> selectuFtureDivideByYymm(String assetNo,String yymm);

    List<DepreciationVO> selectDepreciationList(Map<String,Object> params);

}
