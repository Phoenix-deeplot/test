package com.kst.ams.service.impl;

import com.google.common.collect.Lists;
import com.kst.ams.entity.Location;
import com.kst.ams.mapper.LocationMapper;
import com.kst.ams.service.ILocationService;
import com.kst.ams.vo.LocationVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.ZtreeVO;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LocationServiceImpl extends BaseService<LocationMapper, Location> implements ILocationService {

    @Override
    public List<ZtreeVO> selectAll() {
        List<LocationVO> locations=this.baseMapper.selectLocation(null);
        List<ZtreeVO> list= Lists.newArrayList();
        return getZTree(null,locations,list);
    }

    @Override
    public List<LocationVO> selectLocationById(Map<String,Object> params) {
        return this.baseMapper.selectLocation(params);
    }

    @Override
    public Integer selectNameIsExist(Location location) {
        return this.baseMapper.selectNameIsExist(location);
    }

    @Override
    public Integer insertLocation(Location location) {
        location.setId(this.baseMapper.selectMaxId());
        this.baseMapper.insert(location);
        if (location.getLevel()==1){
            location.setParentIds(location.getId()+",");
        }else{
            Map<String,Object> param=new HashMap<>();
            param.put("id",location.getParentId());
            LocationVO g=this.baseMapper.selectLocation(param).get(0);
            location.setParentIds(g.getParentIds()+location.getId()+",");

        }
        this.baseMapper.updateById(location);
        return null;
    }

    @Override
    public List<LocationVO> getLocationName() {
        Map<String,Object> params=new HashMap<>();
        List<LocationVO> location = baseMapper.selectLocation(params);
        return location;
    }

    @Override
    public Location getLocationName(Long id) {
        Location location = baseMapper.selectById(id);
        return location;
    }

    private  List<ZtreeVO> getZTree(ZtreeVO tree, List<LocationVO> total, List<ZtreeVO> result){
        Long pid = tree  ==null?null:tree.getId();
        List<ZtreeVO> childList = Lists.newArrayList();
        for (LocationVO m : total){
            if(String.valueOf(m.getParentId()).equals(String.valueOf(pid))) {
                ZtreeVO ztreeVO = new ZtreeVO();
                ztreeVO.setId(m.getId());
                ztreeVO.setName(m.getName());
                ztreeVO.setPid(pid);
                childList.add(ztreeVO);
                getZTree(ztreeVO,total,result);
            }
        }
        if(tree != null){
            if (childList.size()>0){
                tree.setChildren(childList);
            }
        }else{
            result = childList;
        }
        return result;
    }

}
