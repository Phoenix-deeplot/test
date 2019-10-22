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
@TableName("ams_asset_examine")
public class AssetExamine extends DataEntity<AssetExamine> {
    private static final long serialVersionUID = 1L;

    /**
     * 点检编号
     */
    @TableField("EXAMINE_NO")
    private String no;

    /**
     * 点检名称
     */
    @TableField("EXAMINE_NAME")
    private String name;

    /**
     * 点检开始日
     */
    @TableField("EXAMINE_BEGINDATE")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date examineBeginDate;

    /**
     * 点检终了日
     */
    @TableField("EXAMINE_ENDDATE")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date examineEndDate;
    /**
     * 点检创建日
     */
    @TableField("EXAMINE_CREATEDATE")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date examineCreateDate;

    @TableField("MORE_INFO")
    private String moreInfo;

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getExamineBeginDate() {
        return examineBeginDate;
    }

    public void setExamineBeginDate(Date examineBeginDate) {
        this.examineBeginDate = examineBeginDate;
    }

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getExamineEndDate() {
        return examineEndDate;
    }

    public void setExamineEndDate(Date examineEndDate) {
        this.examineEndDate = examineEndDate;
    }

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getExamineCreateDate() {
        return examineCreateDate;
    }

    public void setExamineCreateDate(Date examineCreateDate) {
        this.examineCreateDate = examineCreateDate;
    }

    public String getMoreInfo() {
        return moreInfo;
    }

    public void setMoreInfo(String moreInfo) {
        this.moreInfo = moreInfo;
    }
}
