package com.kst.sys.mapper;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Calandar;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CalandarMapper extends BaseMapper<Calandar> {

    List<Calandar> selectCalandarByPage(DataTable dt);

    Integer selectCalandarTotal(DataTable dt);

    List<Calandar> selectCalandarByMap(Map<String, Object> params);

}
