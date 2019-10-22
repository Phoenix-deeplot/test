package com.kst.log.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.log.entity.Log;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 系统日志 Mapper 接口
 * </p>
 *
 * @author zjf
 * @since 2018-01-14
 */
@Mapper
public interface LogMapper extends BaseMapper<Log> {

    List<Map> selectSelfMonthData();
}
