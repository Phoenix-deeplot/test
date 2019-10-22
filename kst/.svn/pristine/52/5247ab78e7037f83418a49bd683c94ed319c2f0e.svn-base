package com.kst.ams.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.kst.ams.entity.AssetExamine;
import com.kst.ams.service.IAssetExamineService;
import com.kst.ams.service.IAssetInfoService;
import com.kst.ams.service.IChartService;
import com.kst.ams.service.IDivideService;
import com.kst.ams.utils.DocOutUtil;
import com.kst.ams.vo.*;
import com.kst.common.shiro.MySysUser;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.Organization;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IDictService;
import com.kst.sys.api.service.IOrganizationService;
import com.kst.sys.api.vo.OrganizationVO;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping("ams/infomationStatistics")
public class InfomationController {

    @Autowired
    private IDivideService divideService;

    @Autowired
    private IOrganizationService organizationService;

    @Autowired
    private IAssetInfoService assetInfoService;

    @Autowired
    private IDictService dictService;

    @Autowired
    private IAssetExamineService assetExamineService;

    @Autowired
    private IChartService chartService;

    @GetMapping("depreciation")
    @RequiresPermissions("ams:infomationStatistics:depreciation")
    @SysLog("跳转系统资产列表页面")
    public String list(Model model) {
        return "infomationStatistics/depreciation";
    }

    @PostMapping("depreciation")
    @ResponseBody
    public List<DepreciationVO> depreciationList(@RequestBody Map<String, Object> params) {
        List<DepreciationVO> list = this.divideService.selectDepreciationList(params);
        DepreciationVO sumVo = new DepreciationVO();
        for (DepreciationVO v : list) {
            sumVo.setProvisionAllValue(sumVo.getProvisionAllValue() + v.getProvisionAllValue());
            sumVo.setBalanceValue(sumVo.getBalanceValue() + v.getBalanceValue());
            sumVo.setProvisionValue(sumVo.getProvisionValue() + v.getProvisionValue());
            sumVo.setNetWorth(sumVo.getNetWorth() + v.getNetWorth());
            sumVo.setResidualPrice(sumVo.getResidualPrice() + v.getResidualPrice());
            sumVo.setMonthProvision(sumVo.getMonthProvision() + v.getMonthProvision());
            sumVo.setPrice(sumVo.getPrice() + v.getPrice());
            sumVo.setAmount(sumVo.getAmount() + v.getAmount());
            sumVo.setName("合计");
        }
        list.add(sumVo);
        return list;
    }

    @GetMapping("depreciationExcel/{yymm}")
    @ResponseBody
    public void exportExcel(@PathVariable("yymm") String yymm, HttpServletResponse response, HttpServletRequest request) {
        Map<String, Object> params = new HashMap<>();

        params.put("yymm", yymm);
        List<DepreciationVO> list = this.divideService.selectDepreciationList(params);
        OrganizationVO organ = organizationService.selectRootOrganization(MySysUser.id());
        DocOutUtil util = new DocOutUtil();
        util.exportDivideExcel(yymm, list, organ!=null?organ.getName():"", response, request);
    }

