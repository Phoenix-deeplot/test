package com.kst.activiti.controller;

import com.kst.common.base.controller.BaseController;
import com.kst.common.base.entity.ReturnDTO;
import com.kst.common.base.vo.DataTable;
import com.kst.common.enums.HttpCodeEnum;
import com.kst.common.exception.MyException;
import com.kst.activiti.form.ModelForm;
import com.kst.common.utils.ReturnDTOUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.activiti.engine.repository.Model;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("model")
public class ModelController {
    @GetMapping(value = "/list")
    public String list(org.springframework.ui.Model model, HttpServletRequest request) {
        return "model/list";
    }
}