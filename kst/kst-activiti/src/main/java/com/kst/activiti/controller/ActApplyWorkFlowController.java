package com.kst.activiti.controller;

import com.kst.activiti.controller.base.AcBusinessController;
import com.kst.activiti.dto.ActApplyWorkFlow;
import com.kst.activiti.entity.PageData;
import com.kst.activiti.utils.Const;
import com.kst.activiti.utils.ImageAnd64Binary;
import com.kst.activiti.utils.PathUtil;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.entity.ReturnDTO;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.ReturnDTOUtil;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.bpmn.model.FlowNode;
import org.activiti.bpmn.model.SequenceFlow;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.image.ProcessDiagramGenerator;
import org.activiti.spring.SpringProcessEngineConfiguration;
import org.apache.commons.io.FileUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: felixu
 * @createTime: 2017/11/26.
 */
@Controller
@RequestMapping("/workflow")
public class ActApplyWorkFlowController extends AcBusinessController {
    private static final Logger log = LoggerFactory.getLogger(ActApplyWorkFlowController.class);
    @Autowired
    SpringProcessEngineConfiguration spec;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private HistoryService historyService;
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private ProcessEngineConfigurationImpl processEngineConfiguration;
    // @Autowired
    //private ActApplyService actApplyService;
    @Value("${activiti-upload-path}")
    private String path;

    private final ResourceLoader resourceLoader;

    @Autowired
    public ActApplyWorkFlowController(ResourceLoader resourceLoader) {
        this.resourceLoader = resourceLoader;
    }

    //申请资产
    @GetMapping(value = "/list")
    public String list(org.springframework.ui.Model model, HttpServletRequest request) {
        ActApplyWorkFlow workFlow = new ActApplyWorkFlow();
        workFlow.setApplyStatus("未审核");
        model.addAttribute("workFlow", workFlow);
        return "workflowDemo/list";
    }

