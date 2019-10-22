package com.kst.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.sys.api.entity.Directory;
import com.kst.sys.api.vo.DirectoryVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * <p>
  * 组织 Mapper 接口
 * </p>
 *
 */
@Mapper
public interface DirectoryMapper extends BaseMapper<Directory> {
    List<DirectoryVO> selectDirectory(Map<String, Object> params);

    Integer deleteDirectory(Directory directory);

    Integer selectNameIsExist(Directory directory);

    Integer insertDirectoryResource(@Param("directoryId") Long directoryId, @Param("resourceId") Long resourceId);

    Integer deleteDirectoryResource(@Param("directoryId") Long directoryId, @Param("resourceId") Long resourceId);

    Long selectMaxId();
}