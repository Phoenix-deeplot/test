package com.kst.sys.api.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.sys.api.entity.Daily;

import java.util.Date;

public class DailyVO extends Daily {
    /**
     * 项目名称
     */
    private String pjName;
    /**
     * 项目简称
     */
    private String pjNames;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm:ss", timezone = "GMT+8")
    private Date beginTime;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm:ss", timezone = "GMT+8")
    private Date endTime;
    /**
     * 显示周几
     */
    private String weekDay;

    /**
     * 月报日期
     * @return
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date monDate;
    /**
     * 日期说明
     */
    private String dateExplain;
    public String getDateExplain() {
        return dateExplain;
    }

    public void setDateExplain(String dateExplain) {
        this.dateExplain = dateExplain;
    }

    public Date getMonDate() {
        return monDate;
    }

    public void setMonDate(Date monDate) {
        this.monDate = monDate;
    }

    public String getWeekDay() {
        return weekDay;
    }

    public void setWeekDay(String weekDay) {
        this.weekDay = weekDay;
    }

    public String getPjName() {
        return pjName;
    }

    public void setPjName(String pjName) {
        this.pjName = pjName;
    }

    public String getPjNames() {
        return pjNames;
    }

    public void setPjNames(String pjNames) {
        this.pjNames = pjNames;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
}

