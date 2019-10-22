package com.kst.pjs.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;

import java.util.Date;

@TableName("pjs_pjfactinfo")
public class PjFactInfo extends DataEntity {

    /**
     * 项目Id
     */
    @TableField("pj_id")
    private Long pjId;

    /**
     * 实际开始日(画面输入)
     */
    @TableField("pj_fact_from")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date factFrom;

    /**
     * 实际结束日(画面输入)
     */
    @TableField("pj_fact_to")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date factTo;

    /**
     * 实际工时总数(画面输入)
     */
    @TableField("pj_fact_time_all")
    private Double factTimeAll;

    /**
     *实际开始日(终了自动填入)
     */
    @TableField("pj_fact_from_a")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date factFromA;

    /**
     * 实际结束日(终了自动填入)
     */
    @TableField("pj_fact_to_a")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date factToA;

    /**
     * 实际工时总数(终了自动填入)
     */
    @TableField("pj_fact_time_all_a")
    private Double factTimeAllA;

    /**
     * 用户组id
     */
    @TableField("pj_user_group_id")
    private Long userGroupId;

    /**
     * 进度记录标准
     */
    @TableField("pj_per_memo")
    private String perMemo;

    /**
     * 补充说明
     */
    @TableField("pj_memo")
    private String memo;

    /**
     * 状态属性
     */
    @TableField("pj_status")
    private String status;


    public Long getPjId() {
        return pjId;
    }

    public void setPjId(Long pjId) {
        this.pjId = pjId;
    }

    public Date getFactFrom() {
        return factFrom;
    }

    public void setFactFrom(Date factFrom) {
        this.factFrom = factFrom;
    }

    public Date getFactTo() {
        return factTo;
    }

    public void setFactTo(Date factTo) {
        this.factTo = factTo;
    }

    public Double getFactTimeAll() {
        return factTimeAll;
    }

    public void setFactTimeAll(Double factTimeAll) {
        this.factTimeAll = factTimeAll;
    }

    public Date getFactFromA() {
        return factFromA;
    }

    public void setFactFromA(Date factFromA) {
        this.factFromA = factFromA;
    }

    public Date getFactToA() {
        return factToA;
    }

    public void setFactToA(Date factToA) {
        this.factToA = factToA;
    }

    public Double getFactTimeAllA() {
        return factTimeAllA;
    }

    public void setFactTimeAllA(Double factTimeAllA) {
        this.factTimeAllA = factTimeAllA;
    }

    public Long getUserGroupId() {
        return userGroupId;
    }

    public void setUserGroupId(Long userGroupId) {
        this.userGroupId = userGroupId;
    }

    public String getPerMemo() {
        return perMemo;
    }

    public void setPerMemo(String perMemo) {
        this.perMemo = perMemo;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
