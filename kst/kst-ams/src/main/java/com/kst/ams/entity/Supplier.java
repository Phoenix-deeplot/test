package com.kst.ams.entity;

import com.baomidou.mybatisplus.annotation.FieldStrategy;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kst.common.base.entity.DataEntity;

/**
 * <p>
 *
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
@TableName("ams_supplier")
public class Supplier extends DataEntity<Supplier> {

    private static final long serialVersionUID = 1L;

    /**
     * 供应商名称
     */
    @TableField("name")
    private String name;

    /**
     * 地址
     */
    @TableField(strategy= FieldStrategy.IGNORED)
    private String address;
    /**
     * 手机号码
     */
    @TableField(strategy= FieldStrategy.IGNORED)
    private String tel;

    /**
     * 联系人
     */
    @TableField(strategy= FieldStrategy.IGNORED)
    private String contact;

    /**
     * 传真
     */
    @TableField(strategy= FieldStrategy.IGNORED)
    private String mail;

    /**
     * 手机
     */
    @TableField(strategy= FieldStrategy.IGNORED)
    private String phone;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

}