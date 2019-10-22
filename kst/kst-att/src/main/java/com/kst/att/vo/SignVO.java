package com.kst.att.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.att.entity.Sign;

import java.util.Date;

public class SignVO extends Sign {
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm:ss", timezone = "GMT+8")
    private Date beginWork;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm:ss", timezone = "GMT+8")
    private Date endWork;
    /**
     * 出勤时间
     */
    private String turnTime;
    /**
     *标准休息时间
     */
    private String outTime;
    /**
     * 工作时间
     */
    private String workTime;
    /**
     * 显示周几
     */
    private String weekDay;

    /**
     * 日期说明
     * @return
     */
    private String dateExplain;

    public String getDateExplain() {
        return dateExplain;
    }

    public void setDateExplain(String dateExplain) {
        this.dateExplain = dateExplain;
    }

    public String getWeekDay() {
        return weekDay;
    }

    public void setWeekDay(String weekDay) {
        this.weekDay = weekDay;
    }

    public Date getBeginWork() {
        return beginWork;
    }

    public void setBeginWork(Date beginWork) {
        this.beginWork = beginWork;
    }

    public Date getEndWork() {
        return endWork;
    }

    public void setEndWork(Date endWork) {
        this.endWork = endWork;
    }

    public String getTurnTime() {
        return turnTime;
    }

    public void setTurnTime(String turnTime) {
        this.turnTime = turnTime;
    }

    public String getOutTime() {
        return outTime;
    }

    public void setOutTime(String outTime) {
        this.outTime = outTime;
    }

    public String getWorkTime() {
        return workTime;
    }

    public void setWorkTime(String workTime) {
        this.workTime = workTime;
    }
}
