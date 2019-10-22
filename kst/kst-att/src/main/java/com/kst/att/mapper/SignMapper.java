package com.kst.att.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.att.entity.Sign;
import com.kst.att.vo.SignVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SignMapper extends BaseMapper<Sign> {
    List<SignVO> selectAttUserid(@Param("attUserid") String attUserid);

    Integer totalTime();

    Integer insertSign(Sign sign);
}
