package com.kst.isms.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.common.base.entity.DataEntity;

/**
 * 考试表
 *
 * @author lxm
 * @since 2017-10-31
 */
@TableName("isms_user_test")
public class UserTest extends DataEntity<UserTest> {

    /**
     * 考卷编号
     */
    @TableField("topic_id")
    private Long topicId;

    /**
     * 用户编号
     */
    @TableField("user_id")
    private Long userId;

    /**
     * 分数
     */
    @TableField("score")
    private Integer score;

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

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
}
