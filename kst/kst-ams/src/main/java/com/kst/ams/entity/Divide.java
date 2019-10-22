package com.kst.ams.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.common.base.entity.DataEntity;

@TableName("ams_divide")
public class Divide extends DataEntity<Divide> {
    private static final long serialVersionUID = 1L;

    /**
     * 折旧资产编号
     */
    @TableField("asset_no")
    private String assetNo;

    /**
     * 折旧年月
     */
    @TableField("divide_yymm")
    private String divideYymm;

    /**
     * 每月折旧
     */
    @TableField("month_provision")
    private Double monthProvision;

    /**
     * 本月折旧
     */
    @TableField("provision_value")
    private Double provisionValue;

    /**
     *已折总价（包括本月）
     */
    @TableField("provision_all_value")
    private Double provisionAllValue;

    /**
     * 剩余价值
     */
    @TableField("balance_value")
    private Double balanceValue;

    /**
     * 是否为残值折算
     */
    @TableField("residual_flag")
    private Boolean residualFlag;

    @TableField("more_info")
    private String moreInfo;


    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    /**
     * 资产编号
     */
    public String getAssetNo() {
        return assetNo;
    }

    public void setAssetNo(String assetNo) {
        this.assetNo = assetNo;
    }

    /**
     * 分摊年月
     */
    public String getDivideYymm() {
        return divideYymm;
    }

    public void setDivideYymm(String divideYymm) {
        this.divideYymm = divideYymm;
    }

    public Double getMonthProvision() {
        return monthProvision;
    }

    public void setMonthProvision(Double monthProvision) {
        this.monthProvision = monthProvision;
    }

    /**
     * 本月计提
     */
    public Double getProvisionValue() {
        return provisionValue;
    }

    public void setProvisionValue(Double provisionValue) {
        this.provisionValue = provisionValue;
    }

    /**
     * 已提折旧(含本月)
     */
    public Double getProvisionAllValue() {
        return provisionAllValue;
    }

    public void setProvisionAllValue(Double provisionAllValue) {
        this.provisionAllValue = provisionAllValue;
    }

    /**
     * 账面余额
     */
    public Double getBalanceValue() {
        return balanceValue;
    }

    public void setBalanceValue(Double balanceValue) {
        this.balanceValue = balanceValue;
    }

    public Boolean getResidualFlag() {
        return residualFlag;
    }

    public void setResidualFlag(Boolean residualFlag) {
        this.residualFlag = residualFlag;
    }

    public String getMoreInfo() {
        return moreInfo;
    }

    public void setMoreInfo(String moreInfo) {
        this.moreInfo = moreInfo;
    }
}
