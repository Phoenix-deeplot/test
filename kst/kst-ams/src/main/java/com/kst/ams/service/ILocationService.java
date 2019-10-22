package com.kst.ams.service;

import com.kst.ams.entity.Location;
import com.kst.ams.vo.LocationVO;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.ZtreeVO;

import java.util.List;
import java.util.Map;

public interface ILocationService extends IBaseService<Location> {

    List<ZtreeVO> selectAll();

    List<LocationVO> selectLocationById(Map<String,Object> params);

    Integer selectNameIsExist(Location location);

    Integer insertLocation(Location location);

    List<LocationVO> getLocationName();

    Location getLocationName(Long id);
}
