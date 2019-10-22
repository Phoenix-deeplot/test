package com.kst.ams.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.AssetMoveManager;
import com.kst.ams.mapper.AssetMoveManageMapper;
import com.kst.ams.service.IAssetMoveManageService;
import com.kst.ams.vo.AssetMoveManageVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class AssetMoveManageServiceImpl extends BaseService<AssetMoveManageMapper, AssetMoveManager> implements IAssetMoveManageService {

    @Override
    public int assetAssetMoveManagerCount(String key, String value) {
        QueryWrapper<AssetMoveManager> wrapper = new QueryWrapper<>();
        wrapper.eq(key,value);
        int count = baseMapper.selectCount(wrapper);
        return count;
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetMoveManager(AssetMoveManager assetMoveManager) {
        assetMoveManager.setDelFlag(true);
        baseMapper.updateById(assetMoveManager);
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetMoveManagers(List<AssetMoveManager> assetMoveManagers) {
        for (AssetMoveManager s : assetMoveManagers){
            s.setDelFlag(true);
        }
        updateBatchById(assetMoveManagers);
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public DataTable<AssetMoveManageVO> selectAssetMoveManagerList(DataTable dt) {
        dt.setRows(this.baseMapper.selectAssetMoveByStatus(dt));
        dt.setTotal(this.baseMapper.selectAssetMoveTotalByStatus(dt));
        return dt;
    }
}
