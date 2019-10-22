package com.kst.activiti.mapper.act;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.activiti.entity.Page;
import com.kst.activiti.entity.PageData;
import com.kst.activiti.vo.ProcdefVO;
import com.kst.activiti.vo.RuprocdefVO;
import com.kst.common.base.vo.DataTable;
import org.apache.ibatis.annotations.Mapper;

/** 
 * 说明： 正在运行的流程Mapper

 * @version
 */
@Mapper
public interface RuprocdefMapper extends BaseMapper<RuprocdefVO> {
	
	/**待办任务 or正在运行任务列表
	 * @param dt
	 * @throws Exception
	 */
	 List<RuprocdefVO> datalistPage(DataTable dt)throws Exception;
	
	/**流程变量列表
	 * @param dt
	 * @throws Exception
	 */
	 List<RuprocdefVO> varList(DataTable dt)throws Exception;
	
	/**历史任务节点列表
	 * @param dt
	 * @throws Exception
	 */
	 List<RuprocdefVO> hiTaskList(DataTable dt)throws Exception;
	
	/**已办任务列表列表
	 * @param dt
	 * @throws Exception
	 */
	 List<RuprocdefVO> hitaskdatalistPage(DataTable dt)throws Exception;
	
	/**激活or挂起任务(指定某个任务)
	 * @param dt
	 * @throws Exception
	 */
	 void onoffTask(DataTable dt)throws Exception;
	
	/**激活or挂起任务(指定某个流程的所有任务)
	 * @param dt
	 * @throws Exception
	 */
	 void onoffAllTask(DataTable dt)throws Exception;

}
