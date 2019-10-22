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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("sys/msg")
public class MsgController {

    @Autowired
    private IMsgService msgService;

    @Autowired
    private IDictService dictService;

    @Autowired
    private IResourceService resourceService;

    @Autowired
    private IMsgReadlistService msgReadlistService;

    @Autowired
    private IDailyService dailyService;

    @GetMapping("list")
    public String list(Model model){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","sys_msg_type");
        wrapper.eq("del_flag",false);
        model.addAttribute("msgTypes",this.dictService.list(wrapper));
        return "sys/msg/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<Msg> list(@RequestBody DataTable dt,HttpServletRequest request){
         dt=this.msgService.selectMsgByPage(dt);
        List<Msg> list=dt.getRows();
        if(!dt.getSearchParams().containsKey("requestType")){
            for (Msg msg:list){
                if(msg.getLevel().equals("2")){
                    QueryWrapper wrapper=new QueryWrapper();
                    wrapper.eq("msg_id",msg.getId());
                    wrapper.eq("user_id", MySysUser.id());
                    MsgReadlist r=this.msgReadlistService.getOne(wrapper);
                    r.setMsgReadDate(new Date());
                    this.msgReadlistService.updateById(r);
                }
            }
        }
        return dt;
    }

    @GetMapping("add")
    public String add(Model model){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","sys_msg_type");
        wrapper.eq("del_flag",false);
        List<Dict> msgTypes=this.dictService.list(wrapper);

        wrapper=new QueryWrapper();
        wrapper.eq("type","sys_push_type");
        wrapper.eq("del_flag",false);
        List<Dict> pushTypes=this.dictService.list(wrapper);

        model.addAttribute("msgTypes",msgTypes);
        model.addAttribute("pushTypes",pushTypes);
        return "sys/msg/detail";
    }

    @PostMapping("add")
    @ResponseBody
    public RestResponse add(@RequestBody Msg msg){
        List<UserVO> list=msg.getUserLists();
        this.msgService.save(msg);
        for (UserVO u:list){
            MsgReadlist msgRead=new MsgReadlist();
            msgRead.setMsgId(msg.getId());
            msgRead.setUserId(u.getId());
            this.msgReadlistService.save(msgRead);
        }
        return RestResponse.success();
    }

    @GetMapping("edit")
    public String edit(Model model,Long id){
        Msg msg=this.msgService.selectMsgById(id);
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","sys_msg_type");
        wrapper.eq("del_flag",false);
        List<Dict> msgTypes=this.dictService.list(wrapper);

        wrapper=new QueryWrapper();
        wrapper.eq("type","sys_push_type");
        wrapper.eq("del_flag",false);
        List<Dict> pushTypes=this.dictService.list(wrapper);

        model.addAttribute("msgTypes",msgTypes);
        model.addAttribute("pushTypes",pushTypes);
        model.addAttribute("msg",msg);
        return "sys/msg/detail";
    }