    //导出pdf文件方法
//    @GetMapping("depreciationPdf/{yymm}")
//    @ResponseBody
//    public void exportPdf(@PathVariable("yymm") String yymm, HttpServletResponse response, HttpServletRequest request) {
//        Map<String, Object> params = new HashMap<>();
//        params.put("yymm", yymm);
//        List<DepreciationVO> list = this.divideService.selectDepreciationList(params);
//        DepreciationVO sumVo = new DepreciationVO();
//        for (DepreciationVO v : list) {
//            sumVo.setProvisionAllValue(sumVo.getProvisionAllValue() + v.getProvisionAllValue());
//            sumVo.setBalanceValue(sumVo.getBalanceValue() + v.getBalanceValue());
//            sumVo.setProvisionValue(sumVo.getProvisionValue() + v.getProvisionValue());
//            sumVo.setNetWorth(sumVo.getNetWorth() + v.getNetWorth());
//            sumVo.setResidualPrice(sumVo.getResidualPrice() + v.getResidualPrice());
//            sumVo.setMonthProvision(sumVo.getMonthProvision() + v.getMonthProvision());
//            sumVo.setPrice(sumVo.getPrice() + v.getPrice());
//            sumVo.setAmount(sumVo.getAmount() + v.getAmount());
//            sumVo.setName("合计");
//        }
//        list.add(sumVo);
//
//        OrganizationVO organ = this.organizationService.selectRootOrganization(((User) request.getAttribute("currentUser")).getId());
//
//        Document document = new Document(PageSize.A4.rotate());
//        ByteArrayOutputStream baos = new ByteArrayOutputStream();
//
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy年MM月止");
//
//        try {
//            PdfWriter.getInstance(document, baos);
//            document.open();
//
//            BaseFont bfChinese = BaseFont.createFont("STSongStd-Light", "UniGB-UCS2-H", false);
//            Font headFont = new Font(bfChinese, 8, Font.BOLD);
//            Font bodyFont = new Font(bfChinese, 6, Font.NORMAL);
//            document.add(new Phrase("                              " + yymm.substring(0, 4) + "年" + yymm.substring(4, 6) + "月  固定资产折旧表", headFont));
//            document.add(new Phrase("                                                                                                      "));
//            document.add(new Phrase("                                                      社名：" + organ.getName(), headFont));
//
//            //document.addTitle()
//            //document.add(new Paragraph("",headFont));
//
//            PdfPTable table = new PdfPTable(14);
//            table.setSpacingBefore(10f);
//            table.setWidthPercentage(99);
//            table.setTotalWidth(new float[]{70, 160, 160, 100, 40, 100, 100, 100, 40, 100, 100, 100, 100, 120});
//            String[] headers = {"购买日", "资产编号", "资产名称", "资产种类", "数量", "原值", "净值", "残值", "年限", "每月计提", "本月计提", "已提折旧", "账面余额", "备注"};
//            for (String s : headers) {
//                table.addCell(new Paragraph(s, headFont));
//            }
//
//            for (int i = 0; i < list.size(); i++) {
//                DepreciationVO vo = list.get(i);
//
//                Class cls = vo.getClass();
//                Field[] fields = cls.getDeclaredFields();
//                for (int j = 0; j < fields.length; j++) {
//                    Field f = fields[j];
//                    f.setAccessible(true);
//                    if (f.get(vo) != null) {
//                        if (f.getType() == java.util.Date.class) {
//                            if (f.getName() == "reservescrapDate") {
//                                table.addCell(new Paragraph(sdf2.format(f.get(vo)), bodyFont));
//                            } else if (f.getName() == "buyDate") {
//                                table.addCell(new Paragraph(sdf.format(f.get(vo)), bodyFont));
//                            }
//                        } else {
//                            table.addCell(new Paragraph(String.valueOf(f.get(vo)), bodyFont));
//                        }
//                    } else {
//                        table.addCell(new Paragraph("", bodyFont));
//                    }
//                }
//            }
//            document.add(table);
//            document.close();
//
//            OutputStream os = response.getOutputStream();
//            response.setContentType("application/pdf");
//            response.setHeader("Content-Disposition", "attachment; filename=divide.pdf");
//            response.setContentLength(baos.size());
//            baos.writeTo(os);
//            os.flush();
//            os.close();
//        } catch (DocumentException e) {
//            e.printStackTrace();
//        } catch (IOException e) {
//            e.printStackTrace();
//        } catch (IllegalAccessException e) {
//            e.printStackTrace();
//        }
//    }

    @GetMapping("assetList")
    public String assetList(Model model) {
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_type");
        //题目类型
        List<Dict> list = this.dictService.list(dictQueryWrapper);
        model.addAttribute("assetType", list);//资产类型

        dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "ams_asset_status");
        dictQueryWrapper.eq("del_flag",false);
        list = this.dictService.list(dictQueryWrapper);
        model.addAttribute("assetStatus", list);

