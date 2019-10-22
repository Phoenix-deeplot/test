package com.kst.sys.api.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;
import com.kst.sys.api.vo.UserVO;

import java.util.Date;
import java.util.List;

@TableName("sys_question")
public class SysQuestion extends DataEntity<SysQuestion> {

    /**
     * 问题区分
     */
    @TableField("qus_flag")
    private String qusFlag;
    /**
     * 问题标题
     */
    @TableField("qus_title")
    private String qusTitle;
    /**
     * 问题内容
     */
    @TableField("qus_pushdetail")
    private String qusPushdetail;
    /**
     * 提出附件
     */
    @TableField("qus_pushattachlist")
    private String qusPushattachlist;
    /**
     * 问题提出日
     */
    @TableField("qus_pushdate")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date qusPushdate;
    /**
     * 问题提出者
     */
    @TableField("qus_pusher")
    private String qusPusher;

    @TableField("qusPushername")
    private String qusPushername;

    /**
     * 问题回答内容
     */
    @TableField("qus_requestdetail")
    private String qusRequestdetail;
    /**
     * 回答附件
     */
    @TableField("qus_requestattachlist")
    private String qusRequestattachlist;
    /**
     * 问题回答日
     */
    @TableField("qus_requestdate")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date qusRequestdate;
    /**
     * 问题回答者
     */
    @TableField("qus_requester")
    private String qusRequester;
    @TableField("qusRequestername")
    private String qusRequestername;
    /**
     * 问题状态
     */
    @TableField("qus_status")
    private String qusStatus;
    /**
     *状态名
     */
    @TableField("qusstatus")
    private String qusstatus;
    /**
     * 区分名
     */
    @TableField("qusflag")
    private String qusflag;
    /**
     *  提问附件对象
     */
    @TableField(exist = false)
    private List<Resource> attachs;

    /**
     *  回答附件对象
     */
    @TableField(exist = false)
    private List<Resource> attachsDa;
    /**
     * 指定者
     */
    @TableField("qus_designator")
    private String qusDesignator;
    /**
     * 是否公开
     */
    @TableField("qus_enable")
    private boolean qusEnable;
    /**
     * 可见用户集合
     */
    @TableField(exist = false)
    private List<UserVO> userLists;

    @TableField(exist = false)
    private String userIds;

    public boolean isQusEnable() {
        return qusEnable;
    }
    public void setQusEnable(boolean qusEnable) {
        this.qusEnable = qusEnable;
    }

    public String getQusDesignator() {
        return qusDesignator;
    }

    public void setQusDesignator(String qusDesignator) {
        this.qusDesignator = qusDesignator;
    }

    public List<Resource> getAttachsDa() {
        return attachsDa;
    }

    public void setAttachsDa(List<Resource> attachsDa) {
        this.attachsDa = attachsDa;
    }

    public String getQusFlag() {
        return qusFlag;
    }

    public void setQusFlag(String qusFlag) {
        this.qusFlag = qusFlag;
    }

    public String getQusTitle() {
        return qusTitle;
    }

    public void setQusTitle(String qusTitle) {
        this.qusTitle = qusTitle;
    }

    public String getQusPushdetail() {
        return qusPushdetail;
    }

    public void setQusPushdetail(String qusPushdetail) {
        this.qusPushdetail = qusPushdetail;
    }

    public String getQusPushattachlist() {
        return qusPushattachlist;
    }

    public void setQusPushattachlist(String qusPushattachlist) {
        this.qusPushattachlist = qusPushattachlist;
    }

    public Date getQusPushdate() {
        return qusPushdate;
    }

    public void setQusPushdate(Date qusPushdate) {
        this.qusPushdate = qusPushdate;
    }

    public String getQusPusher() {
        return qusPusher;
    }

    public void setQusPusher(String qusPusher) {
        this.qusPusher = qusPusher;
    }

    public String getQusRequestdetail() {
        return qusRequestdetail;
    }

    public void setQusRequestdetail(String qusRequestdetail) {
        this.qusRequestdetail = qusRequestdetail;
    }

    public String getQusRequestattachlist() {
        return qusRequestattachlist;
    }

    public void setQusRequestattachlist(String qusRequestattachlist) {
        this.qusRequestattachlist = qusRequestattachlist;
    }
    public List<Resource> getAttachs() {
        return attachs;
    }

    public void setAttachs(List<Resource> attachs) {
        this.attachs = attachs;
    }
    public Date getQusRequestdate() {
        return qusRequestdate;
    }

    public void setQusRequestdate(Date qusRequestdate) {
        this.qusRequestdate = qusRequestdate;
    }

    public String getQusRequester() {
        return qusRequester;
    }

    public void setQusRequester(String qusRequester) {
        this.qusRequester = qusRequester;
    }

    public String getQusStatus() {
        return qusStatus;
    }

    public void setQusStatus(String qusStatus) {
        this.qusStatus = qusStatus;
    }

    public String getQusstatus() {
        return qusstatus;
    }

    public void setQusstatus(String qusstatus) {
        this.qusstatus = qusstatus;
    }

    public String getQusflag() {
        return qusflag;
    }

    public void setQusflag(String qusflag) {
        this.qusflag = qusflag;
    }

    public String getQusPushername() {
        return qusPushername;
    }

    public void setQusPushername(String qusPushername) {
        this.qusPushername = qusPushername;
    }

    public String getQusRequestername() {
        return qusRequestername;
    }

    public void setQusRequestername(String qusRequestername) {
        this.qusRequestername = qusRequestername;
    }

    public List<UserVO> getUserLists() {
        return userLists;
    }

    public void setUserLists(List<UserVO> userLists) {
        this.userLists = userLists;
    }

    public String getUserIds() {
        return userIds;
    }

    public void setUserIds(String userIds) {
        this.userIds = userIds;
    }

    @Override
    public String getRemarks() {
        return remarks;
    }

    @Override
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
