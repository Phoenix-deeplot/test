package com.kst.sys.api.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.sys.api.entity.Organization;
import com.kst.sys.api.entity.SysQuestion;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.vo.OrganizationVO;
import com.kst.sys.api.vo.UserVO;
import io.lettuce.core.dynamic.annotation.Param;

import java.util.List;
import java.util.Map;

public interface IOrganizationService extends IBaseService<Organization> {
    DataTable<UserVO> selectUserVOByPage(DataTable<UserVO> dt);
    List<UserVO> selectUserVOByMap(Map<String,Object> params);

    List<ZtreeVO> selectAll();

    Integer insertOrganization(Organization organization);

    OrganizationVO selectOrganizationById(Long id);

    Integer selectNameIsExist(Organization organization);

    DataTable<UserVO> selectUserByPage(DataTable dt);

    List<UserVO> selectInorganizationUser();

    Integer insertUserToOrganization(Long organizationId, Long userId);

    Integer deleteUserFromOrganization(Long organizationId, Long userId);

    List<UserVO> selectAllUserAndOrgan(Map<String ,Object> params);

    OrganizationVO selectRootOrganization(Long id);

}
