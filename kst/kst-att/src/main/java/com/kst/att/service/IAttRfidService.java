package com.kst.att.service;

import com.kst.att.entity.AttRfid;
import com.kst.att.vo.RfidVO;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;

import java.util.List;

public interface IAttRfidService extends IBaseService<AttRfid>{

    DataTable<RfidVO> selectAttRfidByPage(DataTable dt);

    List<RfidVO> selectAttRfid();

}
