package com.kst.sys.api.service;

import com.kst.common.base.service.IBaseService;
import com.kst.sys.api.entity.Daily;
import com.kst.sys.api.vo.DailyVO;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface IDailyService extends IBaseService<Daily> {

    List<Daily> selectDailyByMap(Map<String,Object> params);

    Integer insertDaily(Map<String,Object> params);

    List<DailyVO> findDailyUserid(Long dailyUserid);

    Integer totalNum();

    List<DailyVO> selectDailyUserid(Long dailyUserid, Date strDate);

}
