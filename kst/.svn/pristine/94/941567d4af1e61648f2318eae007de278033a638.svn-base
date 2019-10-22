package com.kst.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Resource;
import com.kst.sys.api.vo.ResourceVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * <p>
  * 组织 Mapper 接口
 * </p>
 *
 */
@Mapper
public interface ResourceMapper extends BaseMapper<Resource> {

    List<ResourceVO> selectResource(Map<String, Object> params);

    List<ResourceVO> selectResourcePage(DataTable dt);

    Integer selectResourceByPageTotal(DataTable dt);
}