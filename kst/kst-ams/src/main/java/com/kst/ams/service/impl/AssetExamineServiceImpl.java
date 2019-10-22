package com.kst.ams.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.AssetExamine;
import com.kst.ams.entity.AssetMoveManager;
import com.kst.ams.mapper.AssetExamineMapper;
import com.kst.ams.mapper.AssetMoveManageMapper;
import com.kst.ams.service.IAssetExamineService;
import com.kst.ams.service.IAssetMoveManageService;
import com.kst.ams.vo.AssetExamineVO;
import com.kst.common.base.service.impl.BaseService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class AssetExamineServiceImpl extends BaseService<AssetExamineMapper, AssetExamine> implements IAssetExamineService {

    @Override
    public int assetExamineCount(String key, String value) {
        QueryWrapper<AssetExamine> wrapper = new QueryWrapper<>();
        wrapper.eq(key,value);
        int count = baseMapper.selectCount(wrapper);
        return count;
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetExamine(AssetExamine assetExamine) {
        assetExamine.setDelFlag(true);
        baseMapper.updateById(assetExamine);
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetExamines(List<AssetExamine> assetExamines) {
        for (AssetExamine s : assetExamines){
            s.setDelFlag(true);
        }
        updateBatchById(assetExamines);
    }

    @Override
    public AssetExamineVO getAssetExamineVOList(Long examineId) {
        QueryWrapper<AssetExamine> wrapper = new QueryWrapper<>();
        wrapper.eq("EXAMINE_NO",examineId);
        AssetExamine assetExamine =  baseMapper.selectOne(wrapper);
        AssetExamineVO vo = new AssetExamineVO(assetExamine);
        return vo;
    }
}
