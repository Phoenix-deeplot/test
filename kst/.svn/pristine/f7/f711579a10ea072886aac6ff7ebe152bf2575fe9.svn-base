package com.kst.activiti.service.act.impl;

import java.util.List;

import com.kst.activiti.mapper.act.HiprocdefMapper;
import com.kst.activiti.service.act.HiprocdefService;
import com.kst.activiti.vo.HiprocdefVO;
import com.kst.common.base.service.impl.BaseService;

import com.kst.common.base.vo.DataTable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class HiprocdefServiceImpl extends BaseService<HiprocdefMapper, HiprocdefVO> implements HiprocdefService {
	@Override
	public List<HiprocdefVO> list(DataTable dt) throws Exception {
		return baseMapper.datalistPage(dt);
	}

	@Override
	public List<HiprocdefVO> hivarList(DataTable dt) throws Exception {
		return baseMapper.hivarList(dt);
	}
}