    //提交申请资产
    @PostMapping(value = "/insert")
    @ResponseBody
    public ReturnDTO insertForm(@RequestBody ActApplyWorkFlow actApplyWorkFlow, HttpServletRequest request) throws Exception {
        ProcessEngine engine = ProcessEngines.getDefaultProcessEngine();
        //引擎
        ProcessInstance instance = runtimeService.startProcessInstanceByKey("myProcess_1");
        System.out.println("流程创建成功，当前流程实例ID：" + instance.getId());
        actApplyWorkFlow.setFlowId(instance.getId());
        // if(actApplyService.save(actApplyWorkFlow)) {
        System.out.println("申请成功！");
        // }
        Task task = taskService.createTaskQuery().processInstanceId(instance.getId()).singleResult();
        InputStream image = reateProcessDiagram(engine, instance.getId());

        //String path = new File("").getCanonicalPath();
        //String path = ClassUtils.getDefaultClassLoader().getResource("").getPath();
        //path+"static/1.png";
        //File file= ResourceUtils.getFile("classpath:/static/image/process.png");
        try {
            FileUtils.copyInputStreamToFile(image, new File(path + "/process.png"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("当前流程节点：" + task.getName());
        log.info("当前流程节点：" + task.getName());
        completeTaksByVariables(actApplyWorkFlow.getAssetPrice(), task.getId());

        //applyEngine.close();
        return ReturnDTOUtil.success();
    }

    //申请单查询
    @GetMapping(value = "/tasklist")
    public String listApplies(Model model) {
        return "workflowDemo/examine";
    }

    //申请单列表
    @RequiresPermissions("sys:workflow:tasklist")
    @PostMapping("tasklist")
    @ResponseBody
    public DataTable<ActApplyWorkFlow> tasklist(@RequestBody DataTable dt, ServletRequest request) {
        //return actApplyService.pageSearch(dt);
        return null;
    }

    //审核通过
    @PostMapping(value = "/accept")
    @ResponseBody
    public ReturnDTO accept(@RequestBody ActApplyWorkFlow actApplyWorkFlow, HttpServletRequest request) throws Exception {
        ProcessInstance instance = runtimeService.createProcessInstanceQuery().processInstanceId(actApplyWorkFlow.getFlowId()).singleResult();
        if (instance == null) {
            return ReturnDTOUtil.fail();
        }
        Task task = taskService.createTaskQuery().processInstanceId(instance.getId()).singleResult();
        actApplyWorkFlow.setApplyStatus("审核通过");
        ProcessEngine engine = ProcessEngines.getDefaultProcessEngine();
        InputStream image = reateProcessDiagram(engine, instance.getId());
        try {
            FileUtils.copyInputStreamToFile(image, new File(path + "/process.png"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("当前流程节点：" + task.getName());
        completeTaksByVariables(actApplyWorkFlow.getAssetPrice(), task.getId());
        System.out.println("完成的id为：" + task.getId());
        //engine.close();
        return ReturnDTOUtil.success();
    }

    /**
     * 显示图片
     *
     * @param fileName 文件名
     * @return
     */
    @GetMapping(value = "/show")
    public ResponseEntity show(String fileName) {
        try {
            // 由于是读取本机的文件，file是一定要加上的， path是在application配置文件中的路径
            return ResponseEntity.ok(resourceLoader.getResource("file:" + path + fileName));
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }

    }

    //打开图片
    @GetMapping(value = "/openImg")
    public String openImg(org.springframework.ui.Model model, String fileName,String instId) {
        PageData pd = new PageData();
        String FILENAME = fileName;
        try {
            createXmlAndPngAtNowTask(instId,FILENAME);//生成当前任务节点的流程图片
        } catch (IOException e) {
            e.printStackTrace();
        }
        pd.put("FILENAME", FILENAME);
        String imgSrcPath = PathUtil.getProjectpath()+ Const.FILEACTIVITI+FILENAME;
        pd.put("imgSrc", "data:image/jpeg;base64,"+ ImageAnd64Binary.getImageStr(imgSrcPath)); //解决图片src中文乱码，把图片转成base64格式显示(这样就不用修改tomcat的配置了)
        model.addAttribute("pd", pd);
        return "process/processImg";
    }

    public void completeTaksByVariables(String price, String taskId) {
        Map<String, Object> variables = new HashMap<>();
        variables.put("price", price);
        taskService.complete(taskId, variables);
    }


    private InputStream reateProcessDiagram(ProcessEngine processEngine, String processInstanceId) {
        // TODO Auto-generated method stub
        //获取历史流程实例
        HistoricProcessInstance historicProcessInstance = processEngine.getHistoryService().createHistoricProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();
        log.info("历史流程id:【{}】", historicProcessInstance.getId());
        //获取历史流程定义
        ProcessDefinitionEntity processDefinitionEntity = (ProcessDefinitionEntity) ((RepositoryServiceImpl)
                processEngine.getRepositoryService()).getDeployedProcessDefinition(historicProcessInstance
                .getProcessDefinitionId());
        //查询历史节点
        List<HistoricActivityInstance> historicActivityInstanceList = processEngine.getHistoryService().createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId).orderByHistoricActivityInstanceId().asc().list();
        //已执行历史节点
        List<String> executedActivityIdList = new ArrayList<>();
        historicActivityInstanceList.forEach(historicActivityInstance -> {
            executedActivityIdList.add(historicActivityInstance.getActivityId());
        });

        BpmnModel bpmnModel = processEngine.getRepositoryService().getBpmnModel(processDefinitionEntity.getId());
        //已执行flow的集和
        List<String> executedFlowIdList = executedFlowIdList(bpmnModel, processDefinitionEntity, historicActivityInstanceList);

        ProcessDiagramGenerator processDiagramGenerator = processEngine.getProcessEngineConfiguration().getProcessDiagramGenerator();
        InputStream diagram = processDiagramGenerator.generateDiagram(bpmnModel, "png", executedActivityIdList, executedFlowIdList, "黑体", "黑体", "黑体", null, 1.0);

        return diagram;
    }

    private List<String> executedFlowIdList(BpmnModel bpmnModel, ProcessDefinitionEntity processDefinitionEntity,
                                            List<HistoricActivityInstance> historicActivityInstanceList) {

        List<String> executedFlowIdList = new ArrayList<>();
        for (int i = 0; i < historicActivityInstanceList.size() - 1; i++) {
            HistoricActivityInstance hai = historicActivityInstanceList.get(i);
            FlowNode flowNode = (FlowNode) bpmnModel.getFlowElement(hai.getActivityId());
            List<SequenceFlow> sequenceFlows = flowNode.getOutgoingFlows();
            if (sequenceFlows.size() > 1) {
                HistoricActivityInstance nextHai = historicActivityInstanceList.get(i + 1);
                sequenceFlows.forEach(sequenceFlow -> {
                    if (sequenceFlow.getTargetFlowElement().getId().equals(nextHai.getActivityId())) {
                        executedFlowIdList.add(sequenceFlow.getId());
                    }
                });
            } else {
                executedFlowIdList.add(sequenceFlows.get(0).getId());
            }
        }

        return executedFlowIdList;
    }

    private static void dealTask(ProcessEngine processEngine, ProcessInstance processInstance) {
        // TODO Auto-generated method stub
        while (processInstance != null && !processInstance.isEnded()) {
            Execution currentExecution = processEngine.getRuntimeService().createExecutionQuery()
                    .processInstanceId(processInstance.getId()).onlyProcessInstanceExecutions().singleResult();
            Task currentTask = processEngine.getTaskService().createTaskQuery().processInstanceId(currentExecution.getId())
                    .singleResult();
            log.info("当前任务为：【】,完成任务", currentTask.getName());
            if ("User Task-2".equals(currentTask.getName())) {
                break;
            }
            processEngine.getTaskService().complete(currentTask.getId());
        }
    }

    private static ProcessInstance startProcessInstance(ProcessEngine processEngine,
                                                        ProcessDefinition processDefinition) {
        // TODO Auto-generated method stub
        ProcessInstance processInstance = processEngine.getRuntimeService().startProcessInstanceByKey(processDefinition.getKey());
        log.info("processInstanceId:【{}】", processInstance.getId());
        log.info("processDefinitionKey:【{}】", processInstance.getProcessDefinitionKey());
        return processInstance;
    }

    private static ProcessDefinition deployProcessDefinition(ProcessEngine processEngine) {
        // TODO Auto-generated method stub
        InputStream bpmn = ActApplyWorkFlowController.class.getResourceAsStream("MyProcess.bpmn");
        InputStream Png = ActApplyWorkFlowController.class.getResourceAsStream("MyProcess.png");
        RepositoryService repositoryService = processEngine.getRepositoryService();
        Deployment deployment = repositoryService.createDeployment()
                .addInputStream("MyProcess.bpmn", bpmn)
                .addInputStream("MyProcess.png", Png).deploy();

        InputStream subBpmn = ActApplyWorkFlowController.class.getResourceAsStream("SubProcess.bpmn");
        InputStream subPng = ActApplyWorkFlowController.class.getResourceAsStream("SubProcess.png");
        repositoryService.createDeployment()
                .addInputStream("SubProcess.bpmn", subBpmn)
                .addInputStream("SubProcess.png", subPng).deploy();

        log.info("deploymentId:【{}】", deployment.getId());
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .deploymentId(deployment.getId())
                .singleResult();
        log.info("processDefinitionId:【{}】", processDefinition.getId());
        log.info("processDefinitionName:【{}】", processDefinition.getName());
        log.info("processDefinitionKey:【{}】", processDefinition.getKey());
        return processDefinition;
    }

//    @SuppressWarnings("static-access")
//    private static ProcessEngine createProcessEngine() {
//        // TODO Auto-generated method stub
//        ProcessEngineConfiguration cfg = ProcessEngineConfiguration.createStandaloneInMemProcessEngineConfiguration();
//        cfg.setJdbcDriver("com.mysql.jdbc.Driver");
//        cfg.setJdbcUrl("jdbc:mysql://localhost:3306/activiti-test?useUnicode=true&characterEncoding=utf8");
//        cfg.setJdbcUsername("root");
//        cfg.setJdbcPassword("0118");
//        cfg.setHistory(HistoryLevel.FULL.getKey());
//        cfg.setDatabaseSchemaUpdate("true");
//        ProcessEngine processEngine = cfg.buildProcessEngine();
//        String name = processEngine.getName();
//        String version = processEngine.VERSION;
//        log.info("引擎名称："+name+"  引擎版本："+version);
//        return processEngine;
//    }

}