package com.kst.sys.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.vo.DataTable;
import com.kst.common.shiro.MySysUser;
import com.kst.common.utils.FileUtils;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.*;
import com.kst.sys.api.service.*;
import com.kst.sys.api.vo.UserVO;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("sys/question")
public class SysQuestionController {
    @Autowired
    private ISysQuestionService sysQuestionService;
    @Autowired
    private IDictService dictService;
    @Autowired
    private IResourceService resourceService;
    @Autowired
    private IMsgService msgService;
    @Autowired
    private IMsgReadlistService msgReadlistService;
    @Autowired
    private IUserService userService;
    @GetMapping("list")
    public String list(Model model, HttpServletRequest request) {
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","sys_qus_status");
        model.addAttribute("questionStatus",this.dictService.list(wrapper));

        wrapper=new QueryWrapper();
        wrapper.eq("type","sys_qus_flag");
        model.addAttribute("questionFlag",this.dictService.list(wrapper));

        User  user = (User)request.getAttribute("currentUser");
        model.addAttribute("loginName",user.getLoginName());
        return "sys/question/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<SysQuestion> list(@RequestBody DataTable dt){
        dt.getSearchParams().put("loginName",MySysUser.loginName());
        return this.sysQuestionService.selectSysQuestionByPage(dt);  //pageSearch(dt);
    }
    @GetMapping("add")
    public String add(Model model){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","sys_qus_status");
        List<Dict> questionStatus=this.dictService.list(wrapper);

        wrapper=new QueryWrapper();
        wrapper.eq("type","sys_qus_flag");
        List<Dict> questionFlag=this.dictService.list(wrapper);

        model.addAttribute("questionStatus",questionStatus);
        model.addAttribute("questionFlag",questionFlag);
        return "sys/question/detail";
    }
    @PostMapping("add")
    @ResponseBody
    public RestResponse add(@RequestBody SysQuestion question, HttpServletRequest request){
        User  user = (User)request.getAttribute("currentUser");
        question.setQusPusher(user.getLoginName());
        question.setQusPushdate(new Date());
        question.setQusStatus("0");
        if(question.isQusEnable() == true && question.getQusDesignator().equals("")){
        }else{
            this.sysQuestionService.save(question);
        }
        if(!question.getQusDesignator().equals("")){
            Msg msg = new Msg();
            msg.setLevel("2");
            msg.setTitle("通知消息【"+user.getNickName()+"】[向你提出问题]");
            msg.setShowFrom(new Date());
            msg.setShowTo(new Date());
            msg.setPushType("2");
            msg.setRemarks(question.getRemarks());
            msg.setDetail("问题内容：\n\r"+question.getQusPushdetail());
            msg.setPushDate(new Date());
            this.msgService.save(msg);

            MsgReadlist msgRead=new MsgReadlist();
            msgRead.setMsgId(msg.getId());
            QueryWrapper wrapper = new QueryWrapper();
            for(String d : question.getQusDesignator().split(",") ){
                wrapper.eq("nick_name",d);
                msgRead.setUserId(this.userService.getOne(wrapper).getId());
                this.msgReadlistService.save(msgRead);
            }
        }
        return RestResponse.success();
    }

