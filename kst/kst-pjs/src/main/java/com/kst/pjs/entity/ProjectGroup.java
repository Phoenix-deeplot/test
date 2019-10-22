package com.kst.pjs.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.sys.api.entity.TreeEntity;

@TableName("pjs_project_group")
public class ProjectGroup extends TreeEntity<ProjectGroup> {

    /**
     * 项目编号
     */
    @TableField("pj_id")
    private Long pjId;

    /**
     * 用户id
     */
    @TableField("user_id")
    private Long userId;

    /**
     * 职位
     */
    @TableField("position")
    private String position;

    /**
     * 用户编号
     */
    @TableField(exist = false)
    private String nickName;


    public Long getPjId() {
        return pjId;
    }

    public void setPjId(Long pjId) {
        this.pjId = pjId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }


    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
}
