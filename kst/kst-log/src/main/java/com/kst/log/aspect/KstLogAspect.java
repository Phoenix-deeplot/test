package com.kst.log.aspect;

import com.alibaba.fastjson.JSONObject;
import com.google.common.util.concurrent.ThreadFactoryBuilder;
import com.kst.common.exception.GlobalExceptionHandler;
import com.kst.common.shiro.MySysUser;
import com.kst.common.utils.ServletUtils;
import com.kst.common.utils.ToolUtil;
import com.kst.log.annotation.SysLog;
import com.kst.log.entity.Log;
import com.kst.log.service.ILogService;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.concurrent.*;

/**
 * Created by wangl on 2018/1/13.
 * todo:
 */
@Aspect
@Component
public class KstLogAspect {

    /**
     * 保存日志到数据库的线程池
     */
    ThreadFactory threadFactory = new ThreadFactoryBuilder().setNameFormat("kstLogAspect-Thread-%d").build();

    ExecutorService executor = new ThreadPoolExecutor(5,200,0L, TimeUnit.MILLISECONDS,
            new LinkedBlockingQueue<Runnable>(1024),
            threadFactory,
            new ThreadPoolExecutor.AbortPolicy());

    @Pointcut("@annotation(com.kst.log.annotation.SysLog)")
    public void webLog(){}

    @Around("webLog()")
    public Object doAround(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
        long beginTime = System.currentTimeMillis();
        // 获取request
        HttpServletRequest request = ServletUtils.getHttpServletRequest();
        HttpSession session = ServletUtils.getHttpSession();
        String method = request.getMethod();
        String ip = ToolUtil.getClientIp(request);
        String requestUrl = request.getRequestURL().toString();
        String sessionId = session.getId();
        Map<String,String> browserMap = ToolUtil.getOsAndBrowserInfo(request);
        String browser = browserMap.get("os")+"-"+browserMap.get("browser");
        Boolean isAjax = ToolUtil.isAjax(request);
        // 执行方法
        Object result = proceedingJoinPoint.proceed();
        // 执行时长(毫秒)
        long time = System.currentTimeMillis() - beginTime;

        SaveLogTask saveLogTask = new SaveLogTask(method, ip, requestUrl, isAjax, browser, sessionId,
                proceedingJoinPoint, result, time);

        executor.execute(saveLogTask);//保存日志到数据库

        return result;
    }
}
