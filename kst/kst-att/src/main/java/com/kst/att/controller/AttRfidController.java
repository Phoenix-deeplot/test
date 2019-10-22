package com.kst.att.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.att.entity.AttRfid;
import com.kst.att.service.IAttRfidService;
import com.kst.att.vo.RfidVO;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.sys.api.entity.Rfid;
import com.kst.sys.api.service.IRfidService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("att/rfid")
public class AttRfidController {

    @Autowired
    private IAttRfidService attRfidService;

    @Autowired
    private IRfidService rfidService;

    @GetMapping("list")
    public String list(){
        return "attRfid/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<RfidVO> list(@RequestBody DataTable dt){
        this.attRfidService.selectAttRfidByPage(dt);
        for (Object rfidVO:dt.getRows()){
            RfidVO vo=(RfidVO) rfidVO;
        }
        return dt;
    }

    //查询供选择的rfid数据
    @PostMapping("rfidList")
    @ResponseBody
    public DataTable<Rfid> rfidList(@RequestBody DataTable<Rfid> dt){
        List<Long> ids=new ArrayList<>();
        //已经选择的设备不出现在列表中
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("del_flag",false);
        List<AttRfid> list=this.attRfidService.list(wrapper);
        for (AttRfid attRfid:list){
            ids.add(attRfid.getRfidId());
        }
        if(ids.size()>0){
            dt.getSearchParams().put("search_not_in_id",ids);
        }
        this.rfidService.pageSearch(dt);
        return dt;
    }

    @GetMapping("add")
    public String add(){
        return "attRfid/detail";
    }

    @PostMapping("add")
    @ResponseBody
    public RestResponse add(@RequestBody List<Long> ids){

        for (Long id:ids){
            AttRfid attRfid=new AttRfid();
            attRfid.setRfidId(id);
            attRfid.setDelFlag(false);
            if(!this.attRfidService.save(attRfid)){
                return RestResponse.failure("fail");
            }
        }
        return RestResponse.success();
    }

    @PostMapping("delete")
    @ResponseBody
    public RestResponse delete(Long id){
        if(!this.attRfidService.removeById(id)){
            return RestResponse.failure("fail");
        }
        return RestResponse.success();
    }

    @PostMapping("deleteSome")
    @ResponseBody
    public RestResponse deleteSome(@RequestBody List<AttRfid> rfids){
        System.out.println("批量删除");
        for (AttRfid rfid:rfids){
            if(!this.attRfidService.removeById(rfid.getId())){
                return RestResponse.failure("fail");
            }
        }
        return RestResponse.success();
    }


}
