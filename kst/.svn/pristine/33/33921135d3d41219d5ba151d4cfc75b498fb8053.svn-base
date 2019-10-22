package com.kst.isms.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.vo.DataTable;
import com.kst.common.utils.RestResponse;
import com.kst.isms.entity.Question;
import com.kst.isms.entity.Topic;
import com.kst.isms.entity.UserAnswer;
import com.kst.isms.entity.UserTest;
import com.kst.isms.service.IQuestionService;
import com.kst.isms.service.ITopicService;
import com.kst.isms.service.IUserTestService;
import com.kst.isms.vo.QuestionVO;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IDictService;
import com.kst.sys.api.service.IUserService;
import com.kst.sys.api.vo.UserVO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("isms/test")
public class TestController {
    private static final Logger LOGGER = LoggerFactory.getLogger(TestController.class);

    @Autowired
    private ITopicService topicService;

    @Autowired
    private IDictService dictService;

    @Autowired
    private IQuestionService questionService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IUserTestService userTestService;


    @GetMapping("list")
    @RequiresPermissions("isms:test:list")
    public String list(Model model){
        Map<String,Object> params=new HashMap<>();
        QueryWrapper<Dict> wrapper1 = new QueryWrapper<>();
        wrapper1.eq("type", "isms_test_status");
        wrapper1.eq("del_flag",false);
        List<Dict> types=this.dictService.list(wrapper1);
        params.put("statusList",types);

        QueryWrapper<Dict> wrapper2 = new QueryWrapper<>();
        wrapper2.eq("type", "isms_test_type");
        wrapper2.eq("del_flag",false);
        types=this.dictService.list(wrapper2);
        params.put("testTypeList",types);

        QueryWrapper<Dict> wrapper3 = new QueryWrapper<>();
        wrapper3.eq("type", "isms_question_type");
        wrapper3.eq("del_flag",false);
        types=this.dictService.list(wrapper3);
        params.put("questionType",types);
        System.out.println(params.toString());
        model.addAttribute("testParams",params);
        return "test/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<Topic> topicList(@RequestBody DataTable dt,HttpServletRequest request) {
        DataTable<Topic> list = this.topicService.pageSearch(dt);
        for (Topic t:list.getRows()) {
            t.setFinishDegree(this.topicService.getFinishDegree(t.getId()));
        }
        return list;
    }

    @PostMapping("selectFileType")
    @ResponseBody
    public List<Dict> selectFileType(String type) {
        System.out.println("type" + type);
        QueryWrapper<Dict> dictEntityWrapper = new QueryWrapper<>();
        dictEntityWrapper.eq("type", type);
        List<Dict> list = this.dictService.list(dictEntityWrapper);
        return list;
    }

    @GetMapping("add")
    @RequiresPermissions("isms:test:add")
    public String add(Model model){
        QueryWrapper<Dict> dictEntityWrapper = new QueryWrapper<>();
        dictEntityWrapper.eq("type", "isms_question_type");
        List<Dict> types=this.dictService.list(dictEntityWrapper);
        Map<String,Object> params=new HashMap<>();
        params.put("types",types);
        model.addAttribute("testParams",params);
        return "test/detail";
    }

    @PostMapping("add")
    @ResponseBody
    public RestResponse add(@RequestBody Topic topic){
        topic.setStatus(1);
        System.out.println(topic.getName()+""+topic.getQualifiedScore());
        this.topicService.save(topic);
        return RestResponse.success();
    }

    @GetMapping("edit/{id}")
    @RequiresPermissions("isms:test:edit")
    public String edit(Model model,@PathVariable("id") Long id){
        QueryWrapper<Dict> dictEntityWrapper = new QueryWrapper<>();
        dictEntityWrapper.eq("type", "isms_question_type");
        List<Dict> types=this.dictService.list(dictEntityWrapper);
        Topic topic=this.topicService.getById(id);
        Map<String,Object> params=new HashMap<>();
        params.put("types",types);
        params.put("topic",topic);
        model.addAttribute("testParams",params);
        return "test/detail";
    }

    @PostMapping("edit")
    @ResponseBody
    public RestResponse edit(@RequestBody Topic topic){
        this.questionService.deleteTopicQuestion(topic.getId());
        this.topicService.updateById(topic);
        return RestResponse.success();
    }

    @PostMapping("delete")
    @ResponseBody
    @RequiresPermissions("isms:test:delete")
    public RestResponse delete(Long id){
        Topic topic=new Topic();
        topic.setDelFlag(true);
        topic.setId(id);
        if(!this.topicService.updateById(topic)){
            return RestResponse.failure("删除失败");
        }
        return RestResponse.success();
    }

    @PostMapping("deleteSome")
    @ResponseBody
    @RequiresPermissions("isms:test:delete")
    public RestResponse deleteSome(@RequestBody List<Topic> list) {
        if(!this.topicService.updateBatchById(list)){
            return RestResponse.failure("删除失败");
        }
        return RestResponse.success();
    }

    @PostMapping("updateAutomationFlag")
    @ResponseBody
    public RestResponse updateAutomationFlag(@RequestBody Topic topic){
        if(!this.topicService.updateById(topic)){
            return RestResponse.failure("修改失败");
        }
        return RestResponse.success();
    }

