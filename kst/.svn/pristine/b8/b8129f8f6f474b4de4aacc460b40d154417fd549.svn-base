package com.kst.activiti.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.kst.activiti.dto.ActReModelDto;
import com.kst.activiti.form.ModelForm;
import com.kst.activiti.service.ModelService;
import com.kst.activiti.service.MyApplyService;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.entity.ReturnDTO;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.common.utils.ReturnDTOUtil;
import io.swagger.annotations.ApiOperation;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: ys
 * @createTime: 2019/6/26.
 */
@Controller
@RequestMapping("/activityView")
public class ActivityViewController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(ModelerController.class);

    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private ObjectMapper objectMapper;
    @Autowired
    private HistoryService historyService;
    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private ModelService modelService;

    @Autowired
    private MyApplyService myApplyService;


    @GetMapping(value = "/viewI")
    public String index(org.springframework.ui.Model model) {
        List<Model> resultModel = repositoryService.createModelQuery().list();
        model.addAttribute("resultModel",resultModel);
        return "workflowDemo/viewI";
    }

    @RequiresPermissions("sys:activityView:viewI")
    @PostMapping("viewI")
    @ResponseBody
    public DataTable<ActReModelDto> index(@RequestBody DataTable dt, ServletRequest request) {
        dt.setRows(repositoryService.createModelQuery().list());
        dt.setTotal(repositoryService.createModelQuery().list().size());
        return dt;
    }

    @GetMapping("editor")
    public String editor(){
        return "workflowDemo/modeler";
    }

    @RequestMapping(value = "/create")
    @ResponseBody
    public void create(HttpServletResponse response, HttpServletRequest request,String editFlg, String modelId, String name, String key) throws IOException {
        logger.info("创建模型入参name：{},key:{},id{}",name,key,modelId);
        if ("true".equals(editFlg)) {
            // modelResult = repositoryService.createModelQuery().modelId(modelId).singleResult();
            response.sendRedirect("editor?modelId="+ modelId);
            logger.info("跳转绘图页面，返回模型ID：{}",modelId);
        } else {
            Model model = repositoryService.newModel();
            ObjectNode modelNode = objectMapper.createObjectNode();
            modelNode.put(ModelDataJsonConstants.MODEL_NAME, name);
            modelNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, "");
            modelNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
            model.setName(name);
            model.setKey(key);
            model.setMetaInfo(modelNode.toString());
            repositoryService.saveModel(model);
            createObjectNode(model.getId());
            response.sendRedirect("editor?modelId="+ model.getId());
            logger.info("创建模型结束，返回模型ID：{}",model.getId());
        }
    }


    private void createObjectNode(String modelId){
        logger.info("创建模型完善ModelEditorSource入参模型ID：{}",modelId);
        ObjectNode editorNode = objectMapper.createObjectNode();
        editorNode.put("id", "canvas");
        editorNode.put("resourceId", "canvas");
        ObjectNode stencilSetNode = objectMapper.createObjectNode();
        stencilSetNode.put("namespace","http://b3mn.org/stencilset/bpmn2.0#");
        editorNode.put("stencilset", stencilSetNode);
        try {
            repositoryService.addModelEditorSource(modelId,editorNode.toString().getBytes("utf-8"));
        } catch (Exception e) {
            logger.info("创建模型时完善ModelEditorSource服务异常：{}",e);
        }
        logger.info("创建模型完善ModelEditorSource结束");
    }

    @ResponseBody
    @RequestMapping("/publish")
    public RestResponse publish(String id){
        logger.info("流程部署入参modelId：{}",id);
        Map<String, String> map = new HashMap<String, String>();
        try {
            Model modelData = repositoryService.getModel(id);
            byte[] bytes = repositoryService.getModelEditorSource(modelData.getId());
            if (bytes == null) {
                logger.info("部署ID:{}的模型数据为空，请先设计流程并成功保存，再进行发布",id);

                map.put("code", "FAILURE");
                return RestResponse.failure("部署ID:{}的模型数据为空，请先设计流程并成功保存，再进行发布",id);
                //return map;
            }
            JsonNode modelNode = new ObjectMapper().readTree(bytes);
            BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
            Deployment deployment = repositoryService.createDeployment()
                    .name(modelData.getName())
                    .addBpmnModel(modelData.getKey()+".bpmn20.xml", model)
                    .deploy();
            modelData.setDeploymentId(deployment.getId());
            repositoryService.saveModel(modelData);
            map.put("code", "SUCCESS");
        } catch (Exception e) {
            logger.info("部署modelId:{}模型服务异常：{}",id,e);
            map.put("code", "FAILURE");
        }
        logger.info("流程部署出参map：{}",map);
        return RestResponse.success();
    }

    @ResponseBody
    @RequestMapping("/revokePublish")
    public Object revokePublish(String modelId){
        logger.info("撤销发布流程入参modelId：{}",modelId);
        Map<String, String> map = new HashMap<String, String>();
        Model modelData = repositoryService.getModel(modelId);
        if(null != modelData){
            try {
                repositoryService.deleteDeployment(modelData.getDeploymentId(),true);
                map.put("code", "SUCCESS");
            } catch (Exception e) {
                map.put("code", "FAILURE");
            }
        }
        logger.info("撤销发布流程出参map：{}",map);
        return map;
    }

    @ApiOperation(value = "进入模型管理页面", notes = "进入模型管理页面")
    @GetMapping(value = "/insert")
    public String insert(org.springframework.ui.Model model, HttpServletRequest request) {
        model.addAttribute("action", "insert");
        model.addAttribute("url", request.getContextPath() + "/model/");
        model.addAttribute("categories", "");
        return "model/add";
    }

    @ApiOperation(value = "添加流程模型", notes = "添加流程模型")
    @PostMapping(value = "/insert")
    @ResponseBody
    public RestResponse insertForm(@RequestBody ModelForm form) {
        modelService.create(form.getName(), form.getKey(), form.getDesc(), form.getCategory());
        return RestResponse.success();
    }
    /**
     * 删除流程实例
     * @param modelId 模型ID
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/delete")
    public Object deleteProcessInstance(String modelId){
        logger.info("删除流程实例入参modelId：{}",modelId);
        Map<String, String> map = new HashMap<String, String>();
        Model modelData = repositoryService.getModel(modelId);
        if(null != modelData){
            try {
                ProcessInstance pi = runtimeService.createProcessInstanceQuery().processDefinitionKey(modelData.getKey()).singleResult();
                if(null != pi) {
                    runtimeService.deleteProcessInstance(pi.getId(), "");
                    historyService.deleteHistoricProcessInstance(pi.getId());
                }
                map.put("code", "SUCCESS");
            } catch (Exception e) {
                logger.error("删除流程实例服务异常：{}",e);
                map.put("code", "FAILURE");
            }
        }
        logger.info("删除流程实例出参map：{}",map);
        return map;
    }
    @ApiOperation(value = "添加流程模型", notes = "添加流程模型")
    @PostMapping(value = "/deploy")
    @ResponseBody
    public ReturnDTO deploy(@RequestBody ModelForm form) {
        modelService.create(form.getName(), form.getKey(), form.getDesc(), form.getCategory());
        return ReturnDTOUtil.success();
    }
}