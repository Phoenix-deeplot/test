package com.kst.pjs.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.common.utils.StringUtils;
import com.kst.log.annotation.SysLog;
import com.kst.pjs.entity.PjKind;
import com.kst.pjs.entity.PjMain;
import com.kst.pjs.entity.PjsUserGroup;
import com.kst.pjs.entity.SchDetail;
import com.kst.pjs.service.*;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.entity.UserGroup;
import com.kst.sys.api.service.IUserService;
import com.kst.sys.api.vo.UserVO;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 项目详细作业控制器
 */
@Controller
@RequestMapping("pjs/schDetail")
public class SchDetailController {

    @Autowired
    private IPjKindService pjKindService;

    @Autowired
    private ISchDetailService schDetailService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IPjsUserGroupService userGroupService;

    @Autowired
    private IProjectGroupService projectGroupService;

    @Autowired
    private IPjMainService pjMainService;

    @GetMapping("list/{id}")
    @SysLog("进入项目计划一览")
    public String toSchDetail(@PathVariable("id") String id, Model model) {
        model.addAttribute("pjId", id);
        return "/schDetail/list";
    }

    //分页查询schdetail信息
    @PostMapping("list")
    @ResponseBody
    public DataTable<SchDetail> list(@RequestBody DataTable dt) {
        return this.schDetailService.selectSchDetailByPage(dt);
    }

    @GetMapping("add/{pjId}")
    @SysLog("进入添加项目计划页面")
    public String add(@PathVariable("pjId") Long pjId, Model model) {
        QueryWrapper wrapper = new QueryWrapper();
        SchDetail schDetail = new SchDetail();
        schDetail.setPjId(pjId);
        wrapper.eq("pj_id", pjId);
        model.addAttribute("workKind", this.pjKindService.list(wrapper));
        model.addAttribute("schDetail", schDetail);
        return "/schDetail/detail";
    }

    @PostMapping("add")
    @ResponseBody
    @SysLog("添加项目计划")
    public RestResponse add(@RequestBody SchDetail schDetail) {
        if (schDetail.getUsers() != null && schDetail.getUsers() != "") {
            PjsUserGroup userGroup = new PjsUserGroup();
            userGroup.setName(schDetail.getWorkName());
            userGroup.setLevel(1);
            this.userGroupService.insertUserGroup(userGroup);
            for (String id : schDetail.getUsers().split(",")) {
                this.userGroupService.insertUserToUserGroup(userGroup.getId(), Long.parseLong(id));
            }
            schDetail.setWorkGroup(userGroup.getId());
        }

        if (!this.schDetailService.save(schDetail)) {
            return RestResponse.failure("添加失败");
        }
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    @SysLog("进入修改项目计划页面")
    public String edit(@PathVariable("id") Long id, Model model) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        SchDetail schDetail = this.schDetailService.selectSchDetailByMap(params).get(0);

        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("pj_id", schDetail.getPjId());
        model.addAttribute("workKind", this.pjKindService.list(wrapper));
        model.addAttribute("schDetail", schDetail);
        return "/schDetail/detail";
    }

    @PostMapping("edit")
    @ResponseBody
    @SysLog("修改项目计划")
    public RestResponse edit(@RequestBody SchDetail schDetail) {
        if (schDetail.getUsers() != null && schDetail.getUsers() != "") {

            PjsUserGroup userGroup = new PjsUserGroup();
            userGroup.setName(schDetail.getWorkName());
            userGroup.setLevel(1);
            this.userGroupService.insertUserGroup(userGroup);
            for (String id : schDetail.getUsers().split(",")) {
                this.userGroupService.insertUserToUserGroup(userGroup.getId(), Long.parseLong(id));
            }
            schDetail.setWorkGroup(userGroup.getId());
        }

        if (!this.schDetailService.updateById(schDetail)) {
            return RestResponse.failure("修改失败!");
        }
        return RestResponse.success();
    }

