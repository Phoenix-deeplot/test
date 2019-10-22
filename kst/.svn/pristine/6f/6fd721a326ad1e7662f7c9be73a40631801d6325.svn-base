package com.kst.ams.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.ams.entity.AssetExamine;
import com.kst.ams.entity.AssetExamineDetail;
import com.kst.ams.entity.AssetMoveManager;

import java.util.Date;
import java.util.List;

public class AssetExamineVO extends AssetExamine {
    /**
     * 点检编号
     */
    private String no;

    /**
     * 点检名称
     */
    private String name;

    /**
     * 点检开始日
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date examineBeginDate;

    /**
     * 点检终了日
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date examineEndDate;
    /**
     * 点检创建日
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date examineCreateDate;
    /**
     * 登记日
     */
    private String moreInfo;
    public AssetExamineVO(AssetExamine assetExamine){
        if (assetExamine != null) {
            this.no = assetExamine.getNo();
            this.name = assetExamine.getName();
            this.examineBeginDate = assetExamine.getExamineBeginDate();
            this.examineEndDate = assetExamine.getExamineEndDate();
            this.examineCreateDate = assetExamine.getExamineCreateDate();
        }
    }
    private List<AssetExamineDetail> assetExamineDetailList;

    public List<AssetExamineDetail> getAssetExamineDetailList() {
        return assetExamineDetailList;
    }

    public void setAssetExamineDetailList(List<AssetExamineDetail> assetExamineDetailList) {
        this.assetExamineDetailList = assetExamineDetailList;
    }

    @Override
    public String getNo() {
        return no;
    }

    @Override
    public void setNo(String no) {
        this.no = no;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public Date getExamineBeginDate() {
        return examineBeginDate;
    }

    @Override
    public void setExamineBeginDate(Date examineBeginDate) {
        this.examineBeginDate = examineBeginDate;
    }

    @Override
    public Date getExamineEndDate() {
        return examineEndDate;
    }

    @Override
    public void setExamineEndDate(Date examineEndDate) {
        this.examineEndDate = examineEndDate;
    }

    @Override
    public Date getExamineCreateDate() {
        return examineCreateDate;
    }

    @Override
    public void setExamineCreateDate(Date examineCreateDate) {
        this.examineCreateDate = examineCreateDate;
    }

    @Override
    public String getMoreInfo() {
        return moreInfo;
    }

    @Override
    public void setMoreInfo(String moreInfo) {
        this.moreInfo = moreInfo;
    }
}
