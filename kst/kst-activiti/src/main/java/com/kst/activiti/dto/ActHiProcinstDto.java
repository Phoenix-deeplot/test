package com.kst.activiti.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.common.base.entity.DataEntity;

/**
 *
 * 流程历史表名
 */
@TableName("ACT_HI_PROCINST")
public class ActHiProcinstDto extends DataEntity<ActHiProcinstDto> {
    @TableField("ID_")
    private Long id;

    @TableField("PROC_INST_ID_")
    private String procInstId;

    @TableField("BUSINESS_KEY_")
    private String businessKey;

    @TableField("PROC_DEF_ID_")
    private String procDefId;

    @TableField("START_TIME_")
    private String startTime;

    @TableField("END_TIME_")
    private String endTime;

    @TableField("DURATION_")
    private String duration;

    @TableField("START_USER_ID_")
    private String startUserId;

    @TableField("START_ACT_ID_")
    private String startActId;

    @TableField("END_ACT_ID_")
    private String endActId;

    @TableField("SUPER_PROCESS_INSTANCE_ID_")
    private String superProcessInstanceId;

    @TableField("DELETE_REASON_")
    private String deleteReason;

    @TableField("TENANT_ID_")
    private String tenantId;

    @TableField("NAME_")
    private String name;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    public void setId(Long id) {
        this.id = id;
    }

    public String getProcInstId() {
        return procInstId;
    }

    public void setProcInstId(String procInstId) {
        this.procInstId = procInstId;
    }

    public String getBusinessKey() {
        return businessKey;
    }

    public void setBusinessKey(String businessKey) {
        this.businessKey = businessKey;
    }

    public String getProcDefId() {
        return procDefId;
    }

    public void setProcDefId(String procDefId) {
        this.procDefId = procDefId;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getStartUserId() {
        return startUserId;
    }

    public void setStartUserId(String startUserId) {
        this.startUserId = startUserId;
    }

    public String getStartActId() {
        return startActId;
    }

    public void setStartActId(String startActId) {
        this.startActId = startActId;
    }

    public String getEndActId() {
        return endActId;
    }

    public void setEndActId(String endActId) {
        this.endActId = endActId;
    }

    public String getSuperProcessInstanceId() {
        return superProcessInstanceId;
    }

    public void setSuperProcessInstanceId(String superProcessInstanceId) {
        this.superProcessInstanceId = superProcessInstanceId;
    }

    public String getDeleteReason() {
        return deleteReason;
    }

    public void setDeleteReason(String deleteReason) {
        this.deleteReason = deleteReason;
    }

    public String getTenantId() {
        return tenantId;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
