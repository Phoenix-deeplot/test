package com.kst.activiti.service.act;

import java.util.List;

import com.kst.activiti.vo.HiprocdefVO;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;


public interface HiprocdefService extends IBaseService<HiprocdefVO> {

	List<HiprocdefVO> list(DataTable dt)throws Exception;

	List<HiprocdefVO> hivarList(DataTable dt)throws Exception;

}
