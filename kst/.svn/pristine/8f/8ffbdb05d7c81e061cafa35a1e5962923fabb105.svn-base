package com.kst.att.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;

@TableName("att_rfid")
public class AttRfid{

    @TableField("id")
    @TableId(type= IdType.ID_WORKER)
    @JsonSerialize(using=ToStringSerializer.class)
    private Long id;

    @TableField("rfid_id")
    @JsonSerialize(using= ToStringSerializer.class)
    private Long rfidId;

    @TableField("del_flag")
    private Boolean delFlag;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getRfidId() {
        return rfidId;
    }

    public void setRfidId(Long rfidId) {
        this.rfidId = rfidId;
    }

    public Boolean getDelFlag() { return delFlag; }

    public void setDelFlag(Boolean delFlag) { this.delFlag = delFlag; }

}
