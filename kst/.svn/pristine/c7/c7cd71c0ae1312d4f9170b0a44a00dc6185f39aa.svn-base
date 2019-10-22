package com.kst.sys.api.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.google.common.collect.Sets;
import com.kst.common.base.entity.DataEntity;

import java.util.Set;

/**
 * <p>
 *
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
@TableName("sys_user")
public class User extends DataEntity<User> {

    private static final long serialVersionUID = 1L;

    /**
     * 登录名
     */
    @TableField("login_name")
    private String loginName;
    /**
     * 昵称
     */
    @TableField(value = "nick_name",strategy= FieldStrategy.IGNORED)
    private String nickName;
    /**
     * 密码
     */
    private String password;
    /**
     * shiro加密盐
     */
    private String salt;
    /**
     * 手机号码
     */
    @TableField(strategy= FieldStrategy.IGNORED)
    private String tel;
    /**
     * 邮箱地址
     */
    @TableField(strategy= FieldStrategy.IGNORED)
    private String email;

    /**
     * 账户是否锁定
     */
    private Boolean locked;

    /**
     * 账户是否有效
     */
    @TableField(value = "disable_flag",strategy= FieldStrategy.IGNORED)
    private Boolean disableFlag;

    @TableField(strategy= FieldStrategy.IGNORED)
    private String icon;

    @TableField(exist=false)
    private Set<Role> roleLists = Sets.newHashSet();

    @TableField(exist=false)
    private Set<Menu> menus = Sets.newHashSet();

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    @JSONField(serialize=false)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @JSONField(serialize=false)
    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getLocked() {
        return locked;
    }

    public void setLocked(Boolean locked) {
        this.locked = locked;
    }

    public Boolean getDisableFlag() {
        return disableFlag;
    }

    public void setDisableFlag(Boolean disableFlag) {
        this.disableFlag = disableFlag;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Set<Role> getRoleLists() {
        return roleLists;
    }

    public void setRoleLists(Set<Role> roleLists) {
        this.roleLists = roleLists;
    }

    public Set<Menu> getMenus() {
        return menus;
    }

    public void setMenus(Set<Menu> menus) {
        this.menus = menus;
    }
}