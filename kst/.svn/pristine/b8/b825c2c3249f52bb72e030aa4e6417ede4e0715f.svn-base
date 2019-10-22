package com.kst.sys.api.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Resource;
import com.kst.sys.api.vo.ResourceVO;

import java.util.List;

public interface IResourceService extends IBaseService<Resource> {

    List<ResourceVO> selectResourceById(Long id);

    DataTable<ResourceVO> selectResourceByPage(DataTable dt);

    Integer insertResource(Resource resource);

}
