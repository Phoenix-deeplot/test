package com.kst.activiti.service.act;

import java.util.List;

import com.kst.activiti.entity.Page;
import com.kst.activiti.entity.PageData;
import com.kst.activiti.vo.FHModelVO;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.stereotype.Service;

public interface FHModelService extends IBaseService<FHModelVO> {

	 List<FHModelVO> list(DataTable dt)throws Exception;

	FHModelVO findById(DataTable dt)throws Exception;

	 void edit(DataTable pd)throws Exception;
	
}

