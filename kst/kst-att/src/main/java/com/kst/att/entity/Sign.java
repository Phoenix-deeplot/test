package com.kst.att.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;

import java.util.Date;

@TableName("att_sign")
public class Sign extends DataEntity<Sign> {
    /**
     * 打卡人
     */
    @TableField("att_userid")
    private String attUserid;
    /**
     * 打卡日时
     */
    @TableField("att_signtime")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date attSigntime;
    /**
     * 打卡标识区分
     */
    @TableField("att_flag")
    private String attFlag;
    /**
     * 打卡地点
     */
    @TableField("att_locname")
    private String attLocname;
    /**
     * 纬度
     */
    @TableField("att_latitude")
    private Double attLatitude;
    /**
     * 经度
     */
    @TableField("att_longitude")
    private Double attLongitude;

    public String getAttUserid() {
        return attUserid;
    }

    public void setAttUserid(String attUserid) {
        this.attUserid = attUserid;
    }

    public Date getAttSigntime() {
        return attSigntime;
    }

    public void setAttSigntime(Date attSigntime) {
        this.attSigntime = attSigntime;
    }

    public String getAttFlag() {
        return attFlag;
    }

    public void setAttFlag(String attFlag) {
        this.attFlag = attFlag;
    }

    public String getAttLocname() {
        return attLocname;
    }

    public void setAttLocname(String attLocname) {
        this.attLocname = attLocname;
    }

    public Double getAttLatitude() {
        return attLatitude;
    }

    public void setAttLatitude(Double attLatitude) {
        this.attLatitude = attLatitude;
    }

    public Double getAttLongitude() {
        return attLongitude;
    }

    public void setAttLongitude(Double attLongitude) {
        this.attLongitude = attLongitude;
    }
}
