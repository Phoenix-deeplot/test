package com.kst.activiti.service.act.impl;

import java.util.List;

import com.kst.activiti.entity.Page;
import com.kst.activiti.entity.PageData;
import com.kst.activiti.mapper.act.ProcdefMapper;
import com.kst.activiti.mapper.act.RuprocdefMapper;
import com.kst.activiti.service.act.ProcdefService;
import com.kst.activiti.service.act.RuprocdefService;
import com.kst.activiti.vo.ProcdefVO;
import com.kst.activiti.vo.RuprocdefVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class RuprocdefServiceImpl extends BaseService<RuprocdefMapper, RuprocdefVO> implements RuprocdefService {

	public List<RuprocdefVO> list(DataTable page)throws Exception{
		return baseMapper.datalistPage(page);
	}

	public List<RuprocdefVO> varList(DataTable dt)throws Exception{
		return baseMapper.varList(dt);
	}

	public List<RuprocdefVO> hiTaskList(DataTable dt)throws Exception{
		return baseMapper.hiTaskList(dt);
	}

	public List<RuprocdefVO> hitasklist(DataTable page)throws Exception{
		return baseMapper.hitaskdatalistPage(page);
	}

	public void onoffTask(DataTable dt)throws Exception{
		baseMapper.onoffTask(dt);;
	}

	public void onoffAllTask(DataTable pd)throws Exception{
		baseMapper.onoffAllTask(pd);;
	}

}
