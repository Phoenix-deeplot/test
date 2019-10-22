package com.kst.ams.vo;

public class AssetDiscardVO {

    private Integer no;

    private String assetInputNo;

    private String name;

    private String classifyName;

    private Integer amount=0;

    private Double price=0.0;

    private String supplierName;

    private Integer useLife;

    private String buyDate;

    private String reserveScrapDate;

    private String actualScrapDate;

    private String applyUserName;

    private String locationName;

    private String takeOutUserName;

    private String examineTarget;

    private String remarks;

    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
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

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public Integer getUseLife() {
        return useLife;
    }

    public void setUseLife(Integer useLife) {
        this.useLife = useLife;
    }

    public String getBuyDate() {
        return buyDate;
    }

    public void setBuyDate(String buyDate) {
        this.buyDate = buyDate;
    }

    public String getReserveScrapDate() {
        return reserveScrapDate;
    }

    public void setReserveScrapDate(String reserveScrapDate) {
        this.reserveScrapDate = reserveScrapDate;
    }

    public String getActualScrapDate() {
        return actualScrapDate;
    }

    public void setActualScrapDate(String actualScrapDate) {
        this.actualScrapDate = actualScrapDate;
    }

    public String getApplyUserName() {
        return applyUserName;
    }

    public void setApplyUserName(String applyUserName) {
        this.applyUserName = applyUserName;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getTakeOutUserName() {
        return takeOutUserName;
    }

    public void setTakeOutUserName(String takeOutUserName) {
        this.takeOutUserName = takeOutUserName;
    }

    public String getExamineTarget() {
        return examineTarget;
    }

    public void setExamineTarget(String examineTarget) {
        this.examineTarget = examineTarget;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
