package com.kst.pjs.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.pjs.entity.ProjectHistory;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface ProjectHistoryMapper extends BaseMapper<ProjectHistory> {

    Integer insertProjectHistory(Map<String,Object> params);

}
