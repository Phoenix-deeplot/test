package com.kst.isms.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.controller.BaseController;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.isms.entity.Question;
import com.kst.isms.entity.QuestionItem;
import com.kst.isms.vo.QuestionVO;
import com.kst.isms.service.IQuestionItemService;
import com.kst.isms.service.IQuestionService;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.service.IDictService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by zjf on 2017/11/21.
 */
@Controller
@RequestMapping("isms/question")
public class QuestionConteroller extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(QuestionConteroller.class);

    @Autowired
    private IQuestionService questionService;

    @Autowired
    private IQuestionItemService questionItemService;

    @Autowired
    private IDictService dictService;


    @GetMapping("list")
    @RequiresPermissions("isms:question:list")
    @SysLog("跳转试题列表页面")
    public String list() {
        return "question/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<QuestionVO> questionList(@RequestBody DataTable dt) {
        DataTable<QuestionVO> list = this.questionService.selectQuestionList(dt);

        return list;
    }

    @PostMapping("selectFileType")
    @ResponseBody
    public List<Dict> selectFileType(String type) {
        System.out.println("type" + type);
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", type);
        List<Dict> list = this.dictService.list(dictQueryWrapper);
        return list;
    }

    @ResponseBody
    @PostMapping("delete")
    @RequiresPermissions("isms:question:delete")
    public RestResponse delete(Long id) {
        Question q = new Question();
        q.setId(id);
        q.setDelFlag(true);
        boolean re = this.questionService.updateById(q);
        if (!re) {
            return RestResponse.failure("删除失败");
        }
        return RestResponse.success();
    }

    @PostMapping("deleteSome")
    @ResponseBody
    @RequiresPermissions("isms:question:delete")
    public RestResponse deleteSome(@RequestBody List<Question> list) {
        for (Question q : list) {
            this.questionService.updateById(q);
        }
        return RestResponse.success();
    }

    @GetMapping("add")
    @RequiresPermissions("isms:question:add")
    public String toAdd(Model model) {
        //考试类型
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "isms_question_category");
        dictQueryWrapper.eq("del_flag",false);
        //题目类型
        List<Dict> testList = this.dictService.list(dictQueryWrapper);
        QueryWrapper<Dict> dictQueryWrapper2 = new QueryWrapper<>();
        dictQueryWrapper2.eq("type", "isms_question_type");
        dictQueryWrapper2.eq("del_flag",false);
        List<Dict> questionList = this.dictService.list(dictQueryWrapper2);
        model.addAttribute("testType", testList);
        model.addAttribute("questionType", questionList);
        return "question/detail";
    }

    @GetMapping("addItem")
    public String toAddItem(Model model) {
        //考试类型
        model.addAttribute("handleItemType", 1);
        return "question/addItem";
    }

    @GetMapping("editItem/{id}")
    public String toEditItem(Model model, @PathVariable("id") String id) {
        //考试类型
        model.addAttribute("handleItemType", 2);
        model.addAttribute("editId", id);
        return "question/addItem";
    }

    @GetMapping("edit/{id}")
    @RequiresPermissions("isms:question:edit")
    public String toEdit(Model model, @PathVariable("id") Long id) {
        //考试类型
        QueryWrapper<Dict> dictQueryWrapper = new QueryWrapper<>();
        dictQueryWrapper.eq("type", "isms_question_category");
        dictQueryWrapper.eq("del_flag",false);
        //题目类型
        List<Dict> testList = this.dictService.list(dictQueryWrapper);
        QueryWrapper<Dict> dictQueryWrapper2 = new QueryWrapper<>();
        dictQueryWrapper2.eq("type", "isms_question_type");
        dictQueryWrapper2.eq("del_flag",false);
        List<Dict> questionList = this.dictService.list(dictQueryWrapper2);
        Question q = this.questionService.selectQuestionById(id);
        model.addAttribute("testType", testList);
        model.addAttribute("questionType", questionList);
        model.addAttribute("question", q);
        return "question/detail";
    }

    @PostMapping("edit")
    @ResponseBody
    public RestResponse edit(@RequestParam Map<String, Object> params) {
        String[] delIds = ((String) params.get("delIds")).split(",");
        //删除
        for (String i : delIds) {
            System.out.println("删除的id" + i);
            if(i!="" && i!=null){
                QuestionItem item=new QuestionItem();
                item.setId(Long.parseLong(i));
                item.setDelFlag(true);
                this.questionItemService.updateById(item);
            }
        }
        //question
        JSONObject jsonObject= JSONObject.fromObject(params.get("question"));
        Question question=(Question)JSONObject.toBean(jsonObject, Question.class);
        this.questionService.updateById(question);

        JSONArray jsonArray=JSONArray.fromObject(params.get("questionItems"));
        List<QuestionItem> questionItems=new ArrayList<>();

        for(int i=0;i<jsonArray.size();i++){
            Object o=jsonArray.get(i);
            JSONObject jsonObject2=JSONObject.fromObject(o);
            QuestionItem item=(QuestionItem)JSONObject.toBean(jsonObject2, QuestionItem.class);
            item.setQuestionId(question.getId());
            this.questionItemService.saveOrUpdate(item);
        }

        return RestResponse.success();
    }

    @PostMapping("add")
    @ResponseBody
    public RestResponse add(@RequestParam Map<String, Object> params) {
        JSONObject jsonObject= JSONObject.fromObject(params.get("question"));
        Question question=(Question)JSONObject.toBean(jsonObject, Question.class);
        question.setShowFlag(0);
        this.questionService.save(question);
        JSONArray jsonArray=JSONArray.fromObject(params.get("questionItems"));

        System.out.println();
        for(int i=0;i<jsonArray.size();i++){
            Object o=jsonArray.get(i);
            JSONObject jsonObject2=JSONObject.fromObject(o);
            QuestionItem item=(QuestionItem)JSONObject.toBean(jsonObject2, QuestionItem.class);
            item.setQuestionId(question.getId());
            this.questionItemService.save(item);
        }
        return RestResponse.success();
    }

    @PostMapping("loadQuestionItem")
    @ResponseBody
    public List<QuestionItem> selectQuestionItemByQuestionId(Long id) {
        List<QuestionItem> list = new ArrayList<>();
        if (id > 0) {
            QueryWrapper<QuestionItem> itemWrapper = new QueryWrapper<>();
            itemWrapper.eq("question_id", id);
            itemWrapper.eq("del_flag", false);
            list = this.questionItemService.list(itemWrapper);
        }
        return list;
    }
}
