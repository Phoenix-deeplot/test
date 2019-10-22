package com.kst.ams.service;

import com.kst.common.base.service.IBaseService;
import com.kst.ams.entity.Supplier;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */

public interface ISupplierService extends IBaseService<Supplier> {

    int supplierCount(String key, String value);

    void deleteSupplier(Supplier supplier);

    void deleteSupplier(List<Supplier> suppliers);

}
