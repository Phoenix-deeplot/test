package com.kst.activiti.controller;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.kst.activiti.controller.base.AcBusinessController;
import com.kst.activiti.entity.PageData;
import com.kst.activiti.service.act.HiprocdefService;
import com.kst.activiti.service.act.RuprocdefService;
import com.kst.activiti.utils.*;
import com.kst.activiti.vo.RuprocdefVO;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.sys.api.entity.User;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/**
 * 说明：待办任务

 */
@Controller
@RequestMapping(value="/waitTask")
public class RuTaskController extends AcBusinessController {
	
	@Autowired
	private RuprocdefService ruprocdefService;

	
	@Autowired
	private HiprocdefService hiprocdefService;
	
	/**待办任务列表
	 * @param model
	 * @throws Exception
	 */
	@GetMapping(value="/list")
	//@RequiresPermissions("rutask:list")
	public String list(Model model,HttpServletRequest request) throws Exception{
		model.addAttribute("url", request.getContextPath()+"/rutask/");
		return "waitTask/todoTaskList";
	}

	@RequiresPermissions("sys:waitTask:list")
	@PostMapping("list")
	@ResponseBody
	public DataTable<RuprocdefVO> list(@RequestBody DataTable dt, HttpServletRequest request) throws Exception{
		User user = (User) request.getAttribute("currentUser");
		Map<String,Object> para = new HashMap();
		para.put("USERNAME",user.getLoginName());
		para.put("startNo",dt.getSearchParams().get("startNo"));
		dt.setSearchParams(para);
		List<RuprocdefVO> varList = ruprocdefService.list(dt);	//列出Rutask列表
		dt.setTotal(varList.size());
		dt.setRows(varList);
		return dt;
	}
	/**办理任务
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/handle")
	@RequiresPermissions("sys:waitTask:handle")
	@ResponseBody
	public RestResponse handle(@RequestBody RuprocdefVO ruprocdefVO) throws Exception{
		//Session session = Jurisdiction.getSession();
        DataTable dt = new DataTable();
        Map<String,Object> para = new HashMap();
        para.put("PROC_INST_ID_",ruprocdefVO.getProcInstId());
        dt.setSearchParams(para);
		String sfrom = "";
		String taskId = ruprocdefVO.getId().toString();
		Object ofrom = getVariablesByTaskIdAsMap(taskId,"审批结果");
		if(null != ofrom){
			sfrom = ofrom.toString();
		}
		Map<String,Object> map = new LinkedHashMap<String, Object>();
		String msg = ruprocdefVO.getMsg();
		if("yes".equals(msg)){
			map.put("审批结果", "【批准】" );
			setVariablesByTaskIdAsMap(taskId,map);
			setVariablesByTaskId(taskId,"RESULT","批准");
			completeMyPersonalTask(taskId);
		}else{
			map.put("审批结果", "【驳回】" );
			setVariablesByTaskIdAsMap(taskId,map);
			setVariablesByTaskId(taskId,"RESULT","驳回");
			completeMyPersonalTask(taskId);
		}
        try{
			removeVariablesByPROC_INST_ID_(ruprocdefVO.getProcInstId(),"RESULT");
		}catch(Exception e){
			/*此流程变量在历史中**/
		}
		return RestResponse.success();
	}
    /**查看当前任务节点图片
     * @param
     * @throws Exception
     */

    @RequestMapping(value="/goHandle")
    @RequiresPermissions("sys:waitTask:goHandle")
    public String goHandle(org.springframework.ui.Model model,String fileName,String instId)throws Exception{
    	PageData pd = new PageData();
        String FILENAME = fileName;
        createXmlAndPngAtNowTask(instId,FILENAME);//生成当前任务节点的流程图片
        pd.put("FILENAME", FILENAME);
        String imgSrcPath = PathUtil.getProjectpath()+Const.FILEACTIVITI+FILENAME;
        pd.put("imgSrc", "data:image/jpeg;base64,"+ImageAnd64Binary.getImageStr(imgSrcPath)); //解决图片src中文乱码，把图片转成base64格式显示(这样就不用修改tomcat的配置了)
        model.addAttribute("pd", pd);
        return "process/processImg";
    }

}
