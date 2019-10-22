package com.kst.pjs.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.pjs.entity.PjMain;

import java.util.Date;

public class PjMainVO extends PjMain {

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date factFrom;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date factTo;

    private Double factTimeAll;

    private String status;


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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
