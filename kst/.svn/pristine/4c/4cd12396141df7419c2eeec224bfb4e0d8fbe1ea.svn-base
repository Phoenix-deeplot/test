package com.kst.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.common.utils.FileUtils;
import com.kst.common.utils.RestResponse;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.Directory;
import com.kst.sys.api.entity.Resource;
import com.kst.sys.api.service.IDictService;
import com.kst.sys.api.service.IDirectoryService;
import com.kst.sys.api.service.IResourceService;
import com.kst.sys.api.vo.DirectoryVO;
import com.kst.sys.api.vo.ResourceVO;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.aspectj.util.FileUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("sys/resource")
public class ResourceController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(ResourceController.class);

    @Autowired
    private IDirectoryService directoryService;

    @Autowired
    private IResourceService resourceService;

    @Autowired
    private IDictService dictService;

    @GetMapping("list")
    @RequiresPermissions("sys:resource:list")
    public String list(){return "sys/resource/list";}

    @PostMapping("list")

    @ResponseBody
    //加载初始树形菜单
    public List<ZtreeVO> tree(){
        List<ZtreeVO> list=directoryService.selectAll();
        return list;
    }

    @PostMapping("selectById")
    @ResponseBody
    public DirectoryVO selectById(Long id){
        return directoryService.selectDirectoryById(id);
    }

    @PostMapping("update")
    @ResponseBody
    @SysLog("用户修改目录")
    public RestResponse updateOrganization(@RequestBody Directory directory){
        //修改该directory
        int re=directoryService.updateDirectoryById(directory);

        if(re<=0){
            return RestResponse.failure("");
        }
        return  RestResponse.success();
    }

    @PostMapping("insert")
    @ResponseBody
    @SysLog("用户添加目录")
    public RestResponse insertDirectory(@RequestBody Directory directory){
        directoryService.insertDirectory(directory);
        if(directory.getId()==null || directory.getId() == 0){
            return RestResponse.failure("");
        }
        return  RestResponse.success();
    }

    @PostMapping("delete")
    @ResponseBody
    //删除目录
    public int deleteDirectory(String directory){
        Directory g=(Directory) JSONObject.toBean(JSONObject.fromObject(directory),Directory.class);
        return directoryService.deleteDirectory(g);
    }

    @PostMapping("checkDirectoryName")
    @ResponseBody
    //目录名称重复验证
    public RestResponse checkDirectoryName(Long sub, String name, Long id, Long parentId){
        boolean result=true;
        Directory directory=new Directory();
        directory.setParentId(parentId);
        directory.setName(name);
        directory.setId(id);

        Integer i=directoryService.selectNameIsExist(directory);
        if(i>0){
            //组织名已经存在
            result=false;
        }
        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    //添加窗口
    @GetMapping("add/{id}")
    public String add(@PathVariable("id") Long id, Model model){
        DirectoryVO vo=directoryService.selectDirectoryById(id);
        DirectoryVO g2=new DirectoryVO();
        g2.setParentName(vo.getName());
        g2.setLevel(vo.getLevel()+1);
        g2.setSort(null);
        g2.setParentId(vo.getId());
        model.addAttribute("directory",g2);

        return "sys/resource/detail";
    }

    //添加根目录窗口
    @GetMapping("addRoot")
    public String addRoot(Model model){
        DirectoryVO vo=new DirectoryVO();
        vo.setLevel(1);
        vo.setSort(null);
        model.addAttribute("directory",vo);
        return "sys/resource/detail";
    }

    //修改窗口
    @GetMapping("edit/{id}")
    public String edit(@PathVariable("id") Long id, Model model){
        DirectoryVO vo=directoryService.selectDirectoryById(id);
        model.addAttribute("directory",vo);
        return "sys/resource/detail";
    }

    @PostMapping("deleteOneResource")
    @ResponseBody
    @SysLog("用户删除单个资源")
    public RestResponse deleteOneResource(Long directoryId,Long resourceId){
        directoryService.deleteDirectoryResource(directoryId,resourceId);
        return RestResponse.success();
    }

    @PostMapping("deleteSomeResource")
    @ResponseBody
    @SysLog("用户批量删除资源")
    public RestResponse deleteSomeResource(@RequestBody List<Map<String,Long>> list){
        for (Map<String,Long> ou:list){
            directoryService.deleteDirectoryResource(ou.get("directoryId"),ou.get("resourceId"));
        }
        return RestResponse.success();
    }

    @PostMapping("loadResource")
    @ResponseBody
    //加载文件资源
    public DataTable<ResourceVO> loadResource(@RequestBody DataTable dt){
        DataTable<ResourceVO> resources=new DataTable<ResourceVO>();
        if(dt.getSearchParams().size()==0){
        }else{
            resources=resourceService.selectResourceByPage(dt);
        }
        return resources;
    }

    //上传资源窗口
    @GetMapping("uploadFile/{id}")
    public String uploadFile(@PathVariable("id") Long id, Model model){
        model.addAttribute("directoryId",id);
        return "sys/resource/fileUpload";
    }

    @PostMapping("uploadFile")
    @ResponseBody
    //上传文件
    public RestResponse uploadFile(@RequestParam(value = "file") MultipartFile[] files, Long directoryId){
        System.out.println("这个id:"+directoryId);
        String url=directoryService.selectDirectoryById(directoryId).getUrl();
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
            directoryService.insertDirectoryResource(directoryId,r.getId());
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

    //下载资源
    @GetMapping("outPutFile")
    @SysLog("下载资源")
    public void outPutFile(HttpServletResponse response, @RequestParam Long id){
        OutputStream output;
        Resource r=resourceService.getById(id);
        String url=r.getUrl();
        String name=url.substring(url.lastIndexOf("."));
        try {
            String path=new File("").getCanonicalPath()+url;
            System.out.println("地址："+path);
            FileUtils.downLoadFile(response,path,r.getName(),false);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @GetMapping("toFileType")
    public String toFileType(){
        return "sys/resource/fileType";
    }

    @PostMapping("updateFileType")
    @ResponseBody
    public Integer updateFileType(@RequestBody List<Resource> list){
        System.out.println("进入修改");
        for (Resource ou:list){
            this.resourceService.updateById(ou);
        }

        return list.size();
    }

    @GetMapping("editResource/{id}")
    public String editResource(Model model,@PathVariable("id") Long id){
        QueryWrapper<Dict> dictEntityWrapper = new QueryWrapper<>();
        dictEntityWrapper.eq("type","sys_resource_category");
        dictEntityWrapper.eq("del_flag",false);
        List<Dict> list=this.dictService.list(dictEntityWrapper);

        model.addAttribute("resource",this.resourceService.getById(id));
        model.addAttribute("resourceCategory",list);
        return "sys/resource/edit";
    }

    @PostMapping("editResource")
    @ResponseBody
    public RestResponse editResource(@RequestBody Resource resource){
        if(!this.resourceService.updateById(resource)){
            return RestResponse.failure("修改出错");
        }
        return RestResponse.success();
    }

}
