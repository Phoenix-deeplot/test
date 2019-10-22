package com.kst.ams.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.common.base.entity.DataEntity;

import javax.persistence.Table;

/**
 * 配件表
 *
 * @author lxm
 * @since 2017-10-31
 */
@TableName("ams_software_info")
public class SoftwareInfo extends DataEntity<SoftwareInfo> {

    /**
     * 对象资产编号
     */
    @TableField("asset_no")
    private String assetNo;

    /**
     * 配件名称
     */
    @TableField("name")
    private String name;

    /**
     * 资产编号（是固定资产才有）
     */
    @TableField("soft_asset_no")
    private String softAssetNo;

    /**
     * 配件类型
     */
    @TableField("software_id")
    private String softwareId;

    /**
     * 配件类型名称
     */
    @TableField(exist = false)
    private String softwareName;

    /**
     * 是否为资产
     */
    @TableField("asset_flag")
    private Boolean assetFlag;

    /**
     * 注释
     */
    @TableField("more_info")
    private String moreInfo;

    /**
     * 报废标识
     */
    @TableField("scrap_flag")
    private Boolean scrapFlag;

    /**
     *资产编号
     */
    public String getAssetNo() {
        return assetNo;
    }

    public void setAssetNo(String assetNo) {
        this.assetNo = assetNo;
    }

    /**
     * 软件名称
     */
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    /**
     *软件类型ID
     */
    public String getSoftAssetNo() {
        return softAssetNo;
    }

    public void setSoftAssetNo(String softAssetNo) {
        this.softAssetNo = softAssetNo;
    }

    /**
     * 是否为已注册资产
     */
    public String getSoftwareId() {
        return softwareId;
    }

    public void setSoftwareId(String softwareId) {
        this.softwareId = softwareId;
    }

    /**
     * 补充说明
     */
    public Boolean getAssetFlag() {
        return assetFlag;
    }

    public void setAssetFlag(Boolean assetFlag) {
        this.assetFlag = assetFlag;
    }

    public String getMoreInfo() {
        return moreInfo;
    }

    public void setMoreInfo(String moreInfo) {
        this.moreInfo = moreInfo;
    }

    public String getSoftwareName() {
        return softwareName;
    }

    public void setSoftwareName(String softwareName) {
        this.softwareName = softwareName;
    }

    public Boolean getScrapFlag() {
        return scrapFlag;
    }

    public void setScrapFlag(Boolean scrapFlag) {
        this.scrapFlag = scrapFlag;
    }
}