    //删除单条schdetail信息
    @PostMapping("delete")
    @ResponseBody
    public RestResponse delete(Long id) {
        SchDetail schDetail = this.schDetailService.getById(id);
        schDetail.setDelFlag(true);
        if (!this.schDetailService.updateById(schDetail))
            return RestResponse.failure("删除失败");

        return RestResponse.success();
    }

    //删除多条schdetail信息
    @PostMapping("deleteSome")
    @ResponseBody
    public RestResponse deleteSome(@RequestBody List<SchDetail> list) {
        for (SchDetail schDetail : list) {
//            schDetail=this.schDetailService.getById(schDetail.getId());
            System.out.println("项目编号：" + schDetail.getPjId());
            schDetail.setDelFlag(true);
            if (!this.schDetailService.updateById(schDetail)) {
                return RestResponse.failure("删除失败");
            }
        }

        return RestResponse.success();
    }

    @PostMapping("checkInteriorNoIsExist")
    @ResponseBody
    @SysLog("判断项目计划（内部）no是否存在")
    public RestResponse checkInteriorNoIsExist(String workNo, String workBKindId, String workMKindId, String workSKindId, Long pjId, Integer mode, Long id) {
        boolean result = true;
        String interiorNo = workNo + workBKindId + workMKindId + workSKindId;
        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("interior_no", interiorNo);
        wrapper.eq("pj_id", pjId);
        if (mode == 1) {//新增场合
            if (this.schDetailService.count(wrapper) > 0) {
                result = false;
            }
        } else if (mode == 2) {//编辑场合
            System.out.println("id:" + id);
            SchDetail oldSch = this.schDetailService.getById(id);
            if (StringUtils.isNotBlank(interiorNo)) {
                if (!interiorNo.equals(oldSch.getInteriorNo())) {
                    if (this.schDetailService.count(wrapper) > 0) {
                        result = false;
                    }
                }
            }
        }

        RestResponse restResponse = new RestResponse();
        restResponse.put("valid", result);
        return restResponse;
    }

