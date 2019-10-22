package com.kst.sys.api.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Msg;
import com.kst.sys.api.vo.UserVO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


public interface IMsgService extends IBaseService<Msg> {

    DataTable<Msg> selectMsgByPage(DataTable<Msg> dt);

    Msg selectMsgById(Long id);

    List<Msg> selectMsgByUserId(Long userId);

    Integer insertMsg(Map<String,Object> params);
}
