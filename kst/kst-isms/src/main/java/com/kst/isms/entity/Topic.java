package com.kst.isms.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;

import java.util.Date;

/**
 * 考卷表
 *
 * @author lxm
 * @since 2017-10-31
 */
@TableName("isms_topic")
public class Topic extends DataEntity<Topic> {

    /**
     * 考卷名称
     */
    @TableField("name")
    private String name;

    /**
     * 考卷类型
     */
    @TableField("type")
    private Integer type;

    /**
     * 考卷状态
     */
    @TableField("status")
    private Integer status;

    /**
     * 考题类型
     */
    @TableField("question_types")
    private String questionTypes;

    /**
     * 考题分数
     */
    @TableField("question_scores")
    private String questionScores;

    /**
     * 考题已选数量
     */
    @TableField("question_counts")
    private String questionCounts;

    /**
     * 考题总数
     */
    @TableField("question_amounts")
    private String questionAmounts;

    /**
     *合格分数
     */
    @TableField("qualified_score")
    private Integer qualifiedScore;

    /**
     *公开日期
     */
    @TableField("release_date")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date releaseDate;

    /**
     * 自动生成考题flag
     */
    @TableField("automation_flag")
    private Boolean automationFlag;

    @TableField(exist = false)
    private Boolean firstFlag;

    @TableField(exist = false)
    private Integer lastScore;

    @TableField(exist = false)
    private String finishDegree;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getQuestionTypes() {
        return questionTypes;
    }

    public void setQuestionTypes(String questionTypes) {
        this.questionTypes = questionTypes;
    }

    public String getQuestionScores() {
        return questionScores;
    }

    public void setQuestionScores(String questionScores) {
        this.questionScores = questionScores;
    }

    public String getQuestionCounts() {
        return questionCounts;
    }

    public void setQuestionCounts(String questionCounts) {
        this.questionCounts = questionCounts;
    }

    public String getQuestionAmounts() {
        return questionAmounts;
    }

    public void setQuestionAmounts(String questionAmounts) {
        this.questionAmounts = questionAmounts;
    }

    public Integer getQualifiedScore() {
        return qualifiedScore;
    }

    public void setQualifiedScore(Integer qualifiedScore) {
        this.qualifiedScore = qualifiedScore;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public Boolean getAutomationFlag() {
        return automationFlag;
    }

    public void setAutomationFlag(Boolean automationFlag) {
        this.automationFlag = automationFlag;
    }

    public Boolean getFirstFlag() {
        return firstFlag;
    }

    public void setFirstFlag(Boolean firstFlag) {
        this.firstFlag = firstFlag;
    }

    public Integer getLastScore() {
        return lastScore;
    }

    public void setLastScore(Integer lastScore) {
        this.lastScore = lastScore;
    }


    public String getFinishDegree() {
        return finishDegree;
    }

    public void setFinishDegree(String finishDegree) {
        this.finishDegree = finishDegree;
    }
}
