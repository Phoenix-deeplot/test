package com.kst.activiti.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.activiti.dto.ActReModelDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
public interface ModelMapper extends BaseMapper<ActReModelDto> {
}
