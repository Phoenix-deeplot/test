package com.kst.ams.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.ams.entity.Location;
import com.kst.ams.vo.LocationVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface LocationMapper extends BaseMapper<Location> {

    List<LocationVO> selectLocation(Map<String,Object> params);

    Integer selectNameIsExist(Location location);

    Long selectMaxId();

}
