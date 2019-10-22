package com.kst.activiti.config;

import com.alibaba.druid.pool.DruidDataSource;

import org.activiti.spring.ProcessEngineFactoryBean;
import org.activiti.spring.SpringProcessEngineConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.transaction.PlatformTransactionManager;
import java.io.IOException;

/**
 * @author : ys
 * @createdate
 */
@Configuration
public class ActivitiConfig {
    @Autowired
    private DruidDataSource dataSource;
    @Autowired
    private PlatformTransactionManager platformTransactionManager;
    @Bean
    public SpringProcessEngineConfiguration springProcessEngineConfiguration(){
        SpringProcessEngineConfiguration spec = new SpringProcessEngineConfiguration();
        spec.setDataSource(dataSource);
        spec.setActivityFontName("宋体");
        spec.setLabelFontName("宋体");
        spec.setAnnotationFontName("宋体");
        spec.setTransactionManager(platformTransactionManager);
        spec.setDatabaseSchemaUpdate("true");

        System.out.println("ProcessEngineConfigurationConfigurer");
        System.out.println(spec.getActivityFontName());
        Resource[] resources = null;
        // 启动自动部署流程
        try {
            resources = new PathMatchingResourcePatternResolver().getResources("processes/test02.bpmn");
        } catch (IOException e) {
            e.printStackTrace();
        }
        spec.setDeploymentResources(resources);
        return spec;
    }
    @Bean
    public ProcessEngineFactoryBean processEngine(){
        ProcessEngineFactoryBean processEngineFactoryBean = new ProcessEngineFactoryBean();
        processEngineFactoryBean.setProcessEngineConfiguration(springProcessEngineConfiguration());
        return processEngineFactoryBean;
    }
}