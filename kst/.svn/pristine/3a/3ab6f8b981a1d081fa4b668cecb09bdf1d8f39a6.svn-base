package com.kst.pjs.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.pjs.entity.SchDetail;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SchDetailMapper extends BaseMapper<SchDetail> {

    List<SchDetail> selectSchDetailByPage(DataTable<SchDetail> dt);

    Integer selectSchDetailTotal(DataTable<SchDetail> dt);

    List<SchDetail> selectSchDetailByMap(Map<String,Object> params);

}
