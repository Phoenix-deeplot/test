package com.kst.activiti.controller;

import com.kst.activiti.controller.base.AcBaseController;
import com.kst.activiti.entity.PageData;
import com.kst.activiti.service.ProcessService;
import com.kst.activiti.service.act.ProcdefService;
import com.kst.activiti.service.act.RuprocdefService;
import com.kst.activiti.utils.Const;
import com.kst.activiti.utils.ImageAnd64Binary;
import com.kst.activiti.utils.PathUtil;
import com.kst.activiti.utils.Tools;
import com.kst.activiti.vo.ProcdefVO;
import com.kst.common.base.entity.ReturnDTO;
import com.kst.common.base.vo.DataTable;
import com.kst.activiti.dto.ProcessDefDTO;
import com.kst.common.enums.HttpCodeEnum;
import com.kst.common.utils.ReturnDTOUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;

/**
 *
 * @author: ys
 * @createTime: 2019/7/11.
 */
@Controller
@RequestMapping("/process")
public class ProcessController extends AcBaseController {
    ProcessEngine processEngine = ProcessEngines.getDefaultProcessEngine();
    @Autowired
    RepositoryService repositoryService;
    @Autowired
    ProcessService processService;
    @Autowired
    private ProcdefService procdefService;
    @Autowired
    private RuprocdefService ruprocdefService;

    @GetMapping(value = "/findProcessDefinition")
    public String findProcessDefinition(org.springframework.ui.Model model, HttpServletRequest request){
        model.addAttribute("url", request.getContextPath()+"/process/");
        return "process/processDefinitionList";
    }

    @PostMapping(value = "/findProcessDefinition")
    @ResponseBody
    public DataTable<ProcessDefDTO> findProcessDefinition(@RequestBody DataTable dt) {
        if (null == dt) {
            return null;
        }
        List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().list();//创建一个流程定义查询
        dt.setRows(list);
        dt.setTotal(list.size());
        return dt;
    }

	@GetMapping(value = "/list")
	public String list(org.springframework.ui.Model model, HttpServletRequest request) {

		model.addAttribute("url", request.getContextPath()+"/process/");
		return "process/processDefinitionList";
	}

    @RequiresPermissions("sys:process:list")
    @PostMapping("list")
    @ResponseBody
    public DataTable<ProcdefVO> list(@RequestBody DataTable dt) throws Exception {
        if (null == dt) {
            return null;
        }
        List<ProcdefVO> varList = procdefService.list(dt);
        dt.setRows(varList);
        dt.setTotal(varList.size());
        return dt;
    }

    @ApiOperation(value = "读取xml/image资源")
    @RequestMapping(value = "/goViewXml")
    @RequiresPermissions("sys:process:xml")
    public String resourceRead(org.springframework.ui.Model model,String deployId,String fileName) {
        try {
            PageData pd = new PageData();
            createXmlAndPng(deployId);							//生成XML和PNG
            String code = Tools.readFileAllContent(Const.FILEACTIVITI+fileName);
            pd.put("code", code);
            model.addAttribute("pd", pd);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "process/processXml";
    }

    /**去预览PNG页面
     * @param
     * @throws Exception
     */
    @ApiOperation(value = "读取png/Png资源")
    @RequestMapping(value="/goViewPng")
    @RequiresPermissions("sys:process:img")
    public String goViewPng(org.springframework.ui.Model model,String deployId,String fileName)throws Exception{
        PageData pd = new PageData();
        createXmlAndPng(deployId);							//生成XML和PNG
        pd.put("FILENAME", fileName);
        String imgSrcPath = PathUtil.getProjectpath()+Const.FILEACTIVITI+fileName;
        pd.put("imgSrc", "data:image/jpeg;base64,"+ ImageAnd64Binary.getImageStr(imgSrcPath)); //解决图片src中文乱码，把图片转成base64格式显示(这样就不用修改tomcat的配置了)
        model.addAttribute("pd", pd);
        return "process/processImg";
    }

    @ApiOperation(value = "激活/挂起", notes = "active为激活，suspend为挂起")
    @PostMapping("/status")
    @ResponseBody
    public ReturnDTO updateState(@RequestParam String status, @RequestParam String procDefId) {
        processService.updateStatus(status, procDefId);
        return ReturnDTOUtil.success();
    }
//
    @ApiOperation(value = "批量删除已部署流程", notes = "批量删除已部署流程")
    @PostMapping("/delete")
    @ResponseBody
    public ReturnDTO deleteProcIns(@RequestParam("ids") List<String> ids) {
	    if (CollectionUtils.isEmpty(ids)) {
	        return ReturnDTOUtil.custom(HttpCodeEnum.INVALID_REQUEST);
        }
	    ids.forEach(id -> processService.deleteDeployment(id));
        return ReturnDTOUtil.success();
    }
}
