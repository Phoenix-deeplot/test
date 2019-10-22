package com.kst.ams.service.impl;

import com.kst.ams.entity.SoftwareInfo;
import com.kst.ams.mapper.SoftwareInfoMapper;
import com.kst.ams.service.ISoftwareService;
import com.kst.common.base.service.impl.BaseService;
import org.springframework.stereotype.Service;

@Service
public class SoftwareInfoServiceImpl extends BaseService<SoftwareInfoMapper, SoftwareInfo> implements ISoftwareService {
}
