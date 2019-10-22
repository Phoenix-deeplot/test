package com.kst.ams.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.ams.entity.Supplier;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;
import java.util.Set;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
@Mapper
public interface SupplierMapper extends BaseMapper<Supplier> {
}