    //导出excel文件
    @GetMapping("exportExcel")
    public void exportExcel(String pjId, HttpServletResponse response, HttpServletRequest request) {
        SimpleDateFormat namesdf = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Map<String, Object> params = new HashMap<>();
        params.put("pjId", pjId);
        params.put("workType", 1);
        List<SchDetail> list = this.schDetailService.selectSchDetailByMap(params);

        QueryWrapper wrapper = new QueryWrapper();
        wrapper.eq("pj_id", pjId);
        wrapper.eq("del_flag", false);

        List<PjKind> pjKinds = this.pjKindService.list(wrapper);

        PjMain main = this.pjMainService.getById(pjId);

        System.out.println("数据：" + JSON.toJSONString(main));
        XSSFWorkbook wb = null;
        InputStream in = null;
        try {
            in = new FileInputStream(new File("").getCanonicalPath() + "\\attach\\excelModel\\schDetail.xlsx");
            wb = new XSSFWorkbook(in);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        XSSFSheet sheet1 = wb.getSheet("进度详细");
        XSSFSheet sheet2 = wb.getSheet("下拉数据");

        //添加excel 文件的 创建人，创建时间，项目名称等信息
        sheet1.getRow(2).createCell(12).setCellValue(main.getName());
        sheet1.getRow(3).createCell(12).setCellValue(sdf.format(new Date()));
        sheet1.getRow(3).createCell(15).setCellValue(((User) request.getAttribute("currentUser")).getNickName());

        int Bint = 0;
        List<String> BArr = new ArrayList<>();
        int Mint = 0;
        List<String> MArr = new ArrayList<>();
        int Sint = 0;
        List<String> SArr = new ArrayList<>();
        //创建excel的三种分类下拉菜单内容
        for (int i = 0; i < pjKinds.size(); i++) {
            PjKind k = pjKinds.get(i);
            if (k.getKindFlg().equals("B")) {
                BArr.add(k.getKindId() + ":" + k.getKindName());
                Bint += 1;
            }
            if (k.getKindFlg().equals("M")) {
                MArr.add(k.getKindId() + ":" + k.getKindName());
                Mint += 1;
            }
            if (k.getKindFlg().equals("S")) {
                SArr.add(k.getKindId() + ":" + k.getKindName());
                Sint += 1;
            }
        }

        //创建excel的选择用户的下拉菜单内容
        List<User> users = this.projectGroupService.selectUserByPjId(Long.parseLong(pjId));

        System.out.println("用户数量：" + users.size());
        for (int i = 0; i < users.size(); i++) {
            User u = users.get(i);
            if (sheet2.getRow(i) == null) {
                XSSFRow row = sheet2.createRow(i);
                row.createCell(3).setCellValue(u.getNickName());
                row.createCell(4).setCellValue(u.getLoginName());
            } else {
                XSSFRow row = sheet2.getRow(i);
                row.createCell(3).setCellValue(u.getNickName());
                row.createCell(4).setCellValue(u.getLoginName());
            }
        }

        XSSFCellStyle cellStyle = wb.createCellStyle();
        XSSFDataFormat format = wb.createDataFormat();
        cellStyle.setDataFormat(format.getFormat("yyyy-MM-dd"));

        int i;
        //循环项目计划，并将其添加到excel中
        for (i = 0; i < list.size(); i++) {
            SchDetail s = list.get(i);
            XSSFRow row = null;
            if (i < 1) {
                row = sheet1.getRow(i + 6);
            } else {
                row = sheet1.createRow(i + 6);
                XSSFRow modeRow = sheet1.getRow(i + 5);
                for (int a = modeRow.getFirstCellNum(); a <= modeRow.getPhysicalNumberOfCells(); a++) {
                    row.createCell(a).setCellStyle(modeRow.getCell(a).getCellStyle());
                }
            }

            row.getCell(1).setCellValue(i + 1);
            row.getCell(2).setCellValue(s.getWorkNo());
            row.getCell(3).setCellValue(s.getWorkName());
            row.getCell(4).setCellValue((s.getWorkBKindId() != null ? s.getWorkBKindId() : "") + ":" + s.getWorkBKindName());
            row.getCell(5).setCellValue((s.getWorkMKindId() != null ? s.getWorkMKindId() : "") + ":" + s.getWorkMKindName());
            row.getCell(6).setCellValue((s.getWorkSKindId() != null ? s.getWorkSKindId() : "") + ":" + s.getWorkSKindName());

            XSSFCell c = row.getCell(7);
            c.setCellValue(s.getWorkPlanFrom() != null ? s.getWorkPlanFrom() : null);//日期类型设置为numeric
            c.setCellType(CellType.NUMERIC);

            c = row.getCell(8);
            c.setCellValue(s.getWorkPlanTo() != null ? s.getWorkPlanTo() : null);
            c.setCellType(CellType.NUMERIC);
            row.getCell(9).setCellValue(s.getWorkPlanUserName());
            c = row.getCell(10);
            //c.setCellFormula("IF(J"+(i+7)+"<>\"\",VLOOKUP(J"+(i+7)+",下拉数据!$D:$E,2,FALSE),\"\")");
            c.setCellValue(s.getWorkPlanUser() != null ? s.getWorkPlanUser() : null);

            row.getCell(11).setCellValue(s.getWorkPlanTimes());

            c = row.getCell(12);
            c.setCellValue(s.getWorkFactFrom() != null ? s.getWorkFactFrom() : null);
            c.setCellType(CellType.NUMERIC);

            c = row.getCell(13);
            c.setCellValue(s.getWorkFactTo() != null ? s.getWorkFactTo() : null);
            c.setCellType(CellType.NUMERIC);

            row.getCell(14).setCellValue(s.getWorkFactUserName());
            c = row.getCell(15);
            //c.setCellFormula("IF(O"+(i+7)+"<>\"\",VLOOKUP(O"+(i+7)+",下拉数据!$D:$E,2,FALSE),\"\")");
            c.setCellValue(s.getWorkPlanUser() != null ? s.getWorkPlanUser() : "");
            row.getCell(16).setCellValue(s.getWorkFactTimes());
            row.getCell(17).setCellValue(s.getWorkFinishPer());
            row.getCell(18).setCellValue(s.getWorkMemo());

        }

        if (BArr.size() > 0) {
            setXSSFValidation(sheet1, (String[]) BArr.toArray(new String[0]), 6, 1000, 4, 4);
        }
        if (MArr.size() > 0) {
            setXSSFValidation(sheet1, (String[]) MArr.toArray(new String[0]), 6, 1000, 5, 5);
        }
        if (SArr.size() > 0) {
            setXSSFValidation(sheet1, (String[]) SArr.toArray(new String[0]), 6, 1000, 6, 6);
        }

        if (i < 10) {
            i = 16;
        } else {
            i += 6;
        }
        //添加备注信息
        sheet1.createRow(i + 2).createCell(8).setCellValue("注：");
        sheet1.createRow(i + 3).createCell(8).setCellValue("1.项目设定为最大1000行，超出范围不作登录。");
        sheet1.createRow(i + 4).createCell(8).setCellValue("2.作业编号确定后不作修改。新编号作为新作业登录，修改前的作业会被删除。");
        sheet1.createRow(i + 5).createCell(8).setCellValue("3.重复的作业编号，已最后一次为基准。");
        sheet1.createRow(i + 6).createCell(8).setCellValue(" 4.担当者ID请勿修改。");

        //流输出excel对象，在浏览器显示下载
        OutputStream os = null;
        try {
            os = response.getOutputStream();
            response.reset();
            response.setHeader("Content-disposition", "attachment;filename=schDetail" + namesdf.format(new Date()) + ".xlsx"); //定义下载的类型，标明是excel文件
            response.setContentType("application/vnd.ms-excel"); //这时候把创建好的excel写入到输出流
            wb.write(os);
            os.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public static XSSFSheet setXSSFValidation(XSSFSheet sheet, String[] textlist, int firstRow, int endRow, int firstCol,
                                              int endCol) {
        XSSFDataValidationHelper dvHelper = new XSSFDataValidationHelper(sheet);
        XSSFDataValidationConstraint dvConstraint = (XSSFDataValidationConstraint) dvHelper
                .createExplicitListConstraint(textlist);
        CellRangeAddressList addressList = null;
        XSSFDataValidation validation = null;

        addressList = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
        validation = (XSSFDataValidation) dvHelper.createValidation(
                dvConstraint, addressList);
        sheet.addValidationData(validation);
        return sheet;
    }

    //上传excel文件，并且读取文件信息，添加到项目计划表(pjs_sch_detail)
    @PostMapping("uploadExcel/{pjId}")
    @ResponseBody
    public RestResponse uploadExcel(@PathVariable("pjId") Long pjId, @RequestParam("file") MultipartFile file) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String fileName = file.getOriginalFilename();
        if (!fileName.substring(fileName.lastIndexOf(".")).equals(".xlsx")) {
            return RestResponse.failure("导入的文件不是.xlsx格式，请选择正确的文件导入");
        }

        XSSFWorkbook wb = null;
        try {
            wb = new XSSFWorkbook(file.getInputStream());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        XSSFSheet sheet = wb.getSheet("进度详细");

        if(sheet==null){
            return RestResponse.failure("2");
        }

        QueryWrapper wra = new QueryWrapper();
        wra.eq("pj_id", pjId);
        List<SchDetail> schDetails = this.schDetailService.list(wra);
        List<Long> ids = new ArrayList<>();
        for (SchDetail schDetail : schDetails) {
            ids.add(schDetail.getId());
        }

        List<SchDetail> saveDatas = new ArrayList<>();

        //循环读取的文件的行数
        for (int i = 6; i <= sheet.getLastRowNum(); i++) {
            int errInt = 2;
            try {
                XSSFRow row = sheet.getRow(i);

                if (row != null) {
                    //若work_no为空，则终止循环
                    if (row.getCell(2)==null || row.getCell(2).getStringCellValue().equals("") || row.getCell(2).getStringCellValue().equals(null)) {
                        break;
                    }

                    SchDetail schDetail = new SchDetail();
                    schDetail.setPjId(pjId);
                    schDetail.setWorkNo(row.getCell(2).getStringCellValue());
                    errInt += 1;
                    schDetail.setWorkName(row.getCell(3).getStringCellValue());
                    errInt += 1;
                    schDetail.setWorkBKindId(checkNull(row.getCell(4)) ? (row.getCell(4).getStringCellValue().split(":").length > 0 ? row.getCell(4).getStringCellValue().split(":")[0] : "") : "");
                    errInt += 1;
                    schDetail.setWorkMKindId(checkNull(row.getCell(5)) ? (row.getCell(5).getStringCellValue().split(":").length > 0 ? row.getCell(5).getStringCellValue().split(":")[0] : "") : "");
                    errInt += 1;
                    schDetail.setWorkSKindId(checkNull(row.getCell(6)) ? (row.getCell(6).getStringCellValue().split(":").length > 0 ? row.getCell(6).getStringCellValue().split(":")[0] : "") : "");
                    schDetail.setInteriorNo(schDetail.getWorkNo() + schDetail.getWorkBKindId() + schDetail.getWorkMKindId() + schDetail.getWorkSKindId());
                    errInt += 1;
                    schDetail.setWorkPlanFrom(row.getCell(7)!=null?row.getCell(7).getDateCellValue()!=null?row.getCell(7).getDateCellValue():new Date():new Date());
                    errInt += 1;
                    schDetail.setWorkPlanTo(row.getCell(8)!=null?row.getCell(8).getDateCellValue()!=null?row.getCell(8).getDateCellValue():null:null);
                    errInt += 2;
                    schDetail.setWorkPlanUser(checkNull(row.getCell(10)) ? row.getCell(10).getStringCellValue() : null);
                    errInt += 1;
                    schDetail.setWorkPlanTimes(checkNull(row.getCell(11)) ? row.getCell(11).getNumericCellValue() : null);
                    errInt += 1;
                    schDetail.setWorkFactFrom(row.getCell(12)!=null?row.getCell(12).getDateCellValue()!=null?row.getCell(12).getDateCellValue():null:null);
                    errInt += 1;
                    schDetail.setWorkFactTo(row.getCell(13)!=null?row.getCell(13).getDateCellValue()!=null?row.getCell(13).getDateCellValue():null:null);
                    errInt += 2;
                    schDetail.setWorkFactUser(checkNull(row.getCell(15)) ? row.getCell(15).getStringCellValue() : null);
                    errInt += 1;
                    schDetail.setWorkFactTimes(checkNull(row.getCell(16)) ? row.getCell(16).getNumericCellValue() : null);
                    errInt += 1;
                    schDetail.setWorkFinishPer(checkNull(row.getCell(17)) ? row.getCell(17).getNumericCellValue() : null);
                    errInt += 1;
                    schDetail.setWorkMemo(checkNull(row.getCell(18)) ? row.getCell(18).getStringCellValue() : null);
                    //存在的对象修改 ，不存在的对象新增
                    saveDatas.add(schDetail);
                }
            } catch (NullPointerException e) {
                e.printStackTrace();
                return RestResponse.failure(1+":"+(i+1)+ ":" + (char) (errInt + 65) + ":null");
            } catch (IllegalStateException e) {
                e.printStackTrace();
                return RestResponse.failure(1+":"+(i+1)+ ":" + (char) (errInt + 65) + ":type");
            } catch (Exception e) {
                e.printStackTrace();
                return RestResponse.failure(1+":"+(i+1)+ ":" + (char) (errInt + 65)+":");
            }
        }

        this.schDetailService.saveBatch(saveDatas);


        //添加完后删除
        if (ids.size() > 0)
            schDetailService.removeByIds(ids);

        return RestResponse.success();
    }

    public Date getDate(XSSFCell cell) {
        Calendar calendar = new GregorianCalendar(1900, 0, -1);
        Date d = calendar.getTime();
        if (cell.getNumericCellValue() == 0.0) {
            return null;
        } else {
            return DateUtils.addDays(d, (int) cell.getNumericCellValue());
        }
    }

    public boolean checkNull(Object o) {
        if (o != null) {
            return true;
        } else {
            return false;
        }
    }
}
