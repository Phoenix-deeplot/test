package com.kst.activiti.mapper.act;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.activiti.dto.ActReProcdefDto;
import com.kst.activiti.vo.ProcdefVO;
import com.kst.common.base.vo.DataTable;
import org.apache.ibatis.annotations.Mapper;

/** 
 * 说明： 流程管理Mapper
 * @version
 */
@Mapper
public interface ProcdefMapper extends BaseMapper<ActReProcdefDto> {
	
	/**列表
	 * @param dt
	 * @throws Exception
	 */
	List<ProcdefVO> datalistPage(DataTable dt);
}

