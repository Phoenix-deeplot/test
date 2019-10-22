package com.kst.pjs.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.pjs.entity.ProjectGroup;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProjectGroupMapper extends BaseMapper<ProjectGroup> {

    List<ProjectGroup> selectProjectGroup(Map<String,Object> params);

    Long selectMaxId();

    List<User> selectUserByPjId(Map<String,Object> params);

    List<User> selectProjectUserByPage(DataTable dt);

    Integer selectProjectUserTotal(DataTable dt);

    List<Long> selectDistinctId();
}
