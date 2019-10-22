package com.kst.activiti.service.act.impl;
import com.kst.activiti.dto.ActReProcdefDto;
import com.kst.activiti.mapper.act.ProcdefMapper;
import com.kst.activiti.service.act.ProcdefService;
import com.kst.activiti.vo.ProcdefVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ProcdefServiceImpl extends BaseService<ProcdefMapper, ActReProcdefDto> implements ProcdefService {

	@Override
	public List<ProcdefVO> list(DataTable dt) {
		return baseMapper.datalistPage(dt);
	}
	
}

