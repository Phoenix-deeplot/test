/**  
 * @Project: jxoa
 * @Title: TaskAction.java
 * @Package com.oa.manager.workFlow.action
 * @date 2013-7-22 下午2:59:12
 * @Copyright: 2013 
 */
package com.kst.activiti.controller;


import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import com.kst.activiti.form.StartTaskForm;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.sys.api.entity.User;
import io.swagger.annotations.ApiOperation;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.task.Task;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 *
 */
@Controller
@RequestMapping("/task")
public class ActTaskController{

	@Autowired
	TaskService taskService;

    @ApiOperation(value = "进入流程管理页面", notes = "进入流程管理页面")
    @GetMapping(value = "/taskTodo")
    public String list(Model model, HttpServletRequest request) {
        model.addAttribute("url", request.getContextPath()+"/task/todo/");
        return "task/todoList";
    }

    @ApiOperation(value = "待办列表", notes = "待办列表")
    @PostMapping("/taskTodo/list")
    @ResponseBody
    public DataTable<Task> todoList(@RequestBody DataTable dt, ServletRequest request) {
		User user = (User) request.getAttribute("currentUser");
		dt.setRows(taskService.createTaskQuery().taskCandidateGroup(user.getLoginName()).list());
		dt.setTotal(taskService.createTaskQuery().taskCandidateGroup(user.getLoginName()).list().size());
		return dt;
    }

    @ApiOperation(value = "开始流程", notes = "开始任务")
    @PostMapping("/taskTodo/start")
    public RestResponse start(@RequestBody StartTaskForm form, BindingResult result) {
        if (result.hasErrors()) {

        }
        return RestResponse.success();
    }
	
	
	
	
	
	
}
