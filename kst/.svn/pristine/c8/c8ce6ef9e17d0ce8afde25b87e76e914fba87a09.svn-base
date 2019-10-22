package com.kst.ams.entity;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

/**
 * <p>
 *
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
@TableName("ams_asset_info")
public class AssetInfo extends DataEntity<AssetInfo> {

    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    @TableField("no")
    private String no;

    /**
     * 资产编号
     */
    @TableField("asset_input_no")
    private String assetInputNo;

    /**
     * 资产名称
     */
    @TableField("name")
    private String name;

    /**
     * 资产类型
     */
    @TableField("classify_id")
    private String classify;

    /**
     * 品牌
     */
    @TableField("brand")
    private String brand;

    /**
     * 供应商编号
     */
    @TableField("supplier_id")
    private String supplierId;

    /**
     * 注册日期
     */
    @TableField(value="register_date",strategy = FieldStrategy.IGNORED)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date registerDate;

    /**
     * 购买日
     */
    @TableField(value="buydate",strategy = FieldStrategy.IGNORED)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date buyDate;

    /**
     * 价格
     */
    @TableField("price")
    private Double price;

    /**
     * 数量
     */
    @TableField("amount")
    private Integer amount;

    /**
     *残值比例
     */
    @TableField(value="residual_proportion",strategy = FieldStrategy.IGNORED)
    private Double residualProportion;

    /**
     * 残值
     */
    @TableField("residual_price")
    private Double residualPrice;

    /**
     * 净值
     */
    @TableField("net_worth")
    private Double netWorth;

    /**
     * 使用年限
     */
    @TableField("uselife")
    private Integer useLife;

    /**
     * 固定资产标识
     */
    @TableField("divide_flag")
    private Boolean divideFlag;

    /**
     * 预定报废日
     */
    @TableField(value="reservescrap_date",strategy = FieldStrategy.IGNORED)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date reserveScrapDate;

    /**
     * 实际报废日
     */
    @TableField(value="actualscrap_date",strategy = FieldStrategy.IGNORED)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date actualScrapDate;

    /**
     *上级资产编号
     */
    @TableField("superior_asset_no")
    private String superiorAssetNo;

    /**
     * 保管部门编号
     */
    @TableField("keepingdepartment_id")
    private String keepingDepartmentId;

    /**
     * 保管场所编号
     */
    @TableField(value="location_id",strategy = FieldStrategy.IGNORED)
    private String locationId;

    /**
     *点检属性
     */
    @TableField("examine_target")
    private String examineTarget;

    /**
     * 申领用户
     */
    @TableField(value="apply_userid",strategy = FieldStrategy.IGNORED)
    private String applyUserid;

    /**
     * 报废用户
     */
    @TableField(value="discard_userid",strategy = FieldStrategy.IGNORED)
    private String discardUserid;

    /**
     * 状态属性
     */
    @TableField("status_property")
    private String statusProperty;

    /**
     * 二维码路径
     */
    @TableField("qrcode_img")
    private String qrCodeImg;

    /**
     * 资产图片
     */
    @TableField("asset_photo")
    private String assetPhoto;

    /**
     * 带出用户
     */
    @TableField(value="takeout_userid",strategy = FieldStrategy.IGNORED)
    private String takeoutUserid;


    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
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

    public String getClassify() {
        return classify;
    }

    public void setClassify(String classify) {
        this.classify = classify;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    public Date getBuyDate() {
        return buyDate;
    }

    public void setBuyDate(Date buyDate) {
        this.buyDate = buyDate;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getResidualProportion() {
        return residualProportion;
    }

    public void setResidualProportion(Double residualProportion) {
        this.residualProportion = residualProportion;
    }

    public Double getResidualPrice() {
        return residualPrice;
    }

    public void setResidualPrice(Double residualPrice) {
        this.residualPrice = residualPrice;
    }

    public Double getNetWorth() {
        return netWorth;
    }

    public void setNetWorth(Double netWorth) {
        this.netWorth = netWorth;
    }

    public Integer getUseLife() {
        return useLife;
    }

    public void setUseLife(Integer useLife) {
        this.useLife = useLife;
    }

    public Boolean getDivideFlag() {
        return divideFlag;
    }

    public void setDivideFlag(Boolean divideFlag) {
        this.divideFlag = divideFlag;
    }

    public Date getReserveScrapDate() {
        return reserveScrapDate;
    }

    public void setReserveScrapDate(Date reserveScrapDate) {
        this.reserveScrapDate = reserveScrapDate;
    }

    public Date getActualScrapDate() {
        return actualScrapDate;
    }

    public void setActualScrapDate(Date actualScrapDate) {
        this.actualScrapDate = actualScrapDate;
    }

    public String getSuperiorAssetNo() {
        return superiorAssetNo;
    }

    public void setSuperiorAssetNo(String superiorAssetNo) {
        this.superiorAssetNo = superiorAssetNo;
    }

    public String getKeepingDepartmentId() {
        return keepingDepartmentId;
    }

    public void setKeepingDepartmentId(String keepingDepartmentId) {
        this.keepingDepartmentId = keepingDepartmentId;
    }

    public String getLocationId() {
        return locationId;
    }

    public void setLocationId(String locationId) {
        this.locationId = locationId;
    }

    public String getExamineTarget() {
        return examineTarget;
    }

    public void setExamineTarget(String examineTarget) {
        this.examineTarget = examineTarget;
    }

    public String getApplyUserid() {
        return applyUserid;
    }

    public void setApplyUserid(String applyUserid) {
        this.applyUserid = applyUserid;
    }

    public String getDiscardUserid() {
        return discardUserid;
    }

    public void setDiscardUserid(String discardUserid) {
        this.discardUserid = discardUserid;
    }

    public String getStatusProperty() {
        return statusProperty;
    }

    public void setStatusProperty(String statusProperty) {
        this.statusProperty = statusProperty;
    }

    public String getQrCodeImg() {
        return qrCodeImg;
    }

    public void setQrCodeImg(String qrCodeImg) {
        this.qrCodeImg = qrCodeImg;
    }

    public String getAssetPhoto() {
        return assetPhoto;
    }

    public void setAssetPhoto(String assetPhoto) {
        this.assetPhoto = assetPhoto;
    }

    public String getTakeoutUserid() {
        return takeoutUserid;
    }

    public void setTakeoutUserid(String takeoutUserid) {
        this.takeoutUserid = takeoutUserid;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }
}