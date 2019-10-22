package com.kst.ams.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.Location;
import com.kst.ams.service.ILocationService;
import com.kst.ams.vo.LocationVO;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.common.utils.DocumentOutUtils;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping("ams/location")
public class LocationController extends BaseController {

    @Autowired
    private ILocationService locationService;

    @GetMapping("list")
    @SysLog("转跳场所页面")
    public String list(){
        return "location/list";
    }

    @PostMapping("getLocationName")
    public ZtreeVO getLocationName(@RequestParam(value = "id", required = false) String id){
        ZtreeVO ztree = new ZtreeVO();
        List<LocationVO>  list = locationService.getLocationName();
        for (LocationVO vo : list) {
            if(id.equals(vo.getId())) {
                ztree.setName(vo.getName());
            }
        }
        return ztree;
    }
    @PostMapping("list")
    @ResponseBody
    public List<ZtreeVO> getTree(){
        List<ZtreeVO> tree=this.locationService.selectAll();
        return tree;
    }


    @GetMapping("addRoot")
    public String addRoot(Model model){
        Location location=new Location();
        location.setLevel(1);
        location.setSort(null);
        model.addAttribute("location",location);
        return "location/detail";
    }

    @GetMapping("add/{id}")
    public String add(Model model,@PathVariable("id") Long id){
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        LocationVO location=this.locationService.selectLocationById(params).get(0);
        LocationVO location1=new LocationVO();
        location1.setParentName(location.getName());
        location1.setParentId(location.getId());
        location1.setParentIds(location.getParentIds());
        location1.setLevel(location.getLevel()+1);
        location1.setSort(null);
        model.addAttribute("location",location1);
        return "location/detail";
    }

    @GetMapping("edit/{id}")
    public String update(Model model,@PathVariable("id") Long id){
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        LocationVO locationVO=this.locationService.selectLocationById(params).get(0);
        model.addAttribute("location",locationVO);
        return "location/detail";
    }

    @PostMapping("insert")
    @ResponseBody
    @SysLog("添加场所")
    public RestResponse insert(@RequestBody Location location){
        this.locationService.insertLocation(location);
        return RestResponse.success();
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("修改场所")
    public RestResponse edit(@RequestBody Location location){
        System.out.println("修改");
        this.locationService.updateById(location);
        return RestResponse.success();
    }

    @PostMapping("delete")
    @ResponseBody
    public RestResponse delete(@RequestBody Location location){
        QueryWrapper<Location> wrapper=new QueryWrapper<>();
        if(location.getId()==null || location.getId()==0){
            return  RestResponse.failure("删除场所出错");
        }

        if (location.getLevel()==1){
            wrapper.likeRight("parent_ids",location.getId()+",");
        }else{
            wrapper.like("parent_ids",","+location.getId()+",");
        }
        Location location1=new Location();
        location1.setDelFlag(true);
        location1.setSort(null);

        this.locationService.update(location1,wrapper);
        return RestResponse.success();
    }

    @PostMapping("checkLocationName")
    @ResponseBody
    public RestResponse checkLocationName(Long sub,String name, Long id,Long parentId){
        boolean result=true;
        Location location=new Location();
        location.setParentId(parentId);
        location.setName(name);
        location.setId(id);

        System.out.print("parentId:"+parentId+"id:"+id);
        Integer i=locationService.selectNameIsExist(location);
        if(i>0){
            //组织名已经存在
            result=false;
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    @GetMapping("downloadLocationCSVFile")
    public void downloadLocationCSVFile(String ids, HttpServletResponse response){
        List<String> idList= Arrays.asList(ids.split(",")) ;
        Map<String,Object> params=new HashMap<>();
        params.put("ids",idList);
        List<LocationVO> list=this.locationService.selectLocationById(params);

        String[] head={"场所编号","场所名称","上级场所名称","备注"};
        List<Object> heads=Arrays.asList(head);
        List<List<Object>> dataList=new ArrayList<>();

        for (LocationVO v:list){
            List<Object> list1=new ArrayList<>();
            list1.add(v.getId());
            list1.add(v.getName());
            list1.add(v.getParentName());
            list1.add(v.getRemarks());
            dataList.add(list1);
        }
        DocumentOutUtils.createExcel(heads,dataList,response,"LocationData");

    }
}
