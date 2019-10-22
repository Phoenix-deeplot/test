package com.kst.ams.vo;

import com.kst.ams.entity.AssetApply;
import com.kst.ams.entity.AssetTakeOut;

public class AssetTakeOutVO extends AssetTakeOut {
    private String takeOutUserId;
    private String name;
    private String assetInputNo;
    private String classify;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAssetInputNo() {
        return assetInputNo;
    }

    public void setAssetInputNo(String assetInputNo) {
        this.assetInputNo = assetInputNo;
    }

    public String getClassify() {
        return classify;
    }

    public void setClassify(String classify) {
        this.classify = classify;
    }

    public String getTakeOutUserId() {
        return takeOutUserId;
    }

    public void setTakeOutUserId(String takeOutUserId) {
        this.takeOutUserId = takeOutUserId;
    }
}
