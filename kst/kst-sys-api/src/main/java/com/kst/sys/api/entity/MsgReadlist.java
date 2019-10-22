package com.kst.sys.api.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;

import java.util.Date;

@TableName("sys_msg_readlist")
public class MsgReadlist {

    protected Long id;

    /**
     * 消息编号
     */
    @TableField("msg_id")
    private Long msgId;

    /**
     * 用户编号
     */
    @TableField("user_id")
    private Long userId;

    /**
     * 消息读取时间
     */
    @TableField("msg_read_date")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date msgReadDate;

    @JsonSerialize(using= ToStringSerializer.class)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getMsgId() {
        return msgId;
    }

    public void setMsgId(Long msgId) {
        this.msgId = msgId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Date getMsgReadDate() {
        return msgReadDate;
    }

    public void setMsgReadDate(Date msgReadDate) {
        this.msgReadDate = msgReadDate;
    }
}
