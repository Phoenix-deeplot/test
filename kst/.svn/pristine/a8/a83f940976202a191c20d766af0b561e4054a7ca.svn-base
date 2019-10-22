package com.kst.pjs.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.BaseEntity;
import com.kst.common.base.entity.DataEntity;
import com.kst.sys.api.entity.User;
import org.omg.CORBA.StringHolder;

import java.util.Date;
import java.util.List;

@TableName("pjs_sch_detail")
public class SchDetail extends DataEntity<SchDetail> {

    @TableField("pj_id")
    private Long pjId;

    @TableField(exist = false)
    private String pjName;

    @TableField("work_b_kind_id")
    private String workBKindId;

    @TableField(exist = false)
    private String workBKindName;

    @TableField("work_m_kind_id")
    private String workMKindId;

    @TableField(exist = false)
    private String workMKindName;

    @TableField("work_s_kind_id")
    private String workSKindId;

    @TableField(exist = false)
    private String workSKindName;

    @TableField("interior_no")
    private String interiorNo;

    @TableField("work_no")
    private String workNo;

    @TableField("work_name")
    private String workName;

    @TableField("work_plan_from")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date workPlanFrom;

    @TableField("work_plan_to")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date workPlanTo;

    @TableField("work_plan_user")
    private String workPlanUser;

    @TableField(exist = false)
    private String workPlanUserName;

    @TableField("work_plan_times")
    private Double workPlanTimes=0.0;

    @TableField("work_fact_from")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date workFactFrom;

    @TableField("work_fact_to")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date workFactTo;

    @TableField("work_fact_user")
    private String workFactUser;

    @TableField(exist = false)
    private String workFactUserName;

    @TableField("work_fact_times")
    private Double workFactTimes=0.0;

    @TableField("work_finish_per")
    private Double workFinishPer=0.0;

    @TableField("plan_and_fact_rate")
    private Double planAndFactRate=0.0;

    @TableField("plan_and_fact_diff")
    private Double planAndFactDiff=0.0;

    /**
     * 工作相关组
     */
    @TableField("work_group")
    private Long workGroup;

    @TableField("work_type")
    private String workType;

    @TableField("work_memo")
    private String workMemo;

    @TableField(exist = false)
    private String users;

    @TableField(exist = false)
    private Double todayTime;

    /**
     * 项目id
     */
    public Long getPjId() {
        return pjId;
    }

    public void setPjId(Long pjId) {
        this.pjId = pjId;
    }

    /**
     * 项目名
     */
    public String getPjName() {
        return pjName;
    }

    public void setPjName(String pjName) {
        this.pjName = pjName;
    }

    /**
     * 作业大分类
     */
    public String getWorkBKindId() {
        return workBKindId;
    }

    public void setWorkBKindId(String workBKindId) {
        this.workBKindId = workBKindId;
    }

    public String getWorkBKindName() {
        return workBKindName;
    }

    public void setWorkBKindName(String workBKindName) {
        this.workBKindName = workBKindName;
    }

    /**
     * 作业中分类
     */
    public String getWorkMKindId() {
        return workMKindId;
    }

    public void setWorkMKindId(String workMKindId) {
        this.workMKindId = workMKindId;
    }

    public String getWorkMKindName() {
        return workMKindName;
    }

    public void setWorkMKindName(String workMKindName) {
        this.workMKindName = workMKindName;
    }

    /**
     * 作业小分类
     */
    public String getWorkSKindId() {
        return workSKindId;
    }

    public void setWorkSKindId(String workSKindId) {
        this.workSKindId = workSKindId;
    }

    public String getWorkSKindName() {
        return workSKindName;
    }

    public void setWorkSKindName(String workSKindName) {
        this.workSKindName = workSKindName;
    }

    public String getInteriorNo() {
        return interiorNo;
    }

    public void setInteriorNo(String interiorNo) {
        this.interiorNo = interiorNo;
    }

