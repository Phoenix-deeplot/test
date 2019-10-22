package com.kst.sys.service.impl;

import com.kst.common.base.service.impl.BaseService;
import com.kst.sys.api.entity.Rfid;
import com.kst.sys.api.service.IRfidService;
import com.kst.sys.mapper.RfidMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class RfidServiceImpl extends BaseService<RfidMapper, Rfid> implements IRfidService {
}
