package com.kst.isms.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.common.base.entity.DataEntity;

import java.io.Serializable;
import java.util.List;

/**
 * 考题表
 *
 * @author lxm
 * @since 2017-10-31
 */
@TableName("isms_question")
public class Question extends DataEntity<Question> {

    private static final long serialVersionUID = 1L;

    /**
     * 考题名称
     */
    @TableField("name")
    private String name;

    /**
     * 考题分类
     */
    @TableField("category")
    private Long category;

    /**
     * 考题类型
     */
    @TableField("type")
    private Integer type;

    /**
     * 正确答案
     */
    @TableField("answer")
    private String answer;

    /**
     * 排序
     */
    @TableField("sort")
    private Integer sort;

    /**
     * 是否显示
     */
    @TableField("show_flag")
    private Integer showFlag;

    /**
     * 选项
     */
    @TableField(exist = false)
    private List<QuestionItem> questionItems;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getCategory() {
        return category;
    }

    public void setCategory(Long category) {
        this.category = category;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getShowFlag() {
        return showFlag;
    }

    public void setShowFlag(Integer showFlag) {
        this.showFlag = showFlag;
    }

    public List<QuestionItem> getQuestionItems() {
        return questionItems;
    }

    public void setQuestionItems(List<QuestionItem> questionItems) {
        this.questionItems = questionItems;
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

    @Override
    public String toString() {
        return "Question{" +
                ", name=" + name +
                ", category=" + category +
                ", type=" + type +
                ", answer=" + answer +
                ", sort=" + sort +
                ", showFlag=" + showFlag +
                "}";
    }
}
