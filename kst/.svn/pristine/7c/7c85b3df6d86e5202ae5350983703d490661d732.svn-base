package com.kst.activiti.mapper.act;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.activiti.entity.Page;
import com.kst.activiti.entity.PageData;
import com.kst.activiti.vo.FHModelVO;
import com.kst.activiti.vo.HiprocdefVO;
import com.kst.common.base.vo.DataTable;
import org.apache.ibatis.annotations.Mapper;

/** 
 * 说明： 模型管理Mapper
 * @version
 */
@Mapper
public interface FHModelMapper extends BaseMapper<FHModelVO> {
	
	/**列表
	 * @param dt
	 * @throws Exception
	 */
	List<FHModelVO> datalistPage(DataTable dt);
	
	/**通过id获取数据
	 * @param dt
	 * @throws Exception
	 */
	FHModelVO findById(DataTable dt);
	
	/**修改
	 * @param dt
	 * @throws Exception
	 */
	void edit(DataTable dt);
	
}