        return "infomationStatistics/assetList";
    }

    @PostMapping("assetList")
    @ResponseBody
    public List<AssetListVO> assetList(@RequestBody Map<String, Object> params) {
        List<AssetListVO> list = this.assetInfoService.selectAssetList(params);
        return list;
    }

    @GetMapping("assetListExcel")
    @ResponseBody
    @SysLog("下载资产信息excel表")
    public void assetListExcel(String name, String classifyId, String statusProperty, HttpServletResponse response, HttpServletRequest request) {
        Map<String, Object> params = new HashMap<>();
        List<String> classList= Arrays.asList(classifyId.split(",")) ;
        params.put("name", name);
        params.put("classifyId", classList);
        params.put("statusProperty", statusProperty);

        List<AssetListVO> list = this.assetInfoService.selectAssetList(params);
        OrganizationVO organ = organizationService.selectRootOrganization(MySysUser.id());
        DocOutUtil util = new DocOutUtil();
        String className = "";
        if (classifyId != null && classList.size()>0) {
            QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
            dictQueryWrapper.eq("type", "ams_asset_type");
            dictQueryWrapper.in("value", classList);
            //题目类型
            List<Dict> dict = this.dictService.list(dictQueryWrapper);
            for (int i=0;i<dict.size();i++){
                className += dict.get(i).getLabel()+" ";
            }
        }
        util.exportAssetListExcel(list,organ!=null? organ.getName():"", className, response, request);
    }

    @GetMapping("assetListDetailExcel")
    @ResponseBody
    @SysLog("下载资产信息详细excel表")
    public void assetListDetailExcel(String name, String classifyId, String statusProperty, HttpServletResponse response, HttpServletRequest request) {
        Map<String, Object> params = new HashMap<>();
        List<String> classList= Arrays.asList(classifyId.split(",")) ;
        params.put("name", name);
        params.put("classifyId", classList);
        params.put("statusProperty", statusProperty);
        List<AssetListVO> list = this.assetInfoService.selectAssetListDetail(params);
        OrganizationVO organ = organizationService.selectRootOrganization(MySysUser.id());
        DocOutUtil util = new DocOutUtil();
        String className = "";
        if (classifyId != null && classList.size()>0) {
            QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
            dictQueryWrapper.eq("type", "ams_asset_type");
            dictQueryWrapper.in("value", classList);
            //题目类型
            List<Dict> dict = this.dictService.list(dictQueryWrapper);
            for (int i=0;i<dict.size();i++){
                className += dict.get(i).getLabel()+" ";
            }
        }
        util.exportAssetListDetailExcel(list, organ!=null?organ.getName():"", className, true, response, request);
    }


    @GetMapping("assetExamine")
    @RequiresPermissions("ams:infomationStatistics:assetExamine")
    @SysLog("跳转系统资产列表页面")
    public String assetExamine(Model model) {
        return "infomationStatistics/assetExamine";
    }

    @GetMapping("assetExamineDetailExcel")
    public void assetExamineDetailExcel(String id, HttpServletResponse response, HttpServletRequest request) {
        AssetExamine examine = this.assetExamineService.getById(id);
        List<AssetExamineDetailVO> list = this.assetInfoService.selectAssetExamine(examine.getNo());

        OrganizationVO organ = organizationService.selectRootOrganization(MySysUser.id());
        DocOutUtil util = new DocOutUtil();
        util.exportAssetExamineDetail(list, examine, organ!=null?organ.getName():"", response, request);
    }

    @GetMapping("assetDiscard")
    @RequiresPermissions("ams:infomationStatistics:assetDiscard")
    @SysLog("转跳资产报废信息页面")
    public String assetDiscard() {
        return "infomationStatistics/assetDiscard";
    }

    @PostMapping("selectDiscard")
    @ResponseBody
    public List<AssetDiscardVO> selectDiscard(@RequestBody Map<String, Object> params) {
        //查看资产报废信息
        List<AssetDiscardVO> list = this.assetInfoService.selectAssetDiscardByDate(params);
        return list;
    }

    @GetMapping("assetDiscardExcel")
    @SysLog("导出资产报废信息excel")
    public void assetDiscardExcel(String date, boolean yymmFlag, boolean isReserveFlag, HttpServletResponse response, HttpServletRequest request) {
        Map<String,Object> params=new HashMap<>();
        if (yymmFlag) {
            if (isReserveFlag) {
                params.put("actualYy",date.substring(0, 4));
            } else {
                params.put("reserveYy",date.substring(0, 4));
            }
            date=date.substring(0,4)+"年";
        } else {
            if (isReserveFlag) {
                params.put("actualYymm",date);
            } else {
                params.put("reserveYymm",date);
            }
            date=date.substring(0,4)+"年"+date.substring(4,6)+"月";
        }
        List<AssetDiscardVO> list=this.assetInfoService.selectAssetDiscardByDate(params);
        DocOutUtil util=new DocOutUtil();
        Organization organization=organizationService.selectRootOrganization(MySysUser.id());
        util.exportAssetDiscardExcel(list,date,isReserveFlag,organization!=null?organization.getName() :"",response,request);
    }

    @GetMapping("chart")
    @RequiresPermissions("ams:infomationStatistics:chart")
    @SysLog("转跳资产图表统计页面")
    public String chartPage(){
        return "infomationStatistics/chart";
    }

    @PostMapping("selectUseRatio")
    @ResponseBody
    public List<ChartVO> selectUseRatio(Date selectDate){
        //查询仪表图的信息
        Map<String,Object> params=new HashMap<>();
        params.put("selectDate",selectDate);
        List<ChartVO> list=this.chartService.selectUseRatio(params);
        return list;
    }

    @PostMapping("selectPieData")
    @ResponseBody
    public List<ChartVO> selectPieData(Date selectDate){
        //查询饼图信息
        Map<String,Object> params=new HashMap<>();
        params.put("selectDate",selectDate);
        params.put("yymm",new SimpleDateFormat("yyyyMM").format(selectDate));
        return this.chartService.selectPieData(params);
    }

    @PostMapping("selectDivideAsset")
    @ResponseBody
    public List<ChartVO> selectDivideAsset(Date selectDate){
        //查询资产折旧情况（折线图）
        return this.chartService.selectDivideAssetOnLastYear(this.dictService.getDictByType("ams_asset_type"),selectDate);
    }

    @PostMapping("selectBarGraphData")
    @ResponseBody
    public List<ChartVO> selectBarGraphData(Date selectDate){
        //加载柱状图信息
        List<ChartVO> list=this.chartService.selectNextYearAssetData(this.dictService.getDictByType("ams_asset_type"),selectDate);
        return list;
    }


}
