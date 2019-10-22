package com.kst.sys.api.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.common.base.entity.DataEntity;

import javax.persistence.Table;
import java.util.List;
import java.util.Map;

@TableName("sys_rfid")
public class Rfid extends DataEntity<Rfid> {

    @TableField("rfid_ip")
    private String ip;

    @TableField("rfid_com")
    private Integer com;

    @TableField("rfid_location")
    private String location;

    @TableField("rfid_name")
    private String name;

    @TableField("rfid_canuse")
    private Boolean canuse;

    @TableField("rfid_useflg")
    private Boolean useflg;

    @TableField(exist = false)
    private List<Map<String,Object>> data;

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Integer getCom() {
        return com;
    }

    public void setCom(Integer com) {
        this.com = com;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getCanuse() {
        return canuse;
    }

    public void setCanuse(Boolean canuse) {
        this.canuse = canuse;
    }

    public Boolean getUseflg() {
        return useflg;
    }

    public void setUseflg(Boolean useflg) {
        this.useflg = useflg;
    }

    public List<Map<String,Object>> getData() {
        return data;
    }

    public void setData(List<Map<String,Object>> data) {
        this.data = data;
    }
}
