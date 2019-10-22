package com.kst.activiti.test;



import org.activiti.engine.*;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;


//@SpringBootTest(classes = App.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class ActivitiTest {
    public static void main(String args[]){
// 部署流程文件
        //流程配置引擎
        ProcessEngineConfiguration pec = ProcessEngineConfiguration.createStandaloneProcessEngineConfiguration();

        pec.setJdbcDriver("com.mysql.cj.jdbc.Driver");
        pec.setJdbcUrl("jdbc:mysql://192.168.1.220:3306/kst?characterEncoding=utf-8&serverTimezone=GMT");
        pec.setJdbcUsername("root");
        pec.setJdbcPassword("root");
        //选择true   会自动创建表且当数据发生变化时会更新表中的数据
        pec.setDatabaseSchemaUpdate(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_TRUE);
        //创建流程引擎
        ProcessEngine pe = pec.buildProcessEngine();

        RepositoryService rs = pe.getRepositoryService();

        RuntimeService runService = pe.getRuntimeService();

        TaskService ts = pe.getTaskService();

        Deployment deployment = rs.createDeployment().addClasspathResource("processes/test02.bpmn").deploy();

        ProcessDefinition processDefinition = rs.createProcessDefinitionQuery().deploymentId(deployment.getId()).singleResult();

        ProcessInstance instance = runService.startProcessInstanceById(processDefinition.getId());

        Task task = ts.createTaskQuery().processInstanceId(instance.getId()).singleResult();
        System.out.println("当前流程节点："+task.getName());
        ts.complete(task.getId());

        Task task1 = ts.createTaskQuery().processInstanceId(instance.getId()).singleResult();
        System.out.println("当前流程节点："+task1);

        pe.close();
        System.exit(0);


        //-----------------------------************************************************************

//        //根据bpmn文件部署流程
//        Deployment deployment = repositoryService.createDeployment().addClasspathResource("demo2.bpmn").deploy();
//        //获取流程定义
//        //ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(deployment.getId()).singleResult();
//        //启动流程定义，返回流程实例
//        ProcessInstance pi = runtimeService.startProcessInstanceById(processDefinition.getId());
//        String processId = pi.getId();
//        System.out.println("流程创建成功，当前流程实例ID："+processId);
//
//        Task task=taskService.createTaskQuery().processInstanceId(processId).singleResult();
//        System.out.println("第一次执行前，任务名称："+task.getName());
//        taskService.complete(task.getId());
//
//        task = taskService.createTaskQuery().processInstanceId(processId).singleResult();
//        System.out.println("第二次执行前，任务名称："+task.getName());
//        taskService.complete(task.getId());
//
//        task = taskService.createTaskQuery().processInstanceId(processId).singleResult();
//        System.out.println("task为null，任务执行完毕："+task);
    }
}
