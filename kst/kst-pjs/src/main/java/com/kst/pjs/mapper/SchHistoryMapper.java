package com.kst.pjs.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.pjs.entity.SchHistory;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface SchHistoryMapper extends BaseMapper<SchHistory> {

    Integer insertSchHistory(Map<String,Object> params);

}
