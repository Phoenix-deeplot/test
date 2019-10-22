package com.kst.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Msg;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MsgMapper extends BaseMapper<Msg> {

    List<Msg> selectMsgByPage(DataTable dt);

    Integer selectMsgTotal(DataTable dt);

    List<Msg> selectMsgByMap(Map<String,Object> params);

    Integer insertMsg(Map<String,Object> params);

}
