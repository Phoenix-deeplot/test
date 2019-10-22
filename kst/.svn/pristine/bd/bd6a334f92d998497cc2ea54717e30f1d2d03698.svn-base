package com.kst.sys.api.entity;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;
import com.kst.sys.api.vo.UserVO;

import java.util.Date;
import java.util.List;

@TableName("sys_msg")
public class Msg extends DataEntity<Msg> {

    /**
     * 消息级别
     */
    @TableField("msg_level")
    private String level;

    /**
     * 消息级别名称
     */
    @TableField(exist = false)
    private String levelLabel;

    /**
     * 消息标题
     */
    @TableField("msg_title")
    private String title;

    /**
     * 消息内容
     */
    @TableField("msg_detail")
    private String detail;

    /**
     * 附件
     */
    @TableField("msg_attachlist")
    private String attachlist;

    /**
     * 推送开始日期
     */
    @TableField(value="msg_showfrom",strategy = FieldStrategy.IGNORED)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date showFrom;

    /**
     * 推送结束日期
     */
    @TableField(value="msg_showto",strategy = FieldStrategy.IGNORED)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date showTo;

    /**
     * 推送类型
     */
    @TableField("msg_pushType")
    private String pushType;

    /**
     * 推送类型名称
     */
    @TableField(exist = false)
    private String pushTypeLabel;

    /**
     * 推送时间
     */
    @TableField("msg_pushdate")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date pushDate;

    /**
     * 消息路径
     */
    @TableField("msg_url")
    private String url;

    /**
     * 消息读取时间
     */
    @TableField(exist = false)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date msgReadDate;

    /**
     *  附件对象
     */
    @TableField(exist = false)
    private List<Resource> attachs;

    /**
     * 可见用户集合
     */
    @TableField(exist = false)
    private List<UserVO> userLists;

    @TableField(exist = false)
    private String userIds;

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getLevelLabel() {
        return levelLabel;
    }

    public void setLevelLabel(String levelLabel) {
        this.levelLabel = levelLabel;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getAttachlist() {
        return attachlist;
    }

    public void setAttachlist(String attachlist) {
        this.attachlist = attachlist;
    }

    public Date getShowFrom() {
        return showFrom;
    }

    public void setShowFrom(Date showFrom) {
        this.showFrom = showFrom;
    }

    public Date getShowTo() {
        return showTo;
    }

    public void setShowTo(Date showTo) {
        this.showTo = showTo;
    }

    public String getPushType() {
        return pushType;
    }

    public void setPushType(String pushType) {
        this.pushType = pushType;
    }

    public String getPushTypeLabel() {
        return pushTypeLabel;
    }

    public void setPushTypeLabel(String pushTypeLabel) {
        this.pushTypeLabel = pushTypeLabel;
    }

    public Date getPushDate() {
        return pushDate;
    }

    public void setPushDate(Date pushDate) {
        this.pushDate = pushDate;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public List<Resource> getAttachs() {
        return attachs;
    }

    public void setAttachs(List<Resource> attachs) {
        this.attachs = attachs;
    }

    public List<UserVO> getUserLists() {
        return userLists;
    }

    public void setUserLists(List<UserVO> userLists) {
        this.userLists = userLists;
    }

    public Date getMsgReadDate() {
        return msgReadDate;
    }

    public void setMsgReadDate(Date msgReadDate) {
        this.msgReadDate = msgReadDate;
    }

    public String getUserIds() { return userIds; }

    public void setUserIds(String userIds) { this.userIds = userIds; }
}
