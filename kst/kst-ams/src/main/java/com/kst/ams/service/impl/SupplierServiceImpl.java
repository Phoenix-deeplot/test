package com.kst.ams.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.service.ISupplierService;
import com.kst.ams.entity.Supplier;
import com.kst.ams.mapper.SupplierMapper;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Caching;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class SupplierServiceImpl extends BaseService<SupplierMapper, Supplier> implements ISupplierService {

    @Override
    public int supplierCount(String key, String value) {
        QueryWrapper<Supplier> wrapper = new QueryWrapper<>();
        wrapper.eq(key,value);
        int count = baseMapper.selectCount(wrapper);
        return count;
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteSupplier(Supplier supplier) {
        supplier.setDelFlag(true);
        baseMapper.updateById(supplier);
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteSupplier(List<Supplier> suppliers) {
        for (Supplier s : suppliers){
            s.setDelFlag(true);
        }
        updateBatchById(suppliers);
    }
}
