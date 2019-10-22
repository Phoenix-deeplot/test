package com.kst.activiti.vo;

import com.kst.activiti.dto.ActReProcdefDto;

import java.util.Date;

public class ProcdefVO extends ActReProcdefDto {
    private Date DEPLOY_TIME_;

    public Date getDEPLOY_TIME_() {
        return DEPLOY_TIME_;
    }

    public void setDEPLOY_TIME_(Date DEPLOY_TIME_) {
        this.DEPLOY_TIME_ = DEPLOY_TIME_;
    }
}
