package com.kst.ams.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.AssetMoveManager;
import com.kst.ams.entity.AssetMoveOutManager;
import com.kst.ams.mapper.AssetMoveManageMapper;
import com.kst.ams.mapper.AssetMoveOutManageMapper;
import com.kst.ams.service.IAssetMoveManageService;
import com.kst.ams.service.IAssetMoveOutManageService;
import com.kst.common.base.service.impl.BaseService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class AssetMoveOutManageServiceImpl extends BaseService<AssetMoveOutManageMapper, AssetMoveOutManager> implements IAssetMoveOutManageService {

    @Override
    public int assetAssetMoveManagerCount(String key, String value) {
        QueryWrapper<AssetMoveOutManager> wrapper = new QueryWrapper<>();
        wrapper.eq(key,value);
        int count = baseMapper.selectCount(wrapper);
        return count;
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetMoveManager(AssetMoveOutManager assetMoveOutManager) {
        assetMoveOutManager.setDelFlag(true);
        baseMapper.updateById(assetMoveOutManager);
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetMoveManagers(List<AssetMoveOutManager> assetMoveOutManager) {
        for (AssetMoveOutManager s : assetMoveOutManager){
            s.setDelFlag(true);
        }
        updateBatchById(assetMoveOutManager);
    }
}
