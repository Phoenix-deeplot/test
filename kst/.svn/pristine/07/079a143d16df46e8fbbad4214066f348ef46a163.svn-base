package com.kst.pjs.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;
import com.baomidou.mybatisplus.annotation.TableName;

import java.util.Date;

@TableName("pjs_pjmain")
public class PjMain extends DataEntity {

    /**
     * 公司编号
     */
    @TableField("pj_company_no")
    private String companyNo;

    /**
     * 项目名称
     */
    @TableField("pj_name")
    private String name;

    /**
     * 项目略称
     */
    @TableField("pj_name_s")
    private String nameS;

    /**
     * 预定开始日
     */
    @TableField("pj_plan_from")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date planFrom;

    /**
     * 预定结束日
     */
    @TableField("pj_plan_to")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date planTo;

    /**
     * 预定工时
     */
    @TableField("pj_plan_time_all")
    private Double planTimeAll=0.0;

    @TableField("pj_organization_id")
    private Long organizationId;

    @TableField(exist = false)
    private String organizationName;

    /**
     * 补充说明
     */
    @TableField("pj_memo")
    private String memo;

    public String getCompanyNo() {
        return companyNo;
    }

    public void setCompanyNo(String companyNo) {
        this.companyNo = companyNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNameS() {
        return nameS;
    }

    public void setNameS(String nameS) {
        this.nameS = nameS;
    }

    public Date getPlanFrom() {
        return planFrom;
    }

    public void setPlanFrom(Date planFrom) {
        this.planFrom = planFrom;
    }

    public Date getPlanTo() {
        return planTo;
    }

    public void setPlanTo(Date planTo) {
        this.planTo = planTo;
    }

    public Double getPlanTimeAll() {
        return planTimeAll;
    }

    public void setPlanTimeAll(Double planTimeAll) {
        this.planTimeAll = planTimeAll;
    }

    public Long getOrganizationId() { return organizationId; }

    public void setOrganizationId(Long organizationId) { this.organizationId = organizationId; }

    public String getOrganizationName() { return organizationName; }

    public void setOrganizationName(String organizationName) { this.organizationName = organizationName;}

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

}