    @GetMapping("setQuestion/{id}")
    public String setQuestion(Model model,@PathVariable("id") Long id){
        QueryWrapper<Dict> dictEntityWrapper = new QueryWrapper<>();
        dictEntityWrapper.eq("type", "isms_question_type");
        List<Dict> types=this.dictService.list(dictEntityWrapper);

        Topic topic=this.topicService.getById(id);
        Map<String,Object> params=new HashMap<>();
        params.put("topic",topic);
        params.put("types",types);
        model.addAttribute("testParams",params);
        return "test/setQuestion";
    }

    @PostMapping("setQuestion")
    @ResponseBody
    public RestResponse setQuestion(String rows, String topic){
        Topic topic1=(Topic)JSONObject.toBean(JSONObject.fromObject(topic),Topic.class);
        //System.out.println(topic1.getId()+"        "+topic1.getQuestionCounts());
        this.topicService.updateById(topic1);
        JSONArray jsonArray=JSONArray.fromObject(rows);
        Set<Question> set=new HashSet<>();
        for(int i=0;i<jsonArray.size();i++){
            Object o=jsonArray.get(i);
            JSONObject jsonObject2=JSONObject.fromObject(o);
            Question question=(Question)JSONObject.toBean(jsonObject2, Question.class);
            set.add(question);
        }
        this.questionService.insertTopicQuestion(topic1.getId(),set);
        return RestResponse.success();
    }


    @PostMapping("questionList")
    @ResponseBody
    public DataTable<QuestionVO> questionList(@RequestBody DataTable dt) {
        this.questionService.selectQuestionList(dt);
        return dt;
    }

    //公开试卷
    @PostMapping("openTest")
    @ResponseBody
    public RestResponse openTest(@RequestBody List<Topic> list){
        this.topicService.updateBatchById(list);
        return RestResponse.success();
    }

    @GetMapping("preview/{id}")
    //加载考卷题目
    public String preview(@PathVariable("id") Long id, Model model, HttpServletRequest request){
        Map<String,Object> params=new HashMap<>();
        Topic topic=this.topicService.getById(id);
        QueryWrapper<Dict> dictQueryWrapper2 = new QueryWrapper<>();
        dictQueryWrapper2.eq("type", "isms_question_type");
        List<Dict> questionTypeList = this.dictService.list(dictQueryWrapper2);

        Map<String,Object> param=new HashMap<>();
        if(topic.getAutomationFlag()==true){
            param.put("ids",getRandomQuestion(topic));
        }else{
            param.put("topicId",id);
        }

        List<QuestionVO> list= this.questionService.selectQuestionByTopicId(param);
        params.put("questions",list);
        params.put("topic",topic);
        params.put("questionTypeList",questionTypeList);
        model.addAttribute("examParams",params);
        return "test/preview";
    }
    //获取随机问题的id集合
    public List<Long> getRandomQuestion(Topic topic){
        String[] types=topic.getQuestionTypes().split(",");
        String[] amount=topic.getQuestionAmounts().split(",");

        List<Long> ids=new ArrayList<>();
        for (int i=0;i<types.length;i++){
            List<Long> id=this.questionService.selectIds(Long.parseLong(types[i]));
            Collections.shuffle(id);
            List<Long> temp=new ArrayList<>();
            for (int j=0;j<id.size();j++){
                if(temp.size()<Integer.parseInt(amount[i])){
                    temp.add(id.get(j));
                }
            }
            ids.addAll(temp);
        }
        return ids;
    }

    //进入选择用户页面
    @GetMapping("choiceUser/{id}")
    public String choiceUser(Model model,@PathVariable("id") Long topicId){
        model.addAttribute("users",this.topicService.selectUserFromUserTopic(topicId));
        model.addAttribute("topicId",topicId);
        return "test/authority";
    }

    //加载用户
    @PostMapping("loadUsers")
    @ResponseBody
    public List<User> selectUsers(){
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("del_flag",false);
        return this.userService.list(wrapper);
    }

    //保存 用户-试卷 权限
    @PostMapping("saveAuthority")
    @ResponseBody
    public RestResponse saveAuthority(String users,Long topicId){
        for (Long userId:this.topicService.selectUserIds(topicId)){
            this.topicService.deleteUserTopic(userId,topicId);
        }

        if(users.length()>10){
            JSONArray jsonArray=JSONArray.fromObject(users);

            for(int i=0;i<jsonArray.size();i++){
                User u=(User)JSONObject.toBean(JSONObject.fromObject(jsonArray.get(i)), User.class);
                this.topicService.insertUserTopic(u.getId(),topicId);
            }
        }


        return RestResponse.success();
    }

    @GetMapping("finishDetail/{id}")
    public String finishDetail(@PathVariable("id") Long topicId,Model model){
        QueryWrapper<UserTest> userTestQueryWrapper=new QueryWrapper<>();
        userTestQueryWrapper.eq("topic_id",topicId);
        List<UserTest> usertests=this.userTestService.list(userTestQueryWrapper);

        List<UserVO> users=this.topicService.selectUserFromUserTopic(topicId);
        Topic topic=this.topicService.getById(topicId);

        String[] scores=topic.getQuestionScores().split(",");
        String[] amounts=topic.getQuestionAmounts().split(",");
        Integer sum=0;
        for (int i=0;i<scores.length;i++){
            sum+=Integer.parseInt(scores[i])*Integer.parseInt(amounts[i]);
        }
        topic.setFinishDegree(this.topicService.getFinishDegree(topic.getId()));

        Map<String,Object> param=new HashMap<>();
        param.put("sum",sum);
        param.put("topic",topic);
        param.put("userTests",usertests);
        param.put("users",users);
        model.addAttribute("finishDetail",param);
        return "test/finishDetail";
    }
}
