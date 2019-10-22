package com.kst.isms.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.vo.DataTable;
import com.kst.common.shiro.MySysUser;
import com.kst.common.utils.RestResponse;
import com.kst.isms.entity.*;
import com.kst.isms.service.IQuestionService;
import com.kst.isms.service.ITopicService;
import com.kst.isms.service.IUserAnswerService;
import com.kst.isms.service.IUserTestService;
import com.kst.isms.vo.QuestionVO;
import com.kst.log.annotation.SysLog;
import com.kst.sys.api.entity.Dict;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.service.IDictService;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("isms/exam")
public class ExamController {

    @Autowired
    private ITopicService topicService;

    @Autowired
    private IDictService dictService;

    @Autowired
    private IQuestionService questionService;

    @Autowired
    private IUserTestService userTestService;

    @Autowired
    private IUserAnswerService userAnswerService;

    @GetMapping("list")
    @RequiresPermissions("isms:exam:list")
    //@SysLog("跳转系统用户列表页面")
    public String list(Model model) {
        Map<String, Object> params = new HashMap<>();

        QueryWrapper<Dict> wrapper2 = new QueryWrapper<>();
        wrapper2.eq("type", "isms_test_type");
        wrapper2.eq("del_flag", false);
        List<Dict> types = this.dictService.list(wrapper2);
        params.put("testTypeList", types);

        model.addAttribute("examParams", params);
        return "exam/list";
    }

    @PostMapping("list")
    @ResponseBody
    public DataTable<Topic> topicList(@RequestBody DataTable dt, HttpServletRequest request) {
        DataTable<Topic> list = this.topicService.selectTopicPage(dt);
        for (Topic t : list.getRows()) {
            UserTest test = this.userTestService.selectHistoryTest(((User) request.getAttribute("currentUser")).getId(), t.getId());
            if (test == null) {
                t.setFirstFlag(true);
            } else {
                t.setFirstFlag(false);
                t.setLastScore(test.getScore());
            }
        }
        return list;
    }

    @GetMapping("doExam/{id}")
    //加载考卷题目
    public String doExam(@PathVariable("id") Long id, Model model, HttpServletRequest request) {
        Map<String, Object> params = new HashMap<>();
        Topic topic = this.topicService.getById(id);
        Long userId = MySysUser.id();

        QueryWrapper<Dict> dictQueryWrapper2 = new QueryWrapper<>();
        dictQueryWrapper2.eq("type", "isms_question_type");
        dictQueryWrapper2.eq("del_flag", false);
        List<Dict> questionTypeList = this.dictService.list(dictQueryWrapper2);

        Map<String, Object> param = new HashMap<>();
        UserTest test = this.userTestService.selectHistoryTest(userId, topic.getId());

        if (test != null) {
            QueryWrapper<UserAnswer> wrapper = new QueryWrapper<>();
            wrapper.eq("test_id", test.getId());
            wrapper.eq("incorrect_flag", false);
            //获取上次考试的错误答案
            List<UserAnswer> answers = this.userAnswerService.list(wrapper);
            List<Long> ids = new ArrayList<>();
            for (UserAnswer answer : answers) {
                ids.add(answer.getQuestionId());
            }
            if (ids.size() > 0) {
                param.put("ids", ids);
                topic.setFirstFlag(false);
                List<QuestionVO> list = this.questionService.selectQuestionByTopicId(param);
                params.put("questions", list);
            } else {
                //考试完成的情况下获取考过的题目
                List<QuestionVO> list = new ArrayList<>();
                if (topic.getAutomationFlag()) {
                    Map<String, Object> autoParam = new HashMap<>();
                    autoParam.put("userId", userId);
                    autoParam.put("topicId", topic.getId());
                    list = this.questionService.selectAutoQuestions(autoParam);
                } else {
                    param.put("topicId", id);
                    list = this.questionService.selectQuestionByTopicId(param);
                }
                params.put("finishQuestions", list);
                params.put("questions", new ArrayList<>());
            }
        } else {
            if (topic.getAutomationFlag() == true) {
                param.put("ids", getRandomQuestion(topic));
                List<QuestionVO> list = this.questionService.selectQuestionByTopicId(param);
                params.put("questions", list);
            } else {
                param.put("topicId", id);
                List<QuestionVO> list = this.questionService.selectQuestionByTopicId(param);
                params.put("questions", list);
            }
            topic.setFirstFlag(true);
        }


        params.put("topic", topic);
        params.put("questionTypeList", questionTypeList);
        model.addAttribute("examParams", params);
        return "exam/detail";
    }

    public List<Long> getRandomQuestion(Topic topic) {
        String[] types = topic.getQuestionTypes().split(",");
        String[] amount = topic.getQuestionAmounts().split(",");

        List<Long> ids = new ArrayList<>();
        for (int i = 0; i < types.length; i++) {
            List<Long> id = this.questionService.selectIds(Long.parseLong(types[i]));
            Collections.shuffle(id);
            List<Long> temp = new ArrayList<>();
            for (int j = 0; j < id.size(); j++) {
                if (temp.size() < Integer.parseInt(amount[i])) {
                    temp.add(id.get(j));
                }
            }
            ids.addAll(temp);
        }
        return ids;
    }

    @PostMapping("submitExam")
    @ResponseBody
    public RestResponse submitExam(String userTest, String answers, String examQuestions) {
        try{
            //这次考试答案
            String[] answer = answers.split(":");
            //用户考试
            UserTest test = (UserTest) JSONObject.toBean(JSONObject.fromObject(userTest), UserTest.class);
            //上一次考试
            UserTest t = this.userTestService.selectHistoryTest(test.getUserId(), test.getTopicId());
            //考卷
            Topic topic = this.topicService.getById(test.getTopicId());

            List<UserAnswer> answers2 = new ArrayList<>();
            JSONArray jsonArray = JSONArray.fromObject(examQuestions);
            //分数
            String[] scores = topic.getQuestionScores().split(",");
            //考卷考题类型
            String[] types = topic.getQuestionTypes().split(",");
            //这次考题分数
            Integer score = 0;
            if (t != null) {
                score = t.getScore();
            }
            for (int i = 0; i < answer.length; i++) {
                Question question = (Question) JSONObject.toBean(JSONObject.fromObject(jsonArray.get(i)), Question.class);
                UserAnswer userAnswer = new UserAnswer();
                userAnswer.setAnswerDate(new Date());
                userAnswer.setQuestionId(question.getId());
                userAnswer.setTopicId(topic.getId());
                userAnswer.setUserId(MySysUser.id());
                userAnswer.setAnswer(answer[i]);
                if (answer[i].equals(question.getAnswer())) {

                    for (int a = 0; a < types.length; a++) {
                        if (question.getType().toString().equals(types[a])) {
                            score += Integer.parseInt(scores[a]);
                        }
                    }
                    userAnswer.setIncorrectFlag(true);
                } else {
                    userAnswer.setIncorrectFlag(false);
                }
                answers2.add(userAnswer);
            }
            test.setScore(score);
            if (!this.userTestService.save(test)) {
                return RestResponse.failure("fail");
            }

            for (UserAnswer an : answers2) {
                an.setTestId(test.getId());
                if (!this.userAnswerService.save(an)) {
                    return RestResponse.failure("fail");
                }
            }
        }catch (Exception e){
            return RestResponse.failure("fail");
        }

        return RestResponse.success();
    }
}
