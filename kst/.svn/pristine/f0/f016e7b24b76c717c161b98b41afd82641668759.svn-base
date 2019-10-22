package com.kst.activiti.controller;

import com.kst.activiti.controller.base.AcStartController;
import com.kst.activiti.dto.ActApplyWorkFlow;
import com.kst.activiti.service.MyApplyService;
import com.kst.activiti.service.act.RuprocdefService;
import com.kst.activiti.utils.Jurisdiction;
import com.kst.activiti.utils.UuidUtil;
import com.kst.activiti.vo.MyApplyVO;

import com.kst.activiti.vo.RuprocdefVO;
import com.kst.common.base.vo.DataTable;

import com.kst.common.utils.RestResponse;
import com.kst.sys.api.entity.User;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;

import java.util.*;

/**
 * @author: ys
 * @createTime: 2019/7/26.
 */
@Controller
@RequestMapping("/myApply")
public class MyApplyController extends AcStartController {
    private static final Logger log = LoggerFactory.getLogger(MyApplyController.class);
    @Autowired
    private RuprocdefService ruprocdefService;
    @Autowired
    private MyApplyService myApplyService;
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private RuntimeService runtimeService;

    /**
     * @param
     * @throws Exception
     */
    @RequestMapping(value="/save")
    @RequiresPermissions("sys:myApply:save")
    @ResponseBody
    public RestResponse save(@RequestBody ActApplyWorkFlow actApplyWorkFlow, HttpServletRequest request, Model model){
        User user = (User) request.getAttribute("currentUser");
        try {
            /** 工作流的操作 **/
            Map<String,Object> map = new LinkedHashMap<>();
            map.put("申请人员", actApplyWorkFlow.getApplyer());			//当前用户的姓名
            map.put("资产名称", actApplyWorkFlow.getName());
            map.put("资产价格", actApplyWorkFlow.getAssetPrice());
            map.put("审核状态", actApplyWorkFlow.getApplyStatus());
            map.put("username", user.getLoginName());			//指派代理人为当前用户
            String instanceID = startProcessInstanceByKeyHasVariables("process",map);		//启动流程实例(请假单流程)通过KEY
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(instanceID).singleResult();
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(processInstance.getProcessDefinitionId())
                    .singleResult();
            actApplyWorkFlow.setFilename(processDefinition.getDiagramResourceName());
            actApplyWorkFlow.setFlowId(instanceID);
            actApplyWorkFlow.setCreateDate(new Date());
            actApplyWorkFlow.setDelFlag(false);
            //actApplyWorkFlow.setId(UuidUtil.get32UUID());
            myApplyService.save(actApplyWorkFlow);
            model.addAttribute("ASSIGNEE_",Jurisdiction.getUsername());
            model.addAttribute("msg","success");
        } catch (Exception e) {
        }
        return RestResponse.success();
    }

    /**
     * @param model
     * @throws Exception
     */
    @GetMapping(value = "/list")
    public String list(org.springframework.ui.Model model, HttpServletRequest request) throws Exception{
        model.addAttribute("url", request.getContextPath()+"/myApply/");
        return "myApply/myApplyList";
    }

    @RequiresPermissions("sys:myApply:list")
    @PostMapping("list")
    @ResponseBody
    public DataTable<MyApplyVO> list(@RequestBody DataTable dt) throws Exception{
        List<MyApplyVO>	varList = myApplyService.list(dt);	//列出Myleave列表
        dt.setRows(varList);
        dt.setTotal(varList.size());
        return dt;
    }
    /**
     *
     * @param model
     * @return
     */
    @GetMapping(value="/applyShow")
    public String applyShow(HttpServletRequest request, Model model) {
        User user = (User) request.getAttribute("currentUser");
        model.addAttribute("applyerName",user.getNickName());
        return "myApply/myApplyForm";
    }


}