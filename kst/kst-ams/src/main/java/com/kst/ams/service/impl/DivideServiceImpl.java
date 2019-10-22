package com.kst.ams.service.impl;

import com.kst.ams.entity.Divide;
import com.kst.ams.mapper.DivideMapper;
import com.kst.ams.service.IDivideService;
import com.kst.ams.vo.DepreciationVO;
import com.kst.common.base.service.impl.BaseService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DivideServiceImpl extends BaseService<DivideMapper, Divide> implements IDivideService {
    @Override
    public List<Divide> selectPassDivideByYymm(String assetNo,String yymm) {
        Map<String,Object> params=new HashMap<>();
        params.put("assetNo",assetNo);
        params.put("yymm",yymm);
        return this.baseMapper.selectPassDivideByYymm(params);
    }

    @Override
    public List<Divide> selectuFtureDivideByYymm(String assetNo,String yymm) {
        Map<String,Object> params=new HashMap<>();
        params.put("assetNo",assetNo);
        params.put("yymm",yymm);
        return this.baseMapper.selectuFtureDivideByYymm(params);
    }

    @Override
    public List<DepreciationVO> selectDepreciationList(Map<String, Object> params) {
        return this.baseMapper.selectDepreciationList(params);
    }

}
