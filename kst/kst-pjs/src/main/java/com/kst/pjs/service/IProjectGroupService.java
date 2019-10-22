package com.kst.pjs.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.pjs.entity.ProjectGroup;
import com.kst.sys.api.entity.User;

import java.util.List;
import java.util.Map;

public interface IProjectGroupService extends IBaseService<ProjectGroup> {

    List<ZtreeVO> selectProjectGroupTree(Map<String,Object> params);

    List<ProjectGroup> selectProjectGroup(Map<String,Object> params);

    Integer insertProjectGroup(ProjectGroup projectGroup);

    List<User> selectUserByPjId(Long pjId);

    DataTable<User> selectProjectGroupUserPage(DataTable dt);

    List<Long> selectDistinct();


}
