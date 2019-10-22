package com.kst;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication(exclude={SecurityAutoConfiguration.class,org.activiti.spring.boot.SecurityAutoConfiguration.class},scanBasePackages = "com.kst")
@EnableScheduling
@EnableCaching
@EnableTransactionManagement
@MapperScan("*.mapper")
public class KstWebApplication {

    public static void main(String[] args) {
        SpringApplication.run(KstWebApplication.class, args);
    }

}
