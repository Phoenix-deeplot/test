package com.kst.ams.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.AssetExamine;
import com.kst.ams.entity.AssetExamineDetail;
import com.kst.ams.mapper.AssetExamineDetailMapper;
import com.kst.ams.mapper.AssetExamineMapper;
import com.kst.ams.service.IAssetExamineDetailService;
import com.kst.ams.service.IAssetExamineService;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class AssetExamineDetailServiceImpl extends BaseService<AssetExamineDetailMapper, AssetExamineDetail> implements IAssetExamineDetailService {

    @Override
    public int assetExamineDetailCount(String key, String value) {
        QueryWrapper<AssetExamineDetail> wrapper = new QueryWrapper<>();
        wrapper.eq(key,value);
        int count = baseMapper.selectCount(wrapper);
        return count;
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetExamineDetail(AssetExamineDetail assetExamineDetail) {
        assetExamineDetail.setDelFlag(true);
        baseMapper.updateById(assetExamineDetail);
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetExaminesDetails(List<AssetExamineDetail> assetExamineDetails) {
        for (AssetExamineDetail s : assetExamineDetails){
            s.setDelFlag(true);
        }
        updateBatchById(assetExamineDetails);
    }

    @Override
    public List<AssetExamineDetail> getAssetExamineDetailList(Long examineId) {
        QueryWrapper<AssetExamineDetail> wrapper = new QueryWrapper<>();
        wrapper.eq("EXAMINE_NO",examineId);
        List<AssetExamineDetail> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public DataTable<AssetExamineDetail> selectExamineDetailByPage(DataTable dt) {
        dt.setRows(this.baseMapper.selectAssetExamineDetailPage(dt));
        dt.setTotal(this.baseMapper.selectAssetExamineDetailTotal(dt));
        return dt;
    }

}
