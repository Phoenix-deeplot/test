package com.kst.log.aspect;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.kst.common.shiro.MySysUser;
import com.kst.common.shiro.ShiroUser;
import com.kst.common.utils.ApplicationContextRegister;
import com.kst.common.utils.ToolUtil;
import com.kst.log.annotation.SysLog;
import com.kst.log.entity.Log;
import com.kst.log.mapper.LogMapper;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Map;

/**
 *
 * @author zjf
 * @date 2019/6/10
 *
 * Describe:
 */
public class SaveLogTask implements Runnable {
    private LogMapper LogDao = ApplicationContextRegister.getBean(LogMapper.class);

    private String method;
    private String ip;
    private String requestUrl;
    private Boolean isAjax;
    private String browser;
    private String sessionId;
    private ProceedingJoinPoint joinPoint;
    private Object result;
    private long time;

    public SaveLogTask(String method, String ip, String requestUrl, Boolean isAjax, String browser, String sessionId,
                       ProceedingJoinPoint point, Object result, long time) {

        this.method = method;
        this.ip = ip;
        this.requestUrl = requestUrl;
        this.isAjax = isAjax;
        this.browser = browser;
        this.sessionId = sessionId;
        this.joinPoint = point;
        this.result = result;
        this.time = time;
    }

    @Override
    public void run() {
        saveLog(method, ip, requestUrl, isAjax, browser, sessionId, joinPoint, result, time);
    }

    /**
     * 保存日志 到数据库
     *
     * @param joinPoint
     * @param time
     */
    private void saveLog(String method, String ip, String requestUrl, Boolean isAjax, String browser, String sessionId,
                         ProceedingJoinPoint joinPoint, Object result, long time) {
        Log sysLog = new Log();

        sysLog.setClassMethod(joinPoint.getSignature().getDeclaringTypeName() + "." + joinPoint.getSignature().getName());
        sysLog.setHttpMethod(method);
        //获取传入目标方法的参数
        Object[] args = joinPoint.getArgs();
        for (int i = 0; i < args.length; i++) {
            Object o = args[i];
            if(o instanceof ServletRequest || (o instanceof ServletResponse) || o instanceof MultipartFile){
                args[i] = o.toString();
            }
        }
        String str = JSONObject.toJSONString(args);
        sysLog.setParams(str.length()>5000?JSONObject.toJSONString("请求参数数据过长不与显示"):str);
        if("0.0.0.0".equals(ip) || "0:0:0:0:0:0:0:1".equals(ip) || "localhost".equals(ip) || "127.0.0.1".equals(ip)){
            ip = "127.0.0.1";
        }
        sysLog.setRemoteAddr(ip);
        sysLog.setRequestUri(requestUrl);
        sysLog.setSessionId(sessionId);
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method methodObj = signature.getMethod();
        SysLog mylog = methodObj.getAnnotation(SysLog.class);
        if(mylog != null){
            //注解上的描述
            sysLog.setTitle(mylog.value());
        }

        sysLog.setBrowser(browser);

        sysLog.setType(isAjax?"Ajax请求":"普通请求");
        if(MySysUser.ShiroUser() != null) {
            sysLog.setUsername(StringUtils.isNotBlank(MySysUser.nickName()) ? MySysUser.nickName() : MySysUser.loginName());
        }

        String retString = JSONObject.toJSONString(result);
        sysLog.setResponse(retString.length()>5000?JSONObject.toJSONString("请求参数数据过长不与显示"):retString);

        sysLog.setUseTime(time);

        // 保存系统日志
        LogDao.insert(sysLog);
    }
}
