package com.kst.ams.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.AssetApply;
import com.kst.ams.entity.AssetTakeOut;
import com.kst.ams.mapper.AssetApplyMapper;
import com.kst.ams.mapper.AssetTakeOutMapper;
import com.kst.ams.service.IAssetApplyService;
import com.kst.ams.service.IAssetTakeOutService;
import com.kst.ams.vo.AssetTakeOutVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class AssetTakeOutServiceImpl extends BaseService<AssetTakeOutMapper, AssetTakeOut> implements IAssetTakeOutService {


//    @Override
//    public DataTable getAssetApplyList(DataTable dt) {
//        return dt;
//    }
//
    @Override
    public int assetApplyCount(String key, String value) {
        QueryWrapper<AssetTakeOut> wrapper = new QueryWrapper<>();
        wrapper.eq(key,value);
        int count = baseMapper.selectCount(wrapper);
        return count;
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetApply(AssetTakeOut assetApply) {
        assetApply.setDelFlag(true);
        baseMapper.updateById(assetApply);
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetApplys(List<AssetTakeOut> assetInfos) {
        for (AssetTakeOut s : assetInfos){
            s.setDelFlag(true);
        }
        updateBatchById(assetInfos);
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void returnTakeOut(List<AssetTakeOut> assetInfos) {
        Date date = new Date();
        for (AssetTakeOut s : assetInfos){
            s.setReturnDate(date);
            s.setMoreInfo(s.getMoreInfo()+"[PC带出归还]");
            s.setApplyDate(null);
        }
        updateBatchById(assetInfos);
    }

    @Override
    public DataTable<AssetTakeOutVO> selectTakeOutList(DataTable dt) {
        dt.setRows(this.baseMapper.selectTakeOutByStatus(dt));
        dt.setTotal(this.baseMapper.selectTakeOutTatolByStatus(dt));
        return dt;
    }
}
