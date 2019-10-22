package com.kst.pjs.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;

import java.util.Date;

@TableName("pjs_project_history")
public class ProjectHistory extends DataEntity<ProjectHistory> {

    /**
     * 项目编号
     */
    @TableField("pj_id")
    private Long pjId;

    /**
     * 统计日期
     */
    @TableField("date")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date date;

    /**
     * 统计区分
     */
    @TableField("type")
    private String type;

    /**
     * 预定完成日数
     */
    @TableField("plan_finish_day")
    private Double planFinishDay=0.0;

    /**
     * 实际完成日数
     */
    @TableField("fact_finish_day")
    private Double factFinishDay=0.0;

    /**
     * 预定完成比例
     */
    @TableField("plan_finish_rate")
    private Double planFinishRate=0.0;

    /**
     * 实际完成比例
     */
    @TableField("fact_finish_rate")
    private Double factFinishRate=0.0;

    /**
     * 预定实际日数偏差值
     */
    @TableField("day_deviation_value")
    private Double dayDeviationValue=0.0;

    public Long getPjId() {
        return pjId;
    }

    public void setPjId(Long pjId) {
        this.pjId = pjId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Double getPlanFinishDay() {
        return planFinishDay;
    }

    public void setPlanFinishDay(Double planFinishDay) {
        this.planFinishDay = planFinishDay;
    }

    public Double getFactFinishDay() {
        return factFinishDay;
    }

    public void setFactFinishDay(Double factFinishDay) {
        this.factFinishDay = factFinishDay;
    }

    public Double getPlanFinishRate() {
        return planFinishRate;
    }

    public void setPlanFinishRate(Double planFinishRate) {
        this.planFinishRate = planFinishRate;
    }

    public Double getFactFinishRate() {
        return factFinishRate;
    }

    public void setFactFinishRate(Double factFinishRate) {
        this.factFinishRate = factFinishRate;
    }

    public Double getDayDeviationValue() {
        return dayDeviationValue;
    }

    public void setDayDeviationValue(Double dayDeviationValue) {
        this.dayDeviationValue = dayDeviationValue;
    }

}