    @GetMapping("edit")
    public String edit(Model model,Long id,Integer da){
        SysQuestion question=this.sysQuestionService.selectSysQuestionById(id);
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","sys_qus_status");
        List<Dict> questionStatus=this.dictService.list(wrapper);

        wrapper=new QueryWrapper();
        wrapper.eq("type","sys_qus_flag");
        List<Dict> questionFlag=this.dictService.list(wrapper);

        int ids = question.getQusDesignator().split(",").length;
        List li = new ArrayList();
        for(int i = 0; i < ids; i++){
            wrapper=new QueryWrapper();
            wrapper.eq("id",question.getQusDesignator().split(",")[i]);
            List<User> users = this.userService.list(wrapper);
            for(User u : users){
                li.add(u.getNickName());
            }
        }
        model.addAttribute("nickNames",li.toString().substring(1,li.toString().lastIndexOf("]")));
        model.addAttribute("questionStatus",questionStatus);
        model.addAttribute("questionFlag",questionFlag);
        model.addAttribute("question",question);
        model.addAttribute("da",da);
        return "sys/question/detail";
    }
    @PostMapping("edit")
    @ResponseBody
    public RestResponse edit(@RequestBody SysQuestion question, Model model ,HttpServletRequest request,Integer da){
        Msg msg = new Msg();
        User  user = (User)request.getAttribute("currentUser");
        if(da==1){
            if(question.getQusStatus().equals("0")){
                question.setQusStatus("1");
            }
            question.setQusRequester(user.getLoginName());
            question.setQusRequestdate(new Date());
            msg.setLevel("2");
            msg.setTitle("通知消息【"+question.getQusTitle()+"】[已回答]");
            msg.setShowFrom(new Date());
            msg.setShowTo(new Date());
            msg.setPushType("2");
            msg.setRemarks(question.getRemarks());
            msg.setDetail("回答内容：\n\r"+question.getQusRequestdetail());
            msg.setPushDate(new Date());
            this.msgService.save(msg);

            MsgReadlist msgRead=new MsgReadlist();
            msgRead.setMsgId(msg.getId());
            QueryWrapper wrapper = new QueryWrapper();
            wrapper.eq("login_name",question.getQusPusher());

            msgRead.setUserId(this.userService.getOne(wrapper).getId());

            this.msgReadlistService.save(msgRead);
        }
        this.sysQuestionService.updateById(question);
        return RestResponse.success();
    }
    @PostMapping("uploadAttachment")
    @ResponseBody
    public List<Resource> uploadAttachment(@RequestParam(value = "file") MultipartFile[] files){
        String url="/attach/directory/msgFile";
        List<Resource> resources=new ArrayList<>();
        for (int i=0;i<files.length;i++) {
            //获取随机文件名（另存的文件名）
            String uuid = FileUtils.createFileName();
            //原文件名
            String name=files[i].getOriginalFilename();

            Resource r=new Resource();
            r.setName(name.substring(0,name.lastIndexOf(".")));
            r.setUrl(url+"/"+uuid+name.substring(name.lastIndexOf(".")));
            r.setFileSize(setSize(files[i].getSize()));
            r.setFileType(name.substring(name.lastIndexOf(".")));

            FileUtils.saveFileToDisk(files[i],r.getUrl().substring(1,r.getUrl().length()));
            resourceService.insertResource(r);
            resources.add(r);
        }
        return resources;
    }


    @PostMapping("deleteAttachment")
    @ResponseBody
    public RestResponse deleteAttachment(@RequestBody List<Resource> resources ){
        for (Resource r:resources){
            this.resourceService.removeById(r.getId());
            try {
                FileUtils.deleteFile(new File("").getCanonicalPath()+r.getUrl());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return RestResponse.success();
    }
    private String setSize(Long size) {
        //获取到的size为：1705230
        int GB = 1024 * 1024 * 1024;//定义GB的计算常量
        int MB = 1024 * 1024;//定义MB的计算常量
        int KB = 1024;//定义KB的计算常量
        DecimalFormat df = new DecimalFormat("0.00");//格式化小数
        String resultSize = "";
        if (size / GB >= 1) {
            //如果当前Byte的值大于等于1GB
            resultSize = df.format(size / (float) GB) + "GB   ";
        } else if (size / MB >= 1) {
            //如果当前Byte的值大于等于1MB
            resultSize = df.format(size / (float) MB) + "MB   ";
        } else if (size / KB >= 1) {
            //如果当前Byte的值大于等于1KB
            resultSize = df.format(size / (float) KB) + "KB   ";
        } else {
            resultSize = size + "B   ";
        }
        return resultSize;
    }
    //删除问题信息
    @ResponseBody
    @PostMapping("deleteQus/{id}")
    public RestResponse deleteQus(@PathVariable("id") Long id){
        SysQuestion qus=this.sysQuestionService.selectSysQuestionById(id);
        qus.setDelFlag(true);
        if(!this.sysQuestionService.updateById(qus)){
            return RestResponse.failure("删除问题失败");
        }
        return RestResponse.success();
    }

    @ResponseBody
    @PostMapping("deleteQusSome")
    public RestResponse deleteQusSome(@RequestBody List<SysQuestion> quses){
        for (SysQuestion q:quses){
            q.setDelFlag(true);
            if(!this.sysQuestionService.updateById(q)){
                return RestResponse.failure("删除问题失败");
            }
        }
        return RestResponse.success();
    }
}
