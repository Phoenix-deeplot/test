package com.kst.pjs.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.pjs.entity.PjMain;
import com.kst.pjs.vo.PjMainVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface PjMainMapper extends BaseMapper<PjMain> {

    List<PjMain> selectPjMainByMap(Map<String,Object> params);

    List<PjMainVO> selectPjMainByPage(DataTable<PjMainVO> dt);

    Integer selectPjMainTotal(DataTable<PjMainVO> dt);

}
