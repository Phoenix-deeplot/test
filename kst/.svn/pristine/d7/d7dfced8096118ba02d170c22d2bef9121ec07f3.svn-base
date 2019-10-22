package com.kst.pjs.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;

import java.util.Date;

@TableName("pjs_sch_history")
public class SchHistory extends DataEntity {

    /**
     * 项目id
     */
    @TableField("pj_id")
    private Long pjId;

    /**
     * 作业编号
     */
    @TableField("work_interior_no")
    private String workInteriorNo;

    /**
     * 进度登记日
     */
    @TableField("work_plan_from")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date workPlanFrom;

    /**
     * 进度记录者
     */
    @TableField("work_fact_user")
    private String workFactUser;

    /**
     * 实际工时
     */
    @TableField("work_fact_times")
    private Double workFactTimes;

    /**
     * 实际完成比率
     */
    @TableField("work_finish_per")
    private Double workFinishPer;

    /**
     * 补充说明
     */
    @TableField("work_memo")
    private String workMemo;


    public Long getPjId() {
        return pjId;
    }

    public void setPjId(Long pjId) {
        this.pjId = pjId;
    }

    public String getWorkInteriorNo() {
        return workInteriorNo;
    }

    public void setWorkInteriorNo(String workInteriorNo) {
        this.workInteriorNo = workInteriorNo;
    }

    public Date getWorkPlanFrom() {
        return workPlanFrom;
    }

    public void setWorkPlanFrom(Date workPlanFrom) {
        this.workPlanFrom = workPlanFrom;
    }

    public String getWorkFactUser() {
        return workFactUser;
    }

    public void setWorkFactUser(String workFactUser) {
        this.workFactUser = workFactUser;
    }

    public Double getWorkFactTimes() {
        return workFactTimes;
    }

    public void setWorkFactTimes(Double workFactTimes) {
        this.workFactTimes = workFactTimes;
    }

    public Double getWorkFinishPer() {
        return workFinishPer;
    }

    public void setWorkFinishPer(Double workFinishPer) {
        this.workFinishPer = workFinishPer;
    }

    public String getWorkMemo() {
        return workMemo;
    }

    public void setWorkMemo(String workMemo) {
        this.workMemo = workMemo;
    }

}
