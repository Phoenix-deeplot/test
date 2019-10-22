package com.kst.ams.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.ams.entity.Divide;
import com.kst.ams.vo.DepreciationVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface DivideMapper extends BaseMapper<Divide> {

    //查看已到时间的devide记录 --输入为当前年月
    List<Divide> selectPassDivideByYymm(Map<String,Object> params);

    //查看未到时间的devide记录
    List<Divide> selectuFtureDivideByYymm(Map<String,Object> params);

    List<DepreciationVO> selectDepreciationList(Map<String,Object> params);

}
