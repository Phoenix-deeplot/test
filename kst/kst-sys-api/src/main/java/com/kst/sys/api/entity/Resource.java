package com.kst.sys.api.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kst.common.base.entity.DataEntity;

import java.util.Date;

@TableName("sys_resource")
public class Resource extends DataEntity<Resource> {
    @TableField("type_id")
    private Long typeId;

    @TableField("url")
    private String url;

    @TableField("name")
    private String name;

    @TableField("file_size")
    private String fileSize;

    @TableField("file_type")
    private String fileType;

    @TableField("file_create_date")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date fileCreateDate;

    @TableField("file_update_date")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date fileUpdateDate;


    public Long getTypeId() {
        return typeId;
    }

    public void setTypeId(Long typeId) {
        this.typeId = typeId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFileSize() {
        return fileSize;
    }

    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public Date getFileCreateDate() {
        return fileCreateDate;
    }

    public void setFileCreateDate(Date fileCreateDate) {
        this.fileCreateDate = fileCreateDate;
    }

    public Date getFileUpdateDate() {
        return fileUpdateDate;
    }

    public void setFileUpdateDate(Date fileUpdateDate) {
        this.fileUpdateDate = fileUpdateDate;
    }

}
