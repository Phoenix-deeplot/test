package com.kst.ams.entity;

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
@TableName("ams_asset_examine_detail")
public class AssetExamineDetail extends DataEntity<AssetExamineDetail> {
    private static final long serialVersionUID = 1L;

    /**
     * 点检编号
     */
    @TableField("EXAMINE_NO")
    private String no;

    /**
     * 资产编号
     */
    @TableField("ASSET_NO")
    private String assetNo;

    @TableField(exist = false)
    private String name;

    /**
     * 点检日
     */
    @TableField("EXAMINE_DATE")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date examineDate;

    /**
     * 点检者ID
     */
    @TableField("EXAMINER_ID")
    private String examinerId;
    /**
     * 点检结果ID
     */
    @TableField("EXAMINERESULT_ID")
    private String examineResultId;

    @TableField("reason_txt")
    private String reasonTxt;

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getAssetNo() {
        return assetNo;
    }

    public void setAssetNo(String assetNo) {
        this.assetNo = assetNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getExamineDate() {
        return examineDate;
    }

    public void setExamineDate(Date examineDate) {
        this.examineDate = examineDate;
    }

    public String getExaminerId() {
        return examinerId;
    }

    public void setExaminerId(String examinerId) {
        this.examinerId = examinerId;
    }

    public String getExamineResultId() {
        return examineResultId;
    }

    public void setExamineResultId(String examineResultId) {
        this.examineResultId = examineResultId;
    }

    public String getReasonTxt() {
        return reasonTxt;
    }

    public void setReasonTxt(String reasonTxt) {
        this.reasonTxt = reasonTxt;
    }
}
