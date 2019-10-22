package com.kst.ams.vo;

import com.kst.ams.entity.Location;

public class LocationVO extends Location {

    private String parentName;


    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }
}
