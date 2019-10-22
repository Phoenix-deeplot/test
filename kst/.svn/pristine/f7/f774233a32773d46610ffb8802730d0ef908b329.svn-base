package com.kst.att.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.att.entity.AttRfid;
import com.kst.att.vo.RfidVO;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Rfid;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AttRfidMapper extends BaseMapper<AttRfid> {

    List<RfidVO> selectAttRfidByPage(DataTable dt);

    Integer selectAttRfidTotal(DataTable dt);

    List<RfidVO> selectAllAttRfid(Map<String,Object> params);

}
