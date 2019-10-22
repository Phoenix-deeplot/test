package com.kst.activiti.ext;

import com.kst.common.utils.SnowflakeIdGenerator;

/**
 * @Author felixu
 * @Date 2018.08.14
 */
public class IdGenerator implements org.activiti.engine.impl.cfg.IdGenerator {

    @Override
    public String getNextId() {
        return SnowflakeIdGenerator.getInstance().nextId() + "";
    }
}
