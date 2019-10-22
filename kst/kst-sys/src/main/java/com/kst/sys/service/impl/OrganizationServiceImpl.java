package com.kst.sys.service.impl;

import com.alibaba.fastjson.JSON;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.sys.api.entity.Organization;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.vo.OrganizationVO;
import com.kst.sys.api.vo.UserVO;
import com.kst.sys.mapper.OrganizationMapper;
import com.kst.sys.api.service.IOrganizationService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("organizationService")
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class OrganizationServiceImpl extends BaseService<OrganizationMapper, Organization> implements IOrganizationService {

    @Override
    public DataTable<UserVO> selectUserVOByPage(DataTable<UserVO> dt) {
        dt.setRows(this.baseMapper.selectUserVOByPage(dt));
        dt.setTotal(this.baseMapper.selectUserVOTotal(dt));
        return dt;
    }

    @Override
    public List<UserVO> selectUserVOByMap(Map<String, Object> params) {
        return this.baseMapper.selectUserVOByMap(params);
    }

    @Override
    public List<ZtreeVO> selectAll() {
        List<OrganizationVO> groups=this.baseMapper.selectOrganization(null);
        List<ZtreeVO> list= Lists.newArrayList();
        return getZTree(null,groups,list);
    }

    private  List<ZtreeVO> getZTree(ZtreeVO tree, List<OrganizationVO> total, List<ZtreeVO> result){
        Long pid = tree  ==null?null:tree.getId();
        List<ZtreeVO> childList = Lists.newArrayList();
        for (OrganizationVO m : total){
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

    @Override
    public Integer insertOrganization(Organization organization){
        organization.setId(this.baseMapper.selectMaxId());
        int i=this.baseMapper.insert(organization);
        if (organization.getLevel()==1){
            organization.setParentIds(organization.getId()+",");
        }else{
            Map<String,Object> param=new HashMap<>();
            param.put("id",organization.getParentId());
            OrganizationVO g=this.baseMapper.selectOrganization(param).get(0);
            organization.setParentIds(g.getParentIds()+organization.getId()+",");

        }
        this.baseMapper.updateById(organization);
        return i;
    }

    @Override
    public OrganizationVO selectOrganizationById(Long id) {
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        return this.baseMapper.selectOrganization(params).get(0);
    }

    @Override
    public Integer selectNameIsExist(Organization group) {
        return this.baseMapper.selectNameIsExist(group);
    }

    @Override
    public DataTable<UserVO> selectUserByPage(DataTable dt){
        List<UserVO>  users=this.baseMapper.selectUserByPage(dt);
        dt.setRows(users);
        dt.setTotal(this.baseMapper.selectUserTotal(dt));
        return dt;
    }

    @Override
    public List<UserVO> selectInorganizationUser(){
        return this.baseMapper.selectInorganizationUser();
    }

    @Override
    public Integer insertUserToOrganization(Long organizationId, Long userId) {
        return this.baseMapper.insertUserToOrganization(organizationId,userId);
    }

    @Override
    public Integer deleteUserFromOrganization(Long organizationId, Long userId) {
        return this.baseMapper.deleteUserFromOrganization(organizationId,userId);
    }

    @Override
    public List<UserVO> selectAllUserAndOrgan(Map<String,Object> params) {
        return this.baseMapper.selectAllUserAndOrgan(params);
    }

    @Override
    public OrganizationVO selectRootOrganization(Long id) {
        return this.baseMapper.selectRootOrganization(id);
    }

}
