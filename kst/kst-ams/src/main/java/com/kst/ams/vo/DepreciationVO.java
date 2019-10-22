package com.kst.ams.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.ams.entity.AssetInfo;

import java.util.Date;

public class DepreciationVO{

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date buyDate=null;

    private String assetInputNo="";

    private String name="";

    private String classifyName="";

    private Integer amount=0;

    private Double price=0.0;

    private Double netWorth=0.0;

    private Double residualPrice=0.0;

    private Integer useLife=null;

    private Double monthProvision=0.0;

    private Double provisionValue=0.0;

    private Double provisionAllValue=0.0;

    private Double balanceValue=0.0;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date reservescrapDate=null;

    public Date getBuyDate() {
        return buyDate;
    }

    public void setBuyDate(Date buyDate) {
        this.buyDate = buyDate;
    }

    public String getAssetInputNo() {
        return assetInputNo;
    }

    public void setAssetInputNo(String assetInputNo) {
        this.assetInputNo = assetInputNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getClassifyName() {
        return classifyName;
    }

    public void setClassifyName(String classifyName) {
        this.classifyName = classifyName;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getNetWorth() {
        return netWorth;
    }

    public void setNetWorth(Double netWorth) {
        this.netWorth = netWorth;
    }

    public Double getResidualPrice() {
        return residualPrice;
    }

    public void setResidualPrice(Double residualPrice) {
        this.residualPrice = residualPrice;
    }

    public Integer getUseLife() {
        return useLife;
    }

    public void setUseLife(Integer useLife) {
        this.useLife = useLife;
    }

    public Double getMonthProvision() {
        return monthProvision;
    }

    public void setMonthProvision(Double monthProvision) {
        this.monthProvision = monthProvision;
    }

    public Double getProvisionValue() {
        return provisionValue;
    }

    public void setProvisionValue(Double provisionValue) {
        this.provisionValue = provisionValue;
    }

    public Double getProvisionAllValue() {
        return provisionAllValue;
    }

    public void setProvisionAllValue(Double provisionAllValue) {
        this.provisionAllValue = provisionAllValue;
    }

    public Double getBalanceValue() {
        return balanceValue;
    }

    public void setBalanceValue(Double balanceValue) {
        this.balanceValue = balanceValue;
    }

    public Date getReservescrapDate() {
        return reservescrapDate;
    }

    public void setReservescrapDate(Date reservescrapDate) {
        this.reservescrapDate = reservescrapDate;
    }
}
