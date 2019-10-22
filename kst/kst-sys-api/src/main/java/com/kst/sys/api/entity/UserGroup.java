package com.kst.sys.api.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

@TableName("sys_user_group")
public class UserGroup extends TreeEntity<UserGroup> {

    /**
     * 用户组名
     */
    @TableField("name")
    private String name;

    /**
     * 父节点名
     */
    @TableField(exist = false)
    private String parentName;

    /**
     * 用户组状态
     */
    @TableField("group_status")
    private String groupStatus;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getGroupStatus() {
        return groupStatus;
    }

    public void setGroupStatus(String groupStatus) {
        this.groupStatus = groupStatus;
    }
}
