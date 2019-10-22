package com.kst.log.controller;

import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.log.entity.Log;
import com.kst.log.service.ILogService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by zjf on 2018/1/13.
 * todo:
 */
@Controller
@RequestMapping("sys/log")
public class LogController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(LogController.class);

    @Autowired
    private ILogService logService;

    @GetMapping("list")
    public String list(){
        return "sys/log/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<Log> list(@RequestBody DataTable dt){
        /*Map map = WebUtils.getParametersStartingWith(request, "s_");
        LayerData<Log> layerData = new LayerData<>();
        EntityWrapper<Log> wrapper = new EntityWrapper<>();
        if(!map.isEmpty()){
            String keys = (String) map.get("type");
            if(StringUtils.isNotBlank(keys)) {
                wrapper.eq("type", keys);
            }
            String title = (String) map.get("title");
            if(StringUtils.isNotBlank(title)){
                wrapper.like("title",title);
            }
            String username = (String)map.get("username");
            if(StringUtils.isNotBlank(username)){
                wrapper.eq("username",username);
            }
            String httpMethod = (String)map.get("method");
            if(StringUtils.isNotBlank(httpMethod)){
                wrapper.eq("http_method",httpMethod);
            }
        }
        Page<Log> logPage = logService.selectPage(new Page<>(page,limit),wrapper);
        layerData.setCount((int)logPage.getTotal());
        layerData.setData(logPage.getRecords());
        return  layerData;*/
        return logService.pageSearch(dt);
    }

    @RequiresPermissions("system:logs:delete")
    @PostMapping("delete")
    @ResponseBody
    public RestResponse delete(@RequestParam("ids[]") List<Long> ids){
        if(ids == null || ids.size()==0){
            return RestResponse.failure("id不能为空");
        }
        logService.removeByIds(ids);
        return RestResponse.success();
    }

    @GetMapping("pvs")
    @ResponseBody
    public RestResponse getPV(){
        List<Integer> pvs = logService.selectSelfMonthData();
        return RestResponse.success().setData(pvs);
    }
}
