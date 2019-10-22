package com.kst.activiti.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.common.base.entity.DataEntity;


@TableName("act_asset_apply_workFlow")
public class ActApplyWorkFlow extends DataEntity<ActApplyWorkFlow> {
    private static final long serialVersionUID = 1L;

    /**
     * 资产名称
     */
    @TableField("name")
    private String name;

    @TableField("filename")
    private String filename;
    @TableField("flow_id")
    private String flowId;
    /**
     * 领用者
     */
    @TableField("applyer")
    private String applyer;


    @TableField("apply_status")
    private String applyStatus;

    @TableField("asset_price")
    private String assetPrice;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getApplyer() {
        return applyer;
    }

    public void setApplyer(String applyer) {
        this.applyer = applyer;
    }

    public String getApplyStatus() {
        return applyStatus;
    }

    public void setApplyStatus(String applyStatus) {
        this.applyStatus = applyStatus;
    }

    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }

    public String getAssetPrice() {
        return assetPrice;
    }

    public void setAssetPrice(String assetPrice) {
        this.assetPrice = assetPrice;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }
}
