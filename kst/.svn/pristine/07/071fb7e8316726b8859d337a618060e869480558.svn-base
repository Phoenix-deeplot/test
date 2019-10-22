package com.kst.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.sys.api.entity.Organization;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.vo.OrganizationVO;
import com.kst.sys.api.vo.UserVO;
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
public interface OrganizationMapper extends BaseMapper<Organization> {
    List<UserVO> selectUserVOByPage(DataTable<UserVO> dt);

    Integer selectUserVOTotal(DataTable<UserVO> dt);
    List<UserVO> selectUserVOByMap(Map<String,Object> params);


    List<OrganizationVO> selectOrganization(Map<String, Object> params);

    Integer selectNameIsExist(Organization group);

    List<UserVO> selectUserByPage(DataTable dt);

    Integer selectUserTotal(DataTable dt);

    List<UserVO> selectInorganizationUser();

    Integer insertUserToOrganization(@Param("organizationId") Long organizationId, @Param("userId") Long userId);

    Integer deleteUserFromOrganization(@Param("organizationId") Long organizationId, @Param("userId") Long userId);

    Long selectMaxId();

    List<UserVO> selectAllUserAndOrgan(Map<String,Object> params);

    OrganizationVO selectRootOrganization(Long id);
}