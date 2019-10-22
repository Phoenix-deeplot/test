package com.kst.activiti.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.kst.activiti.dto.ActReModelDto;
import com.kst.activiti.mapper.ModelMapper;
import com.kst.activiti.service.ModelService;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.enums.HttpCodeEnum;
import com.kst.common.exception.MyException;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.util.List;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ModelServiceImpl extends BaseService<ModelMapper, ActReModelDto> implements ModelService {
    @Autowired
    RepositoryService repositoryService;

    @Autowired
    ObjectMapper objectMapper;

    @Transactional(readOnly = false)
    public Model create(String name, String key, String desc, String category) {
        try {
            ObjectNode editorNode = objectMapper.createObjectNode();
            editorNode.put("id", "canvas");
            editorNode.put("resourceId", "canvas");
            ObjectNode properties = objectMapper.createObjectNode();
            properties.put("process_author", "slife");
            editorNode.put("properties", properties);
            ObjectNode stencilset = objectMapper.createObjectNode();
            stencilset.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
            editorNode.put("stencilset", stencilset);

            Model model = repositoryService.newModel();
            desc = StringUtils.defaultString(desc);
            model.setKey(StringUtils.defaultString(key));
            model.setName(name);
            model.setCategory(category);
            model.setVersion(Integer.parseInt(String.valueOf(repositoryService.createModelQuery().modelKey(model.getKey()).count()+1)));

            ObjectNode modelObjectNode = objectMapper.createObjectNode();
            modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, name);
            modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, model.getVersion());
            modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, desc);
            model.setMetaInfo(modelObjectNode.toString());

            repositoryService.saveModel(model);
            repositoryService.addModelEditorSource(model.getId(), editorNode.toString().getBytes("utf-8"));
            return model;
        } catch (UnsupportedEncodingException e) {
            throw new MyException(HttpCodeEnum.INTERNAL_SERVER_ERROR);
        }
    }
    @Transactional(readOnly = false)
    public String deploy(String id) {
        String message = "";
        try {
            // 获取模型
            Model model = repositoryService.getModel(id);
            ObjectNode objectNode = (ObjectNode) new ObjectMapper().readTree(repositoryService.getModelEditorSource(model.getId()));
            BpmnModel bpmnModel = new BpmnJsonConverter().convertToBpmnModel(objectNode);

            String processName = model.getName();
            if (!StringUtils.endsWith(processName, ".bpmn20.xml")){
                processName += ".bpmn20.xml";
            }
            // 部署流程
            Deployment deployment = repositoryService.createDeployment().name(model.getName())
                    .addBpmnModel(processName, bpmnModel)
                    .deploy();

            // 设置流程分类
            List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).list();
            if (list.size() == 0){
                throw new MyException(HttpCodeEnum.MODEL_NOT_EXIST);
            }
            list.stream().forEach(processDefinition ->
                    repositoryService.setProcessDefinitionCategory(processDefinition.getId(), model.getCategory()));
        } catch (Exception e) {
            throw new MyException(HttpCodeEnum.FAIL);
        }
        return message;
    }

}
