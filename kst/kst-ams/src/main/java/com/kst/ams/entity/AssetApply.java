package com.kst.ams.entity;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
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
@TableName("ams_asset_apply")
public class AssetApply extends DataEntity<AssetApply> {
    private static final long serialVersionUID = 1L;

    /**
     * 资产编号
     */
    @TableField("no")
    private String no;
    /**
     * 资产名称
     */
    @TableField(exist = false)
    private String name;
    /**
     * 领用者ID
     */
    @TableField("APPLY_ID")
    private String applyId;

    /**
     * 领用日
     */
    @TableField("APPLY_DATE")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date applyDate;

    /**
     * 归还日
     */
    @TableField("RETURN_DATE")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date returnDate;

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

    public String getApplyId() {
        return applyId;
    }

    public void setApplyId(String applyId) {
        this.applyId = applyId;
    }

    public String getMoreInfo() {
        return moreInfo;
    }

    public void setMoreInfo(String moreInfo) {
        this.moreInfo = moreInfo;
    }
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
