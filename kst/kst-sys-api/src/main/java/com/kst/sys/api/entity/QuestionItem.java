package com.kst.sys.api.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.common.base.entity.DataEntity;

@TableName("isms_question_item")
public class QuestionItem extends DataEntity<QuestionItem> {

    @TableField("question_id")
    private Long questionId;

    @TableField("name")
    private String name;

    @TableField("value")
    private String value;

    @TableField("sort")
    private Integer sort;




    public Long getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Long questionId) {
        this.questionId = questionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

}