    @PostMapping("edit")
    @ResponseBody
    public RestResponse edit(@RequestBody Msg msg){
        List<UserVO> list=msg.getUserLists();
        List<UserVO> oldUsers=this.msgService.selectMsgById(msg.getId()).getUserLists();
        QueryWrapper wrapper=new QueryWrapper();
        this.msgService.updateById(msg);
        oldUsers.removeAll(list);

        //删除
        for (UserVO u:oldUsers){
            wrapper=new QueryWrapper();
            wrapper.eq("msg_id",msg.getId());
            wrapper.eq("user_id",u.getId());
            this.msgReadlistService.removeById (this.msgReadlistService.getOne(wrapper).getId());
        }
        //添加修改
        for (UserVO u:list){
            wrapper=new QueryWrapper();
            wrapper.eq("msg_id",msg.getId());
            wrapper.eq("user_id",u.getId());
            MsgReadlist mrl=this.msgReadlistService.getOne(wrapper);
            if(mrl==null){
                MsgReadlist msgRead=new MsgReadlist();
                msgRead.setMsgId(msg.getId());
                msgRead.setUserId(u.getId());
                this.msgReadlistService.save(msgRead);
            }
        }
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

    @ResponseBody
    @PostMapping("deleteMsgSome")
    public RestResponse deleteMsgSome(@RequestBody List<Msg> msgs){
        for (Msg m:msgs){
            m.setDelFlag(true);
            if(!this.msgService.updateById(m)){
                return RestResponse.failure("fail");
            }
        }
        return RestResponse.success();
    }

    //删除信息
    @ResponseBody
    @PostMapping("deleteMsg/{id}")
    public RestResponse deleteMsg(@PathVariable("id") Long id){
        Msg msg=this.msgService.selectMsgById(id);
        msg.setDelFlag(true);
        if(!this.msgService.updateById(msg)){
            return RestResponse.failure("fail");
        }
        return RestResponse.success();
    }

    @GetMapping("selectMsgDetail/{id}")
    @SysLog("查看消息详细")
    public String selectMsgDetail(Model model, @PathVariable("id") Long id, HttpServletRequest request){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("msg_id",id);
        wrapper.eq("user_id",MySysUser.id());
        MsgReadlist r=this.msgReadlistService.getOne(wrapper);
        r.setMsgReadDate(new Date());
        this.msgReadlistService.updateById(r);
        Msg msg=this.msgService.selectMsgById(id);
//        if(msg.getAttachlist()!=null && msg.getAttachlist()!=""){
//            QueryWrapper wrapper1=new QueryWrapper();
//            wrapper1.in("id",msg.getAttachlist().split(","));
//            List<Resource> resources=this.resourceService.list();
//            model.addAttribute("attachlist",resources);
//        }

        model.addAttribute("msg",msg);
        return "sys/msg/msgDetail";
    }

    @PostMapping("getAttachList")
    @ResponseBody
    public DataTable getAttachList(@RequestBody DataTable dt){
        return this.resourceService.pageSearch(dt);
    }

    public static  String getOrderNo(){
        String numStr = new Date().getTime()+""+(int)((Math.random()*9+1)*100000);
        return numStr ;
    }

    //每天 凌晨两点统计sys_daily的信息并生成日报，发送到每个相关用户
    @PostMapping("dailyMessage")
    @ResponseBody
    @Scheduled(cron = "0 0 2 * * ?")
    public RestResponse dailyMessage(){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        Calendar c=Calendar.getInstance();


        c.set(java.util.Calendar.HOUR_OF_DAY, 0);
        c.set(java.util.Calendar.MINUTE, 0);
        c.set(java.util.Calendar.SECOND, 0);
        c.set(java.util.Calendar.HOUR_OF_DAY, 0);
        c.set(java.util.Calendar.MINUTE, 0);
        c.set(java.util.Calendar.SECOND, 0);
        //日报开始推送日期
        Date showFrom=c.getTime();
        c.add(Calendar.DAY_OF_YEAR,-1);
        //日报日期
        Date date=c.getTime();
        c.add(Calendar.DAY_OF_YEAR,+7);
        //日报结束推送日期
        Date showTo=c.getTime();

        QueryWrapper wrapper=new QueryWrapper();
        String[] userIds=((Daily)this.dailyService.list(wrapper).get(0)).getUserIds().split(",");
        System.out.println("用户id集合"+userIds.toString());
        for (String userId:userIds){
            Map<String,Object> params=new HashMap<>();
            params.put("date",sdf.format(date));
            params.put("type","项目管理");
            params.put("userId",userId);
            List<Daily> dailies=this.dailyService.selectDailyByMap(params);
            if(dailies.size()>0){
                String id=getOrderNo();
                //当日有生成日报，则创建消息
                Map<String,Object> msg=new HashMap<>();
                msg.put("id",id);
                msg.put("title","日报 "+sdf.format(date)+" "+dailies.get(0).getUserName());
                msg.put("showFrom",showFrom);
                msg.put("showTo",showTo);
                msg.put("pushDate",date);
                msg.put("level","2");
                msg.put("pushType","1");
                String detail="";
                for (int i=0;i<dailies.size();i++){
                    detail+=dailies.get(i).getContent();
                    if(i!=dailies.size()-1){
                        detail+="\r\n";
                    }
                }
                msg.put("createBy",dailies.get(0).getCreateBy());
                msg.put("updateBy",dailies.get(0).getUpdateBy());
                msg.put("detail",detail);

                this.msgService.insertMsg(msg);

                for (String uid:userIds){
                    Map<String,Object> mrl=new HashMap<>();
                    mrl.put("id",Long.valueOf(getOrderNo()));
                    mrl.put("msgId",Long.valueOf(id));
                    mrl.put("userId",Long.parseLong(uid));
                    this.msgReadlistService.insertMsgReadlist(mrl);
                }
            }
        }
        return RestResponse.success();
    }


}
