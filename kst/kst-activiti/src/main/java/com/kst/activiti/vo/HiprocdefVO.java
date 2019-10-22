package com.kst.activiti.vo;


import com.kst.activiti.dto.ActHiProcinstDto;

public class HiprocdefVO extends ActHiProcinstDto {
    private String PNAME_;
    private String VERSION_;
    private String PID_;
    private String DEPLOYMENT_ID_;
    private String DGRM_RESOURCE_NAME_;
    private String ZTIME;
    private String INITATOR;

    public String getPNAME_() {
        return PNAME_;
    }

    public void setPNAME_(String PNAME_) {
        this.PNAME_ = PNAME_;
    }

    public String getVERSION_() {
        return VERSION_;
    }

    public void setVERSION_(String VERSION_) {
        this.VERSION_ = VERSION_;
    }

    public String getPID_() {
        return PID_;
    }

    public void setPID_(String PID_) {
        this.PID_ = PID_;
    }

    public String getDEPLOYMENT_ID_() {
        return DEPLOYMENT_ID_;
    }

    public void setDEPLOYMENT_ID_(String DEPLOYMENT_ID_) {
        this.DEPLOYMENT_ID_ = DEPLOYMENT_ID_;
    }

    public String getDGRM_RESOURCE_NAME_() {
        return DGRM_RESOURCE_NAME_;
    }

    public String getZTIME() {
        return ZTIME;
    }

    public void setZTIME(String ZTIME) {
        this.ZTIME = ZTIME;
    }

    public String getINITATOR() {
        return INITATOR;
    }

    public void setINITATOR(String INITATOR) {
        this.INITATOR = INITATOR;
    }

    public void setDGRM_RESOURCE_NAME_(String DGRM_RESOURCE_NAME_) {
        this.DGRM_RESOURCE_NAME_ = DGRM_RESOURCE_NAME_;
    }
}
