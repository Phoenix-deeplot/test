package com.kst.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.sys.api.entity.Daily;
import com.kst.sys.api.vo.DailyVO;
import io.lettuce.core.dynamic.annotation.Param;
import org.apache.ibatis.annotations.Mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Mapper
public interface DailyMapper extends BaseMapper<Daily> {

    List<Daily> selectDailyByMap(Map<String,Object> params);

    Integer insertDaily(Map<String,Object> params);

    List<DailyVO> selectDailyUserid(@Param("dailyUserid") Long dailyUserid);

    Integer totalNum();

    List<DailyVO> selectDate(@Param("dailyUserid") Long dailyUserid,@Param("dailyDate") Date strDate);
}
