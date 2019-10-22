package com.kst.sys.config.plus;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.kst.common.shiro.MySysUser;
import org.apache.ibatis.reflection.MetaObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * mybatisplus自定义填充公共字段 ,即没有传的字段自动填充
 * @author chen
 */
@Component
public class SysMetaObjectHandler implements MetaObjectHandler {

    private Logger logger = LoggerFactory.getLogger(getClass());

    //新增填充
    @Override
    public void insertFill(MetaObject metaObject) {
        logger.info("正在调用该insert填充字段方法");
        Object createDate = getFieldValByName("createDate",metaObject);
        Object createBy = getFieldValByName("createBy",metaObject);
        Object updateDate = getFieldValByName("updateDate",metaObject);
        Object updateBy = getFieldValByName("updateBy",metaObject);


        if (null == createDate) {
            setFieldValByName("createDate", new Date(),metaObject);
        }
        if (null == createBy) {
            if(MySysUser.ShiroUser() != null) {
                setFieldValByName("createBy", MySysUser.loginName(), metaObject);
            }
        }
        if (null == updateDate) {
            setFieldValByName("updateDate", new Date(),metaObject);
        }
        if (null == updateBy) {
            if(MySysUser.ShiroUser() != null) {
                setFieldValByName("updateBy", MySysUser.loginName(), metaObject);
            }
        }
    }

    //更新填充
    @Override
    public void updateFill(MetaObject metaObject) {
        logger.info("正在调用该update填充字段方法");
        setFieldValByName("updateDate",new Date(), metaObject);
        Object updateBy = getFieldValByName("updateBy",metaObject);
        if (null == updateBy) {
            setFieldValByName("updateBy", MySysUser.loginName(), metaObject);
        }
    }
}
