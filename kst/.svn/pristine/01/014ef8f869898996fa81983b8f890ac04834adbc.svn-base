package com.kst.sys.service.impl;

import com.kst.common.base.service.impl.BaseService;
import com.kst.sys.api.entity.Daily;
import com.kst.sys.api.service.IDailyService;
import com.kst.sys.api.vo.DailyVO;
import com.kst.sys.mapper.DailyMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class DailyServiceImpl extends BaseService<DailyMapper, Daily> implements IDailyService {
    @Override
    public List<Daily> selectDailyByMap(Map<String, Object> params) {
        return this.baseMapper.selectDailyByMap(params);
    }

    @Override
    public Integer insertDaily(Map<String,Object> params) {
        return this.baseMapper.insertDaily(params);
    }

    @Override
    public List<DailyVO> findDailyUserid(Long dailyUserid) {
        return this.baseMapper.selectDailyUserid(dailyUserid);
    }

    @Override
    public Integer totalNum() {
        return this.baseMapper.totalNum();
    }

    @Override
    public List<DailyVO> selectDailyUserid(Long dailyUserid, Date strDate) {
        return this.baseMapper.selectDate(dailyUserid,strDate);
    }
}
