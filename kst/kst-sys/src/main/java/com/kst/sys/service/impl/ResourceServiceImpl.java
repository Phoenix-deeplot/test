package com.kst.sys.service.impl;

import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Resource;
import com.kst.sys.api.vo.ResourceVO;
import com.kst.sys.mapper.ResourceMapper;
import com.kst.sys.api.service.IResourceService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service(value = "resourceService")
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ResourceServiceImpl extends BaseService<ResourceMapper, Resource> implements IResourceService {

    @Override
    public List<ResourceVO> selectResourceById(Long id) {
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        return this.baseMapper.selectResource(params);
    }

    @Override
    public DataTable<ResourceVO> selectResourceByPage(DataTable dt) {
        DataTable<ResourceVO> dataTable=new DataTable<>();
        List<ResourceVO> list=this.baseMapper.selectResourcePage(dt);
        dataTable.setTotal(this.baseMapper.selectResourceByPageTotal(dt));
        dataTable.setRows(list);
        return dataTable;
    }

    @Override
    public Integer insertResource(Resource resource) {
        return baseMapper.insert(resource);
    }


}
