package com.kst.ams.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.AmsDataEntity;
import com.kst.common.base.entity.DataEntity;

import java.util.Date;

/**
 * <p>
 *
 * </p>
 *
 * @author ys
 * @since 2017-10-31
 */
@TableName("ams_location_history")
public class AssetMoveManager extends DataEntity<AssetMoveManager> {
    private static final long serialVersionUID = 1L;

    /**
     * 资产编号
     */
    @TableField("no")
    private String no;

    /**
     * 领用者ID
     */
    @TableField("LOCATION_ID")
    private String locationId;

    /**
     * 领用日
     */
    @TableField("STORAGE_DATE")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date storageDate;

    /**
     * 归还日
     */
    @TableField("DELETE_DATE")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date removeDate;

    /**
     * 登记日
     */
    @TableField("MORE_INFO")
    private String moreInfo;

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getLocationId() {
        return locationId;
    }

    public void setLocationId(String locationId) {
        this.locationId = locationId;
    }

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getStorageDate() {
        return storageDate;
    }

    public void setStorageDate(Date storageDate) {
        this.storageDate = storageDate;
    }

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getRemoveDate() {
        return removeDate;
    }

    public void setRemoveDate(Date removeDate) {
        this.removeDate = removeDate;
    }

    public String getMoreInfo() {
        return moreInfo;
    }

    public void setMoreInfo(String moreInfo) {
        this.moreInfo = moreInfo;
    }
}
