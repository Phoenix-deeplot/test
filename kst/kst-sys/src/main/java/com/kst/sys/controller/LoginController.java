package com.kst.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.kst.common.base.controller.BaseController;
import com.kst.common.shiro.MySysUser;
import com.kst.common.utils.*;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.entity.Menu;
import com.kst.sys.api.service.IUserService;
import com.kst.sys.utils.PasswordUtils;
import freemarker.template.SimpleDate;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.session.SessionException;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@SessionAttributes(value = {"projectName", "adminText"})
public class LoginController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private IUserService userService;

    @Value("${server.port}")
    private String port;

    @Value("${key1}")
    private String key1;

    @Value("${key2}")
    private String key2;

    @Value("${key3}")
    private String key3;

    @Value("${adminText}")
    private String adminText;

    @Value("${projectName}")
    private String projectName;


    @GetMapping("login")
    public String login(HttpServletRequest request, Model model) throws UnknownHostException, ParseException {
        //获取本地MAC码
        InetAddress ia = InetAddress.getLocalHost();
        String localMac = MACUtil.getLocalMac(ia);
        System.out.println("本机的MAC地址:"+localMac);
        //加密，判断
        String hashPassword = PasswordUtils.entryptPassword(localMac, localMac.replace("-", ""));


        //获取到期时间
        String numCode=Encodes.decodeBase64String(key3);
        Integer limit=Integer.parseInt(numCode.substring(12));
        System.out.println("用户人数限制"+limit);

        QueryWrapper qw=new QueryWrapper();
        qw.eq("del_flag",false);
        Integer userCount=this.userService.list(qw).size();
        System.out.println("当前数据库用户数"+userCount);

        String dateCode = Encodes.decodeBase64String(key2);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Date date = sdf.parse(dateCode.substring(0, 8));


        model.addAttribute("projectName", projectName);
        model.addAttribute("adminText", adminText);

        if (!hashPassword.equals(key1)) {
            model.addAttribute("message", "1");
            return "/error/error";
        } else if (date.getTime() < new Date().getTime()) {
            model.addAttribute("message", "2");
            return "/error/error";
        } else if (userCount>limit) {
            model.addAttribute("message", "3");
            return "/error/error";
        } else {
            LOGGER.info("跳到这边的路径为:" + request.getRequestURI());
            Subject s = SecurityUtils.getSubject();
            LOGGER.info("是否记住登录--->" + s.isRemembered() + "<-----是否有权限登录----->" + s.isAuthenticated() + "<----");
            if (s.isAuthenticated()) {
                return "redirect:index";
            } else {
                return "login";
            }
        }
    }

    @PostMapping("login/main")
    @ResponseBody
    @SysLog("用户登录")
    public RestResponse loginMain(HttpServletRequest request, Model model) {
        String username = request.getParameter("username").toUpperCase();
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        String code = request.getParameter("code");
		/*if(StringUtils.isBlank(username) || StringUtils.isBlank(password)){
			return RestResponse.failure("用户名或者密码不能为空");
		}
		if(StringUtils.isBlank(rememberMe)){
			return RestResponse.failure("记住我不能为空");
		}
		if(StringUtils.isBlank(code)){
			return  RestResponse.failure("验证码不能为空");
		}*/
        Map<String, Object> map = Maps.newHashMap();
        String errorCode = null;
        String errorMsg = null;
        HttpSession session = request.getSession();
        if (session == null) {
            return RestResponse.failure("2", "session超时");//
        }
        String trueCode = (String) session.getAttribute(Constants.VALIDATE_CODE);
        if (StringUtils.isBlank(trueCode)) {
            return RestResponse.failure("4", "codePass");//验证码超时
        }
        if (StringUtils.isBlank(code) || !trueCode.toLowerCase().equals(code.toLowerCase())) {
            errorCode = "4";
            errorMsg = "codeErr";//验证码错误
        } else {
            /*就是代表当前的用户。*/
            Subject user = SecurityUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(username, password, Boolean.valueOf(rememberMe));
            try {
                user.login(token);
                if (user.isAuthenticated()) {
                    map.put("url", "index");
                }
                //0 未授权 1 账号问题 2 密码错误  3 账号密码错误
            } catch (IncorrectCredentialsException e) {
                errorCode = "2";
                errorMsg = "passWrong";//登录密码错误.
            } catch (ExcessiveAttemptsException e) {
                errorCode = "3";
                errorMsg = "failureMore";//登录失败次数过多
            } catch (LockedAccountException e) {
                errorCode = "1";
                errorMsg = "locked";//用户已被锁定.
            } catch (DisabledAccountException e) {
                errorCode = "1";
                errorMsg = "forbidden";//用户已被禁用.
            } catch (ExpiredCredentialsException e) {
                errorCode = "1";
                errorMsg = "pastDue";//用户已过期.
            } catch (UnknownAccountException e) {
                errorCode = "1";
                errorMsg = "noUser";//用户不存在
            } catch (UnauthorizedException e) {
                errorCode = "1";
                errorMsg = "noPermission";//您没有得到相应的授权！
            }
        }
        if (StringUtils.isBlank(errorMsg)) {
            return RestResponse.success().setData(map);
        } else {
            return RestResponse.failure(errorCode, errorMsg);
        }
    }

    /**
     * 获取验证码图片和文本(验证码文本会保存在HttpSession中)
     */
    @GetMapping("/genCaptcha")
    public void genCaptcha(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        String verifyCode = VerifyCodeUtil.generateTextCode(VerifyCodeUtil.TYPE_ALL_MIXED, 4, null);
        //将验证码放到HttpSession里面
        request.getSession().setAttribute(Constants.VALIDATE_CODE, verifyCode);
        LOGGER.info("本次生成的验证码为[" + verifyCode + "],已存放到HttpSession中");
        //设置输出的内容的类型为JPEG图像
        response.setContentType("image/jpeg");
        BufferedImage bufferedImage = VerifyCodeUtil.generateImageCode(verifyCode, 116, 36, 5, true, new java.awt.Color(249, 205, 173), null, null);
        //写给浏览器
        ImageIO.write(bufferedImage, "JPEG", response.getOutputStream());
    }

    @GetMapping("main")
    public String main(Model model) {
        Map map = userService.selectUserMenuCount();
        User user = userService.findUserById(MySysUser.id());
        Set<Menu> menus = user.getMenus();
        List<Menu> showMenus = Lists.newArrayList();
        if (menus != null && menus.size() > 0) {
            for (Menu menu : menus) {
                if (StringUtils.isNotBlank(menu.getHref())) {
                    Long result = (Long) map.get(menu.getPermission());
                    if (result != null) {
                        menu.setDataCount(result.intValue());
                        showMenus.add(menu);
                    }
                }
            }
        }
        showMenus.sort(new MenuComparator());
        model.addAttribute("userMenu", showMenus);
        return "main";
    }

    @GetMapping("systemLogout")
    @SysLog("退出系统")
    public String logOut() {
        return "/login";
    }
}

class MenuComparator implements Comparator<Menu> {

    @Override
    public int compare(Menu o1, Menu o2) {
        if (o1.getSort() > o2.getSort()) {
            return -1;
        } else {
            return 0;
        }

    }
}