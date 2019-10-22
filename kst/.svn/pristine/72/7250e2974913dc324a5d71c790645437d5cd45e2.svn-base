package com.kst.sys.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.common.collect.Lists;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.constant.Setting;
import com.kst.common.shiro.MySysUser;
import com.kst.common.utils.*;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Resource;
import com.kst.sys.api.entity.Role;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.*;
import com.kst.sys.api.vo.ShowMenu;
import com.kst.sys.utils.PasswordUtils;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

/**
 * Created by zjf on 2017/11/21.
 */
@Controller
@RequestMapping("sys/user")
public class UserController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private IUserService userService;

    @Autowired
    private IRoleService roleService;

    @Autowired
    private IMenuService menuService;

    @Autowired
    private IOrganizationService organizationService;

    @Autowired
    private IMsgService msgService;

    @Autowired
    private IDictService dictService;

    @Value("${key3}")
    private String key3;

    @GetMapping("list")
    @SysLog("跳转系统用户列表页面")
    @RequiresPermissions("sys:user:list")
    public String list() {
        return "sys/user/list";
    }


    @PostMapping("list")
    @ResponseBody
    public DataTable<User> list(@RequestBody DataTable dt, ServletRequest request) {
        return userService.pageSearch(dt);
    }

    @GetMapping("add")
    @RequiresPermissions("sys:user:add")
    public String add(Model model) {
        List<Role> roleList = roleService.selectAll();
        model.addAttribute("roleList", roleList);
        return "sys/user/detail";
    }

    @GetMapping("home")
    public String home(Model model, HttpServletRequest request) {
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("type", "sys_msg_type");
        wrapper.eq("del_flag", false);
        model.addAttribute("msgTypes", this.dictService.list(wrapper));
        model.addAttribute("msgList", this.msgService.selectMsgByUserId(MySysUser.id()));
        return "home";
    }

    @GetMapping("getRoleList")
    @ResponseBody
    public List<Role> getRoleList() {
        List<Role> roleList = roleService.selectAll();
        return roleList;
    }

    @PostMapping("add")
    @ResponseBody
    @SysLog("保存新增系统用户数据")
    public RestResponse add(@RequestBody User user) {
        user.setPassword(Constants.DEFAULT_PASSWORD);
        if (user.getIcon() == null || user.getIcon() == "") {
            user.setIcon("/attach/headPortrait/default.jpg");
        }

        userService.saveUser(user);
        if (user.getId() == null || user.getId() == 0) {
            return RestResponse.failure("保存用户信息出错");
        }
        return RestResponse.success();
    }

    @PostMapping("checkLoginNameExist/{mode}")
    @ResponseBody
    @SysLog("用户名存在验证")
    public RestResponse checkLoginNameExist(@PathVariable("mode") Integer mode, String loginName, Long id) {
        boolean result = true;

        loginName = loginName.toUpperCase();

        if (1 == mode) {    //新增场合
            if (userService.userCount("login_name", loginName) > 0) {
                result = false;
            }
        } else if (2 == mode) {  //编辑场合
            User oldUser = userService.findUserById(id);
            if (StringUtils.isNotBlank(loginName)) {
                if (!loginName.equals(oldUser.getLoginName())) {
                    if (userService.userCount("login_name", loginName) > 0) {
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @PostMapping("checkMailExist/{mode}")
    @ResponseBody
    @SysLog("邮箱存在验证")
    public RestResponse checkMailExist(@PathVariable("mode") Integer mode, String email, Long id) {
        boolean result = true;

        if (1 == mode) {    //新增场合
            if (userService.userCount("email", email) > 0) {
                result = false;
            }
        } else if (2 == mode) {  //编辑场合
            User oldUser = userService.findUserById(id);
            if (StringUtils.isNotBlank(email)) {
                if (!email.equals(oldUser.getEmail())) {
                    if (userService.userCount("email", email) > 0) {
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @PostMapping("checkTelExist/{mode}")
    @ResponseBody
    @SysLog("手机存在验证")
    public RestResponse checkTelExist(@PathVariable("mode") Integer mode, String tel, Long id) {
        boolean result = true;

        if (1 == mode) {    //新增场合
            if (userService.userCount("tel", tel) > 0) {
                result = false;
            }
        } else if (2 == mode) {  //编辑场合
            User oldUser = userService.findUserById(id);
            if (StringUtils.isNotBlank(tel)) {
                if (!tel.equals(oldUser.getTel())) {
                    if (userService.userCount("tel", tel) > 0) {
                        result = false;
                    }
                }
            }
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @GetMapping("edit/{id}")
    @RequiresPermissions("sys:user:edit")
    public String edit(@PathVariable("id") Long id, Model model) {
        User user = userService.findUserById(id);
        List<Long> roleIdList = Lists.newArrayList();
        if (user != null) {
            Set<Role> roleSet = user.getRoleLists();
            if (roleSet != null && roleSet.size() > 0) {
                for (Role r : roleSet) {
                    roleIdList.add(r.getId());
                }
            }
        }
        List<Role> roleList = roleService.selectAll();
        model.addAttribute("localuser", user);
        model.addAttribute("roleIds", roleIdList);
        model.addAttribute("roleList", roleList);
        return "sys/user/detail";
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("保存系统用户编辑数据")
    public RestResponse edit(@RequestBody User user) {
        User oldUser = userService.findUserById(user.getId());
        if (user.getIcon() == null || user.getIcon() == "") {
            user.setIcon(oldUser.getIcon());
        }
        userService.updateUser(user);
        return RestResponse.success();
    }

    @PostMapping("uploadHeadPortrait")
    @ResponseBody
    //上传用户头像
    public String uploadHeadPortrait(@RequestParam("file") MultipartFile file) {
        String uuid = FileUtils.createFileName();//创建文件名称

        String fileExt = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();//扩展名
        String savePath = Setting.BASEFLODER + "/" + "headPortrait" + "/" + uuid + "." + fileExt;//附件路径+类型（头像、附件等）+名称+扩展名

        System.out.println(savePath + " " + fileExt);
        FileUtils.saveFileToDisk(file, savePath);

        File localFile = null;
        try {
            localFile = new File(new File("").getCanonicalPath() + "/" + savePath);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String thumbnailName = "";
        if (FileUtils.getImageFormat(fileExt)) {
            //创建缩略图
            thumbnailName = Setting.BASEFLODER + "/" + "headPortrait" + "/s/" + uuid + "." + fileExt;//附件路径+类型（头像、附件等）+s(文件夹)+名称+扩展名
            FileUtils.createThumbnail(localFile, thumbnailName);
        }

        savePath = "/" + savePath;
        return savePath;
    }

    @RequiresPermissions("sys:user:delete")
    @PostMapping("delete")
    @ResponseBody
    @SysLog("删除系统用户数据(单个)")
    public RestResponse delete(@RequestParam(value = "id", required = false) Long id) {
        if (id == null || id == 0 || id == 1) {
            return RestResponse.failure("参数错误");
        }
        User user = userService.findUserById(id);
        if (user == null) {
            return RestResponse.failure("用户不存在");
        }
        organizationService.deleteUserFromOrganization(null, user.getId());
        userService.deleteUser(user);
        return RestResponse.success();
    }

    @RequiresPermissions("sys:user:delete")
    @PostMapping("deleteSome")
    @ResponseBody
    @SysLog("删除系统用户数据(多个)")
    public RestResponse deleteSome(@RequestBody List<User> users) {
        for (User u : users) {
            if (u.getId() == 1) {
                return RestResponse.failure("不能删除超级管理员");
            } else {
                organizationService.deleteUserFromOrganization(null, u.getId());
                userService.deleteUser(u);
            }
        }
        return RestResponse.success();
    }

    /***
     * 获得用户所拥有的菜单列表
     * @return
     */
    @GetMapping("getUserMenu")
    @ResponseBody
    public List<ShowMenu> getUserMenu() {
        Long userId = MySysUser.id();
        List<ShowMenu> list = menuService.getShowMenuByUser(userId);
        return list;
    }

    @GetMapping("userinfo")
    public String toEditMyInfo(Model model) {
        Long userId = MySysUser.id();
        User user = userService.findUserById(userId);
        model.addAttribute("userinfo", user);
        model.addAttribute("userRole", user.getRoleLists());
        return "sys/user/userInfo";
    }

    @PostMapping("saveUserinfo")
    @SysLog("系统用户个人信息修改")
    @ResponseBody
    public RestResponse saveUserInfo(@RequestBody User user) {

        User oldUser = userService.findUserById(user.getId());
        user.setDisableFlag(oldUser.getDisableFlag());
        user.setRoleLists(oldUser.getRoleLists());
        userService.updateUser(user);
        return RestResponse.success();
    }

    @GetMapping("changePassword")
    public String changePassword() {
        return "sys/user/changePassword";
    }

    @RequiresPermissions("sys:user:changePassword")
    @PostMapping("changePassword")
    @SysLog("用户修改密码")
    @ResponseBody
    public RestResponse changePassword(@RequestParam(value = "oldPwd", required = false) String oldPwd,
                                       @RequestParam(value = "newPwd", required = false) String newPwd,
                                       @RequestParam(value = "confirmPwd", required = false) String confirmPwd) {
        //System.out.println("修改密碼"+oldPwd+" "+newPwd+" "+confirmPwd);
        if (StringUtils.isBlank(oldPwd)) {
            return RestResponse.failure("旧密码不能为空");
        }
        if (StringUtils.isBlank(newPwd)) {
            return RestResponse.failure("新密码不能为空");
        }
        if (StringUtils.isBlank(confirmPwd)) {
            return RestResponse.failure("确认密码不能为空");
        }
        if (!confirmPwd.equals(newPwd)) {
            return RestResponse.failure("确认密码与新密码不一致");
        }
        User user = userService.findUserById(MySysUser.id());

        //旧密码不能为空
        String pw = PasswordUtils.entryptPassword(oldPwd, user.getSalt()).split(",")[0];
        if (!user.getPassword().equals(pw)) {
            return RestResponse.failure("旧密码错误");
        }
        user.setPassword(newPwd);
        PasswordUtils.entryptPassword(user);
        userService.updateUser(user);
        return RestResponse.success();
    }

    private String upload(String type, String fileName) {
        String uuid = FileUtils.createFileName();//创建文件名称

        String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();//扩展名

        String savePath = Setting.BASEFLODER + "/" + type + "/" + uuid + "." + fileExt;//附件路径+类型（头像、附件等）+名称+扩展名
        File localFile = FileUtils.saveFileToDisk(fileName, savePath); //保存到磁盘

        String thumbnailName = "";
        if (FileUtils.getImageFormat(fileExt)) {
            //创建缩略图
            thumbnailName = Setting.BASEFLODER + "/" + type + "/s/" + uuid + "." + fileExt;//附件路径+类型（头像、附件等）+s(文件夹)+名称+扩展名
            FileUtils.createThumbnail(localFile, thumbnailName);
        }

        LOGGER.info("上传的文件地址为 fileName={}", savePath);
        return "/" + savePath;
    }

    @PostMapping("getUserCount")
    @ResponseBody
    public boolean getUserCount() {
        String numCode = Encodes.decodeBase64String(key3);
        Integer limit = Integer.parseInt(numCode.substring(12));
        System.out.println("用户人数限制" + limit);

        QueryWrapper qw = new QueryWrapper();
        qw.eq("del_flag", false);
        Integer userCount = this.userService.list(qw).size();
        System.out.println("数据库用户数量" + userCount);
        boolean ret = true;
        if (limit <= userCount) {
            ret = false;
        }
        return ret;
    }

    @GetMapping("downloadUserCSVData")
    public void downloadUserCSVData(String ids, HttpServletResponse response) {
        List<String> classList = Arrays.asList(ids.split(","));

        QueryWrapper wrapper = new QueryWrapper();
        wrapper.in("id", classList);
        List<User> users = this.userService.list(wrapper);
        String[] head = {"编号", "用户名", "昵称", "电话", "邮箱"};
        List<Object> heads = Arrays.asList(head);
        List<List<Object>> dataList = new ArrayList<>();
        for (User li : users) {
            List<Object> l = new ArrayList<>();
            l.add(li.getId());
            l.add(li.getLoginName());
            l.add(li.getNickName());
            l.add(li.getTel());
            l.add(li.getEmail());
            dataList.add(l);
        }
        DocumentOutUtils.createExcel(heads, dataList, response, "UserData");
    }

    //进入选择用户页面
    @GetMapping("choiceUser")
    public String choiceUser() {
        return "sys/user/choiceUser";
    }

    @PostMapping("initialize")
    @RequiresPermissions("sys:user:initialize")
    @ResponseBody
    public RestResponse initializeUserPassword(@RequestBody List<User> users) {
        System.out.println("初始化用户");
        for (User user : users) {
            user=this.userService.findUserById(user.getId());
            user.setPassword("123456");
            PasswordUtils.entryptPassword(user);
            userService.updateUser(user);
        }


        return RestResponse.success();
    }

}