    /**
     * 作业编号
     */
    public String getWorkNo() {
        return workNo;
    }

    public void setWorkNo(String workNo) {
        this.workNo = workNo;
    }

    /**
     * 作业名称
     */
    public String getWorkName() {
        return workName;
    }

    public void setWorkName(String workName) {
        this.workName = workName;
    }

    /**
     * 预定开始日
     */
    public Date getWorkPlanFrom() {
        return workPlanFrom;
    }

    public void setWorkPlanFrom(Date workPlanFrom) {
        this.workPlanFrom = workPlanFrom;
    }

    /**
     * 预定结束日
     */
    public Date getWorkPlanTo() {
        return workPlanTo;
    }

    public void setWorkPlanTo(Date workPlanTo) {
        this.workPlanTo = workPlanTo;
    }

    /**
     * 预定担当者
     */
    public String getWorkPlanUser() {
        return workPlanUser;
    }

    public void setWorkPlanUser(String workPlanUser) {
        this.workPlanUser = workPlanUser;
    }

    /**
     * 预定担当者名
     */
    public String getWorkPlanUserName() {
        return workPlanUserName;
    }

    public void setWorkPlanUserName(String workPlanUserName) {
        this.workPlanUserName = workPlanUserName;
    }

    /**
     * 预定工时
     */
    public Double getWorkPlanTimes() {
        return workPlanTimes;
    }

    public void setWorkPlanTimes(Double workPlanTimes) {
        this.workPlanTimes = workPlanTimes;
    }

    /**
     * 实际开始日
     */
    public Date getWorkFactFrom() {
        return workFactFrom;
    }

    public void setWorkFactFrom(Date workFactFrom) {
        this.workFactFrom = workFactFrom;
    }

    /**
     * 实际结束日
     */
    public Date getWorkFactTo() {
        return workFactTo;
    }

    public void setWorkFactTo(Date workFactTo) {
        this.workFactTo = workFactTo;
    }

    /**
     * 实际担当者
     */
    public String getWorkFactUser() {
        return workFactUser;
    }

    public void setWorkFactUser(String workFactUser) {
        this.workFactUser = workFactUser;
    }

    /**
     * 实际担当者名
     */
    public String getWorkFactUserName() {
        return workFactUserName;
    }

    public void setWorkFactUserName(String workFactUserName) {
        this.workFactUserName = workFactUserName;
    }

    /**
     * 实际工时
     */
    public Double getWorkFactTimes() {
        return workFactTimes;
    }

    public void setWorkFactTimes(Double workFactTimes) {
        this.workFactTimes = workFactTimes;
    }

    /**
     * 实际完成比率
     */
    public Double getWorkFinishPer() {
        return workFinishPer;
    }

    public void setWorkFinishPer(Double workFinishPer) {
        this.workFinishPer = workFinishPer;
    }

    /**
     * 实际&预定差率
     */
    public Double getPlanAndFactRate() {
        return planAndFactRate;
    }

    public void setPlanAndFactRate(Double planAndFactRate) {
        this.planAndFactRate = planAndFactRate;
    }

    /**
     * 实际&预定差额
     */
    public Double getPlanAndFactDiff() {
        return planAndFactDiff;
    }

    public void setPlanAndFactDiff(Double planAndFactDiff) {
        this.planAndFactDiff = planAndFactDiff;
    }

    public Long getWorkGroup() {
        return workGroup;
    }

    public void setWorkGroup(Long workGroup) {
        this.workGroup = workGroup;
    }

    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    public String getWorkMemo() {
        return workMemo;
    }

    public void setWorkMemo(String workMemo) {
        this.workMemo = workMemo;
    }

    public String getUsers() {
        return users;
    }

    public void setUsers(String users) {
        this.users = users;
    }

    public Double getTodayTime() { return todayTime; }

    public void setTodayTime(Double todayTime) { this.todayTime = todayTime; }
}
