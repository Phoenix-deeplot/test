package com.kst.att.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.att.vo.SignVO;
import com.kst.sys.api.entity.ModulePara;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IModuleParaService;
import com.kst.att.service.ISignService;
import com.kst.att.utils.ExcelUtil;
import com.kst.common.base.controller.BaseController;
import com.kst.common.utils.RestResponse;
import com.kst.sys.api.entity.Calandar;
import com.kst.sys.api.service.ICalandarService;
import com.kst.sys.api.service.IUserService;
import com.kst.sys.api.vo.UserVO;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

@Controller
@RequestMapping("att/modulePara")
public class ModuleParaController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AttendanceController.class);
    @Autowired
    private IModuleParaService iModuleParaService;
    @Autowired
    private ISignService iSignService;
    @Autowired
    ICalandarService calandarService;
    @Autowired
    private IUserService userService;
    @RequiresPermissions("att:modulePara:turn")
    @GetMapping("turn")
    public String list(Model model){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("para_id","gateCard");
        List<ModulePara> module= this.iModuleParaService.list(wrapper);
        String beginDay = module.get(0).getParaJson();
        if(!beginDay.equals("")){
            String startDay = beginDay.substring((beginDay.indexOf(":")+2),(beginDay.indexOf(",")-1));
            model.addAttribute("startDay",startDay);
        }
        return "attendance/turn";
    }

    @PostMapping("add")
    @ResponseBody
    public RestResponse add(@RequestBody ModulePara modulePara){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("para_id","gateCard");
        List<ModulePara> module= this.iModuleParaService.list(wrapper);
        if(module.size()==0){
            modulePara.setParaId("gateCard");
            modulePara.setUserId("0");
            this.iModuleParaService.save(modulePara);
        }else{
            this.iModuleParaService.update(modulePara,wrapper);
        }
        return RestResponse.success();
    }




    @PostMapping("turnList")
    @ResponseBody
    public int turnList(Long userId, String onsetDate){
        QueryWrapper wrapper2 = new QueryWrapper();
        wrapper2.eq("id", userId);
        List<User> user = this.userService.list(wrapper2);
        List<SignVO> info =  iSignService.findAttUserid(user.get(0).getLoginName());
        Integer total = this.iSignService.totalTime();
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("para_id", "gateCard");
        List<ModulePara> module = this.iModuleParaService.list(wrapper);
        String beginDay = module.get(0).getParaJson();
        if(!beginDay.equals("")){
            String day = beginDay.substring((beginDay.indexOf(":") + 2), (beginDay.indexOf(",") - 1));
            Date date = null;
            try {
                date = new SimpleDateFormat("yyyy-MM-dd").parse(onsetDate + "-" + day);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            ExcelUtil excel = new ExcelUtil();
            if (info.size() != 0) {
                List<Calandar> calandars = this.calandarService.list();
                try {
                    excel.zxExprotExcelXLSX(total,user.get(0).getLoginName(),calandars,date, user.get(0).getNickName(),info);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return 1;
            }
        }
        return 0;
    }


    @GetMapping("gateCard")
    public String gateCard(Model model, Long userId, String onsetDate){
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("para_id", "gateCard");
        List<ModulePara> module = this.iModuleParaService.list(wrapper);
        String beginDay = module.get(0).getParaJson();
        String day="";
        if(!beginDay.equals("")){
            day = beginDay.substring((beginDay.indexOf(":") + 2), (beginDay.indexOf(",") - 1));
        }
        QueryWrapper wrapper2 = new QueryWrapper();
        wrapper2.eq("id", userId);
        List<User> user = this.userService.list(wrapper2);

        model.addAttribute("attUserid",user.get(0).getLoginName());
        model.addAttribute("nickName",user.get(0).getNickName());
        System.out.println("日期显示"+onsetDate);
        model.addAttribute("onsetDate",onsetDate);
        model.addAttribute("day",day);
        model.addAttribute("id",userId);
        return "attendance/gateCard";
    }

    @PostMapping("gateCardlist")
    @ResponseBody
    public List gateCardlist(String userId, String onsetDate){
        QueryWrapper wrapper2 = new QueryWrapper();
        wrapper2.eq("id", userId.substring(1,userId.lastIndexOf("'")));
        List<User> user = this.userService.list(wrapper2);
        List<SignVO> info = iSignService.findAttUserid(user.get(0).getLoginName());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("para_id", "gateCard");
        List<ModulePara> module = this.iModuleParaService.list(wrapper);
        String beginDay = module.get(0).getParaJson();
        if(!beginDay.equals("")){
            String day = beginDay.substring((beginDay.indexOf(":") + 2), (beginDay.indexOf(",") - 1));

            Date date = null;
            try {
                date = sdf.parse(onsetDate.substring(1,onsetDate.lastIndexOf("'")) + "-" + day);

            String str = sdf.format(date);
            Date d1 = sdf.parse(str);//定义起始日期
            Date d2 = sdf.parse(str.substring(0,4)+"-"+(Integer.parseInt(str.substring(5,7))+1)+"-"+(Integer.parseInt(str.substring(8,10))));//定义结束日期

            Calendar c1=Calendar.getInstance();
            c1.setTime(d1);
            Calendar c2=Calendar.getInstance();
            c2.setTime(d2);
            long t1=c1.getTimeInMillis();
            long t2=c2.getTimeInMillis();
            long days=(t2-t1)/(24*60*60*1000);
            Calendar dd = Calendar.getInstance();//定义日期实例
            dd.setTime(d1);//设置日期起始时间
            List<SignVO> li=new ArrayList<>();


            for(int i=0;i<days;i++){
                String strDate = sdf.format(dd.getTime());
                String nowDate = sdf.format(new Date());
                if(strDate.equals(nowDate)){
                    break;
                }
                dd.add(Calendar.DATE,1);//进行当前日期加1

                Date str2Date = sdf.parse(strDate);
                Instant instant = str2Date.toInstant();
                ZoneId zoneId = ZoneId.systemDefault();
                LocalDate localDate = instant.atZone(zoneId).toLocalDate();
                DayOfWeek dayWeek = localDate.getDayOfWeek();
                String WeekDay = "";
                switch (dayWeek) {
                    case MONDAY:
                        WeekDay = "一";
                        break;
                    case FRIDAY:
                        WeekDay = "五";
                        break;
                    case SATURDAY:
                        WeekDay = "六";
                        break;
                    case SUNDAY:
                        WeekDay = "日";
                        break;
                    case THURSDAY:
                        WeekDay = "四";
                        break;
                    case TUESDAY:
                        WeekDay = "二";
                        break;
                    case WEDNESDAY:
                        WeekDay = "三";
                        break;
                }


                List<Calandar> calandars = this.calandarService.list();

                SignVO vo=new SignVO();
                vo.setAttSigntime(str2Date);
                vo.setWeekDay(WeekDay);
                for(Calandar c : calandars){
                    String calDate = sdf.format(c.getCalDate());
                    if(strDate.equals(calDate)){
                        vo.setDateExplain(c.getCalContent());
                    }
                }

                for(SignVO signVO : info){
                    String oldTime = sdf.format(signVO.getAttSigntime());
                    if(strDate.equals(oldTime)){
                        vo = signVO;
                        vo.setWeekDay(WeekDay);
                    }
                }
                li.add(vo);
            }
            return li;
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        return null;

    }
}
