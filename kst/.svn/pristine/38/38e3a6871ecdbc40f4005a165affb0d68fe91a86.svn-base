package com.kst.isms.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.service.IDirectoryService;
import com.kst.sys.api.vo.ResourceVO;
import com.kst.sys.api.service.IDictService;
import com.kst.sys.api.service.IResourceService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

@Controller
@RequestMapping("isms/document")
public class DocumentController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(DocumentController.class);

    @Autowired
    IResourceService resourceService;

    @Autowired
    private IDirectoryService directoryService;

    @Autowired
    IDictService dictService;


    @GetMapping("list")
    @RequiresPermissions("isms:document:list")
    public String list(){return "document/list";}

    @PostMapping("tree")
    @ResponseBody
    //加载初始树形菜单
    public List<ZtreeVO> tree(){
        List<ZtreeVO> list=directoryService.selectAll();
        return list;
    }


    @PostMapping("list")
    @ResponseBody
    //加载文件资源
    public DataTable<ResourceVO> loadResource(@RequestBody DataTable dt){
        System.out.println("进入分页");
        DataTable<ResourceVO> resources=new DataTable<ResourceVO>();
        resources=this.resourceService.selectResourceByPage(dt);
        return resources;
    }

    //下载资源
    @GetMapping("outPutFile")
    @SysLog("下载资源")
    public void outPutFile(HttpServletResponse response, @RequestParam Long id){
        OutputStream output;
        ResourceVO r=this.resourceService.selectResourceById(id).get(0);
        String url=r.getUrl();
        String name=url.substring(url.lastIndexOf("."));
        try {
            String path=new File("").getCanonicalPath()+url;
            response.setHeader("Content-Disposition", "attachment;filename=" + r.getName()+name);
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 0);
            output = response.getOutputStream();
            InputStream in = new FileInputStream(path);
            OutputStream out = response.getOutputStream();

            //写文件
            int b;
            while((b=in.read())!= -1)
            {
                out.write(b);
            }
            in.close();
            out.close();
        } catch (Exception e) {
            System.out.println("error");
        }
    }

    @PostMapping("selectFileType")
    @ResponseBody
    public List<Dict> selectFileType(){
        QueryWrapper<Dict> dictEntityWrapper = new QueryWrapper<>();
        dictEntityWrapper.eq("type","sys_resource_category");
        dictEntityWrapper.eq("del_flag",false);
        List<Dict> list=this.dictService.list(dictEntityWrapper);
        return list;
    }


}
