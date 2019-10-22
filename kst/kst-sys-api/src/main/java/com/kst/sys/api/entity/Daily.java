package com.kst.sys.api.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;

import java.util.Date;

@TableName("sys_daily")
public class Daily extends DataEntity<Daily> {

    /**
     * 日报用户id
     */
    @TableField("daily_user_id")
    private Long userId;

    /**
     * 用户名
     */
    @TableField(exist = false)
    private String userName;

    /**
     * 日报日期
     */
    @TableField("daily_date")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date date;

    /**
     * 项目id
     */
    @TableField("daily_project_id")
    private Long projectId;

    /**
     * 日报内容
     */
    @TableField("daily_content")
    private String content;

    /**
     * 区分
     */
    @TableField("daily_type")
    private String type;

    @TableField("daily_work_times")
    private Double workTimes;

    /**
     * 当日所有用户id
     */
    @TableField("daily_user_ids")
    private String userIds;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Long getProjectId() {
        return projectId;
    }

    public void setProjectId(Long projectId) {
        this.projectId = projectId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Double getWorkTimes() { return workTimes; }

    public void setWorkTimes(Double workTimes) { this.workTimes = workTimes; }

    public String getUserIds() {
        return userIds;
    }

    public void setUserIds(String userIds) {
        this.userIds = userIds;
    }

}
