package com.kst.att.service.impl;

import com.kst.att.entity.Sign;
import com.kst.att.vo.SignVO;
import com.kst.att.mapper.SignMapper;
import com.kst.att.service.ISignService;
import com.kst.common.base.service.impl.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SignServiceImpl extends BaseService<SignMapper, Sign> implements ISignService {

    @Override
    public List<SignVO> findAttUserid(String attUserid) {
        return this.baseMapper.selectAttUserid(attUserid);
    }

    @Override
    public Integer totalTime() {
        return this.baseMapper.totalTime();
    }

    @Override
    public Integer insertSign(Sign sign) {
        return this.baseMapper.insertSign(sign);
    }
}
