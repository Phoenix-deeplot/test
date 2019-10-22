package com.kst.activiti.service.act.impl;

import java.util.List;

import com.kst.activiti.entity.Page;
import com.kst.activiti.entity.PageData;
import com.kst.activiti.mapper.act.FHModelMapper;
import com.kst.activiti.mapper.act.HiprocdefMapper;
import com.kst.activiti.service.act.FHModelService;
import com.kst.activiti.service.act.HiprocdefService;
import com.kst.activiti.vo.FHModelVO;
import com.kst.activiti.vo.HiprocdefVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class FHModelServiceImpl extends BaseService<FHModelMapper, FHModelVO> implements FHModelService {

	public List<FHModelVO> list(DataTable dt)throws Exception{
		return baseMapper.datalistPage(dt);
	}

	public FHModelVO findById(DataTable dt)throws Exception{
		return baseMapper.findById(dt);
	}

	public void edit(DataTable dt)throws Exception{
		baseMapper.edit(dt);
	}
	
}

