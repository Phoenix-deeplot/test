package com.kst.sys.api.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.sys.api.entity.Directory;
import com.kst.sys.api.vo.DirectoryVO;

import java.util.List;

public interface IDirectoryService extends IBaseService<Directory> {
    List<ZtreeVO> selectAll();

    Integer updateDirectoryById(Directory directory);

    Integer insertDirectory(Directory directory);

    Integer deleteDirectory(Directory directory);

    DirectoryVO selectDirectoryById(Long id);

    Integer selectNameIsExist(Directory directory);

    Integer insertDirectoryResource(Long directoryId, Long resourceId);

    Integer deleteDirectoryResource(Long directoryId, Long resourceId);


}
