package com.kst.log.service;


import com.kst.common.base.service.IBaseService;
import com.kst.log.entity.Log;

import java.util.List;

/**
 * <p>
 * 系统日志 服务类
 * </p>
 *
 * @author zjf
 * @since 2018-01-13
 */
public interface ILogService extends IBaseService<Log> {

    public List<Integer> selectSelfMonthData();

}
