package com.kst.activiti.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kst.activiti.controller.base.AcBusinessController;
import com.kst.activiti.service.act.HiprocdefService;
import com.kst.activiti.vo.HiprocdefVO;
import com.kst.common.base.vo.DataTable;
import org.apache.shiro.authz.annotation.RequiresPermissions;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletRequest;

/**
 * 历史流程任务
 */
@Controller
@RequestMapping("/hiprocdef")
public class HiprocdefController extends AcBusinessController {

	@Autowired
	private HiprocdefService hiprocdefService;
	
	/**列表
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public String list(org.springframework.ui.Model model) throws Exception{
		return "workflowDemo/hiprocdef/hiprocdef_list";
	}
	@RequiresPermissions("sys:hiprocdef:list")
	@PostMapping("list")
	@ResponseBody
	public DataTable<HiprocdefVO> list(@RequestBody DataTable dt, ServletRequest request) {
		List<HiprocdefVO> varList = null;			//列出Hiprocdef列表
		try {
			varList = hiprocdefService.list(dt);
		} catch (Exception e) {
			e.printStackTrace();
		}
		for(int i=0;i<varList.size();i++){
			Long duringTime = Long.parseLong(varList.get(i).getDuration());
			Long tian = duringTime / (1000*60*60*24);
			Long shi = (duringTime % (1000*60*60*24))/(1000*60*60);
			Long fen = (duringTime % (1000*60*60*24))%(1000*60*60)/(1000*60);
			varList.get(i).setZTIME(tian+"天"+shi+"时"+fen+"分");
			varList.get(i).setINITATOR(getInitiator(varList.get(i).getProcInstId()));//流程申请人
		}
		dt.setRows(varList);
		dt.setTotal(varList.size());
		return dt;
	}
	/**查看流程信息页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/view")
	public String view(Model model)throws Exception{
		return "act/hiprocdef/hiprocdef_view";
	}
	
	/**删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	@ResponseBody
	@RequiresPermissions("hiprocdef:del")
	public Object delete() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("result", "success");
		return map;
	}
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	@RequiresPermissions("hiprocdef:del")
	public Object deleteAll() throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		map.put("result", errInfo);
		return map;
	}

}
