package com.kst.isms.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.common.base.entity.DataEntity;

/**
 * 选项表
 *
 * @author lxm
 * @since 2017-10-31
 */
@TableName("isms_question_item")
public class QuestionItem extends DataEntity<QuestionItem> {

    private static final long serialVersionUID = 1L;

    /**
     * 所属考题id
     */
    @TableField("question_id")
    private Long questionId;

    /**
     * 选项名称
     */
    @TableField("name")
    private String name;

    /**
     * 选项
     */
    @TableField("value")
    private String value;

    /**
     * 排序
     */
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
