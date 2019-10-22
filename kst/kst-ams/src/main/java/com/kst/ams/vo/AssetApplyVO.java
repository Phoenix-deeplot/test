package com.kst.ams.vo;

import com.kst.ams.entity.AssetApply;

public class AssetApplyVO extends AssetApply {
    private String applyStatus;
    private String locationId;

    public String getLocationId() {
        return locationId;
    }

    public void setLocationId(String locationId) {
        this.locationId = locationId;
    }

    public String getApplyStatus() {
        return applyStatus;
    }

    public void setApplyStatus(String applyStatus) {
        this.applyStatus = applyStatus;
    }
}
