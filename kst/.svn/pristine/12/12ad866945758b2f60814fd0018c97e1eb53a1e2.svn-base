package com.kst.ams.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.AssetApply;
import com.kst.ams.mapper.AssetApplyMapper;
import com.kst.ams.service.IAssetApplyService;
import com.kst.ams.vo.AssetApplyVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.xiaoleilu.hutool.date.DateUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class AssetApplyServiceImpl extends BaseService<AssetApplyMapper, AssetApply> implements IAssetApplyService {


//    @Override
//    public DataTable getAssetApplyList(DataTable dt) {
//        return dt;
//    }
//
    @Override
    public int assetApplyCount(String key, String value) {
        QueryWrapper<AssetApply> wrapper = new QueryWrapper<>();
        wrapper.eq(key,value);
        int count = baseMapper.selectCount(wrapper);
        return count;
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetApply(AssetApply assetApply) {
        assetApply.setDelFlag(true);
        baseMapper.updateById(assetApply);
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetApplys(List<AssetApply> assetInfos) {
        for (AssetApply s : assetInfos){
            s.setDelFlag(true);
        }
        updateBatchById(assetInfos);
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void returnAssetApplys(List<AssetApply> assetInfos) {
        Date date = new Date();
        for (AssetApply s : assetInfos){
            if(s.getReturnDate()==null){
                s.setReturnDate(date);
                s.setMoreInfo(s.getMoreInfo()+"[PC归还]");
                s.setApplyDate(null);
            }
        }
        updateBatchById(assetInfos);
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public DataTable<AssetApplyVO> selectAssetApplysList(DataTable dt){
        dt.setRows(this.baseMapper.selectAssetApplyByStatus(dt));
        dt.setTotal(this.baseMapper.selectAssetApplyCountByStatus(dt));
        return dt;
    }
}
