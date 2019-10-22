package com.kst.att.service;

import com.kst.att.entity.Sign;
import com.kst.att.vo.SignVO;
import com.kst.common.base.service.IBaseService;

import java.util.List;

public interface ISignService extends IBaseService<Sign> {
    List<SignVO> findAttUserid(String attUserid);

    Integer totalTime();

    Integer insertSign(Sign sign);
}
