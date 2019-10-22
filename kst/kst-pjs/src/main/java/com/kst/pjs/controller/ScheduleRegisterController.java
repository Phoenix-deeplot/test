package com.kst.pjs.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.incrementer.IKeyGenerator;
import com.kst.common.base.vo.DataTable;
import com.kst.common.shiro.MySysUser;
import com.kst.common.utils.RestResponse;
import com.kst.common.utils.StringUtils;
import com.kst.log.annotation.SysLog;
import com.kst.pjs.entity.*;
import com.kst.pjs.service.*;
import com.kst.sys.api.entity.Daily;
import com.kst.sys.api.entity.Msg;
import com.kst.sys.api.entity.MsgReadlist;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 项目计划注册信息（schDetail 的注册功能代码都在这）
 */
@Controller
@RequestMapping("pjs/scheduleRegister")
public class ScheduleRegisterController {

    @Autowired
    private IDictService dictService;

    @Autowired
    private ISchDetailService schDetailService;

    @Autowired
    private ISchHistoryService schHistoryService;

    @Autowired
    private IProjectGroupService projectGroupService;

    @Autowired
    private IPjMainService pjMainService;

    @Autowired
    private IDailyService dailyService;

    @Autowired
    private IProjectHistoryService projectHistoryService;

    @Autowired
    private IUserService userService;

    @GetMapping("list")
    public String list(Model model) {
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("type","pjs_pj_status");
        wrapper.eq("del_flag",false);
        model.addAttribute("status",this.dictService.list(wrapper));
        return "scheduleRegister/list";
    }

    //进入进度登记页面
    @GetMapping("toRegister/{id}")
    public String toRegister(@PathVariable("id") String id, Model model) {
        model.addAttribute("pjId", id);
        model.addAttribute("mode", 1);
        return "scheduleRegister/detail";
    }

    @GetMapping("self")
    public String toRegisterSelf(Model model) {
        model.addAttribute("mode", 2);
        return "scheduleRegister/detail";
    }

