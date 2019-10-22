package com.kst.isms.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * 考试答案表
 *
 * @author lxm
 * @since 2017-10-31
 */
@TableName("isms_user_answer")
public class UserAnswer {

    /**
     * 考试编号
     */
    @TableId("test_id")
    private Long testId;

    /**
     * 考卷编号
     */
    @TableId("topic_id")
    private Long topicId;

    /**
     * 用户编号
     */
    @TableId("user_id")
    private Long userId;

    /**
     * 考题编号
     */
    @TableId("question_id")
    private Long questionId;

    /**
     * 答案
     */
    @TableField("answer")
    private String answer;

    /**
     * 回答日期
     */
    @TableField(value="answer_date", fill = FieldFill.INSERT)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date answerDate;

    /**
     * 错误标识
     */
    @TableField("incorrect_flag")
    private Boolean incorrectFlag;

    public Long getTestId() {
        return testId;
    }

    public void setTestId(Long testId) {
        this.testId = testId;
    }

    public Long getTopicId() {
        return topicId;
    }

    public void setTopicId(Long topicId) {
        this.topicId = topicId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Long questionId) {
        this.questionId = questionId;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Date getAnswerDate() {
        return answerDate;
    }

    public void setAnswerDate(Date answerDate) {
        this.answerDate = answerDate;
    }

    public Boolean getIncorrectFlag() {
        return incorrectFlag;
    }

    public void setIncorrectFlag(Boolean incorrectFlag) {
        this.incorrectFlag = incorrectFlag;
    }
}
