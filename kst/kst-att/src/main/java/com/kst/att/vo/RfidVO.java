package com.kst.att.vo;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.kst.sys.api.entity.Rfid;

public class RfidVO extends Rfid {

    @JsonSerialize(using= ToStringSerializer.class)
    private Long attRfidId;


    public Long getAttRfidId() {
        return attRfidId;
    }

    public void setAttRfidId(Long attRfidId) {
        this.attRfidId = attRfidId;
    }
}