    @PostMapping("scheduleResgiter")
    @ResponseBody
    public RestResponse scheduleRegister(@RequestBody List<SchHistory> schHistorys) {

        for (SchHistory schHistory:schHistorys){

            System.out.println(schHistory.getWorkInteriorNo());

            QueryWrapper wrapper = new QueryWrapper();
            wrapper.eq("interior_no", schHistory.getWorkInteriorNo());
            SchDetail schDetail = this.schDetailService.getOne(wrapper);

            if (schDetail.getWorkFactFrom() == null) {
                schDetail.setWorkFactFrom(new Date());
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            wrapper=new QueryWrapper();
            wrapper.eq("work_interior_no", schHistory.getWorkInteriorNo());
            wrapper.eq("work_plan_from",sdf.format(new Date()));
            SchHistory sh=this.schHistoryService.getOne(wrapper);
            schHistory.setPjId(schDetail.getPjId());
            schHistory.setWorkPlanFrom(new Date());
            if(sh!=null){
                schDetail.setWorkFactTimes(schDetail.getWorkFactTimes()-sh.getWorkFactTimes()+schHistory.getWorkFactTimes());
                schHistory.setId(sh.getId());
                this.schHistoryService.updateById(schHistory);
            }else{
                schDetail.setWorkFactTimes(schDetail.getWorkFactTimes() + schHistory.getWorkFactTimes());
                if (!this.schHistoryService.save(schHistory)) {
                    return RestResponse.failure("进度登记失败");
                }
            }

            schDetail.setWorkFactUser(schHistory.getWorkFactUser());//修改schdetail实际担当者
            schDetail.setWorkFinishPer(schHistory.getWorkFinishPer());
            schHistory.setPjId(schDetail.getPjId());
            schHistory.setWorkPlanFrom(new Date());

            if (schDetail.getWorkFinishPer() > 95 && schDetail.getWorkFactTo() == null) {
                schDetail.getWorkFinishPer();
                schDetail.setWorkFactTo(new Date());
            }

            this.schDetailService.updateById(schDetail);
        }
        return RestResponse.success();
    }

    //定时日报，于每日零点五分添加前一天的计划完成情况
    @PostMapping("register")
    @Scheduled(cron = "0 5 0 * * ?")
    @ResponseBody
    public RestResponse scheduleDaily() {
        Calendar c=Calendar.getInstance();
        c.add(Calendar.DAY_OF_YEAR,-1);
        c.set(java.util.Calendar.HOUR_OF_DAY, 0);
        c.set(java.util.Calendar.MINUTE, 0);
        c.set(java.util.Calendar.SECOND, 0);
        c.set(java.util.Calendar.HOUR_OF_DAY, 0);
        c.set(java.util.Calendar.MINUTE, 0);
        c.set(java.util.Calendar.SECOND, 0);
        Date date=c.getTime();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("del_flag", false);
        List<Long> list = this.projectGroupService.selectDistinct();

        String userIds=StringUtils.join(list,",");
        //生成项目主信息的日报
        projectHistory(date);

        //查询已完成的schDetail
        wrapper=new QueryWrapper();
        wrapper.isNotNull("work_fact_to");
        wrapper.gt("work_finish_per",95);
        wrapper.eq("plan_and_fact_rate",0);
        List<SchDetail> schs=this.schDetailService.list(wrapper);
        for (SchDetail schDetail:schs){
            //计算完成时间和预定时间的差值与比例
            int multiple = 1000 * 60 * 60 * 24;
            double factDay = (schDetail.getWorkFactTo().getTime() - schDetail.getWorkFactFrom().getTime()) / multiple + 1;
            double planDay = (schDetail.getWorkPlanTo().getTime() - schDetail.getWorkPlanFrom().getTime()) / multiple + 1;
            schDetail.setPlanAndFactDiff(factDay - planDay);
            schDetail.setPlanAndFactRate(factDay / planDay);
            this.schDetailService.updateById(schDetail);
        }

        //循环用户
        for (Long id : list) {
            //循环项目对象
            Map<String, Object> params = new HashMap<>();
            params.put("userId", id);
            List<PjMain> pjMains = this.pjMainService.selectPjMainByMap(params);

            wrapper=new QueryWrapper();
            wrapper.eq("id",id);
            User user=this.userService.getOne(wrapper);

            for (PjMain pjMain : pjMains) {
                String main = "";
                String text1 = "\r\n" + "    ①实绩作业(有进度)：";
                String text2 = "\r\n" + "    ②实绩作业(无进度)：";
                String planDo = "\r\n" + "    ③预定已开始(无进度)";
                String other="\r\n" + "    ④其他工作";

                wrapper = new QueryWrapper();
                wrapper.eq("work_fact_user", user.getLoginName());
                wrapper.eq("pj_id", pjMain.getId());
                wrapper.eq("work_type", 1);
                wrapper.lt("work_finish_per", 100);
                List<SchDetail> schDetails = this.schDetailService.list(wrapper);
                //循环项目计划
                int size=0;
                double todayTimes=0;
                for (SchDetail schDetail : schDetails) {
                    wrapper = new QueryWrapper();
                    //根据 pjs_sch_history 的信息来判断本计划在昨天是否有进度
                    wrapper.eq("work_interior_no", schDetail.getInteriorNo());
                    wrapper.orderByDesc("create_date");
                    List<SchHistory> schHistories = this.schHistoryService.list(wrapper);
                    System.out.println("查询历史信息"+schDetail.getId());

                    wrapper.eq("work_plan_from", sdf.format(date));
                    List<SchHistory> schHistories1 = this.schHistoryService.list(wrapper);
                    System.out.println("查询今日信息"+schDetail.getId());
                    if (schHistories1.size() > 0) {
                        //今日有进度
                        todayTimes+=schHistories1.get(0).getWorkFactTimes();
                        text1 += "\r\n" + "        ." + schDetail.getWorkName() + "  完成度：" + schDetail.getWorkFinishPer() + "%  工时："+schHistories1.get(0).getWorkFactTimes()+"小时";
                        size+=1;
                    } else {
                        //今日无进度
                        if (schHistories.size() > 0) {
                            text2 += "\r\n" + "        ." + schDetail.getWorkName() + " 完成度：" + schDetail.getWorkFinishPer() + "%";
                            size+=1;
                        }
                    }
                }

                if(schDetails.size()>0){
                    if (main.equals(""))
                        main = pjMain.getName() +"(" + todayTimes + "时)";
                }

                //查询 计划开始日已经到了，但是还未有进度的对象信息
                wrapper = new QueryWrapper();
                wrapper.eq("work_type", 1);
                wrapper.eq("work_plan_user", user.getLoginName());
                wrapper.eq("pj_id", pjMain.getId());
                wrapper.lt("work_plan_from", date);
                wrapper.isNull("work_fact_from");
                schDetails = this.schDetailService.list(wrapper);

                for (SchDetail schDetail : schDetails) {
                    if (main.equals(""))
                        main = pjMain.getName() +"(" + todayTimes + "时)";
                    planDo += "\r\n" + "        ." + schDetail.getWorkName() + " 预定开始时间：" + sdf.format(schDetail.getWorkPlanFrom());
                    size+=1;
                }

                //查询work_type=2的项目计划
                params=new HashMap<>();
                params.put("userId",id);
                params.put("pjId",pjMain.getId());
                params.put("work_type",2);
                schDetails=this.schDetailService.selectSchDetailByMap(params);

                for (SchDetail schDetail : schDetails) {
                    if (main.equals(""))
                        main = pjMain.getName() +"(" + todayTimes + "时)";
                    other+="\r\n" + "        ." + schDetail.getWorkName();
                    size+=1;
                }

                //添加日报信息

                Map<String,Object> map=new HashMap<>();

                String uuid=getOrderNo();
                System.out.println(" UUId:"+uuid);
                map.put("id",uuid);
                map.put("userId",id);
                map.put("date",date);
                map.put("workTimes",todayTimes);
                map.put("projectId",pjMain.getId());
                map.put("type","项目管理");
                map.put("userIds",userIds);
                map.put("delFlag",false);
                map.put("createBy",user.getLoginName());
                map.put("updateBy",user.getLoginName());

                if(size>0){
                    if(text1.equals("\r\n" + "    ①实绩作业(有进度)："))
                        text1+="\r\n"+"        .无";
                    if(text2.equals("\r\n" + "    ②实绩作业(无进度)："))
                        text2+="\r\n"+"        .无";
                    if (planDo.equals("\r\n" + "    ③预定已开始(无进度)"))
                        planDo+="\r\n"+"        .无";
                    if(other.equals("\r\n" + "    ④其他工作"))
                        other+="\r\n"+ "        .无";
                    //daily.setContent(main + text1 + text2 + planDo +other);
                    map.put("content",main + text1 + text2 + planDo +other);
                    this.dailyService.insertDaily(map);
                }
            }
        }
        return RestResponse.success();
    }

    public static  String getOrderNo(){
        String numStr = new Date().getTime()+""+(int)((Math.random()*9+1)*100000);
        return numStr ;
    }

    //统计项目履历
    public void projectHistory(Date date){
        int multiple = 1000 * 60 * 60 * 24;
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("del_flag",false);
        List<PjMain> mains=this.pjMainService.list(wrapper);
        List<ProjectHistory> phs=new ArrayList<>();

        for (PjMain main:mains){
            Map<String,Object> ph=new HashMap<>();
            ph.put("id",getOrderNo());
            ph.put("date",date);
            ph.put("pjId",main.getId());

            wrapper=new QueryWrapper();
            wrapper.eq("pj_id",main.getId());
            wrapper.lt("work_plan_from",date);

            List<SchDetail> schDetails=this.schDetailService.list(wrapper);

            double projectSumDays=0.0;
            for (SchDetail schDetail:schDetails){
                projectSumDays+=getDistanceTime(schDetail.getWorkPlanTo(),schDetail.getWorkPlanFrom());
            }

            double planFinishRateSum=0.0;
            double planFinishDaySum=0.0;
            double factFinishRateSum=0.0;
            double factFinishDaySum=0.0;
            double dayDeviationValue=0.0;
            for (SchDetail schDetail:schDetails){
                double sumDays=getDistanceTime(schDetail.getWorkPlanTo(),schDetail.getWorkPlanFrom());
                double planFinishDay=0;
                //预定完成的天数
                if (schDetail.getWorkPlanFrom().getTime()<=date.getTime() && date.getTime()<=schDetail.getWorkPlanTo().getTime()){
                    planFinishDay =getDistanceTime(date,schDetail.getWorkPlanFrom());
                }else if(schDetail.getWorkPlanFrom().getTime()>date.getTime()){
                    planFinishDay=0;
                }else if(schDetail.getWorkPlanTo().getTime()<date.getTime()){
                    planFinishDay=sumDays;
                }

                double planFinishRate=planFinishDay/sumDays*100;//预定完成的比例
                double factFinishRate=schDetail.getWorkFinishPer();//实际完成的比例
                double factFinishDay=(factFinishRate/planFinishRate)*planFinishDay;//实际完成的天数

                //System.out.println(schDetail.getWorkName()+"数据: 预定比例"+planFinishRate+"  实际比例"+factFinishRate+"  预定天数"+planFinishDay+"  实际天数"+factFinishDay+" 总天数"+sumDays);
                planFinishRateSum=planFinishRateSum+planFinishRate*sumDays/projectSumDays;
                planFinishDaySum=planFinishDaySum+planFinishDay;
                factFinishRateSum=factFinishRateSum+factFinishRate*sumDays/projectSumDays;
                factFinishDaySum=factFinishDaySum+factFinishDay;
                dayDeviationValue=dayDeviationValue+planFinishDay-factFinishDay;
            }
            ph.put("planFinishDay",planFinishDaySum);
            ph.put("planFinishRate",planFinishRateSum);
            ph.put("factFinishDay",factFinishDaySum);
            ph.put("factFinishRate",factFinishRateSum);
            ph.put("dayDeviationValue",dayDeviationValue);

            projectHistoryService.insertProjectHistory(ph);
        }

        for (ProjectHistory pjs:phs){
            System.out.println(JSON.toJSONString(pjs));
        }
    }

    //计算两天相差日数(同一天开始结束算一天)
    public static double getDistanceTime(Date startTime, Date endTime) {
        int days = 0;
        long time1 = startTime.getTime();
        long time2 = endTime.getTime();

        long diff;
        if (time1 < time2) {
            diff = time2 - time1;
        } else {
            diff = time1 - time2;
        }
        return (diff / (24 * 60 * 60 * 1000))+1;
    }


}
