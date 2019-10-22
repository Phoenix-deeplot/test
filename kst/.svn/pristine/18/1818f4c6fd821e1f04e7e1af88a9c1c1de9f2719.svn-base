package com.kst.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Msg;
import com.kst.sys.api.entity.SysQuestion;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SysQuestionMapper extends BaseMapper<SysQuestion> {

    List<SysQuestion> selectSysQuestionByPage(DataTable dt);

    Integer selectSysQuestionTotal(DataTable dt);

    List<SysQuestion> selectSysQuestionByMap(Map<String,Object> params);

}
