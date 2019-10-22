package com.kst.sys.service.impl;

import com.google.common.collect.Lists;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.entity.UserGroup;
import com.kst.sys.api.service.IUserGroupService;
import com.kst.sys.api.vo.OrganizationVO;
import com.kst.sys.api.vo.UserVO;
import com.kst.sys.mapper.UserGroupMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class UserGroupServiceImpl extends BaseService<UserGroupMapper, UserGroup> implements IUserGroupService{
    @Override
    public List<ZtreeVO> selectAllUserGroup() {
        List<UserGroup> groups=this.baseMapper.selectUserGroup(null);
        List<ZtreeVO> list= Lists.newArrayList();
        return getZTree(null,groups,list);
    }

    @Override
    public UserGroup selectUserGroupById(Long id) {
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        return this.baseMapper.selectUserGroup(params).get(0);
    }

    private  List<ZtreeVO> getZTree(ZtreeVO tree, List<UserGroup> total, List<ZtreeVO> result){
        Long pid = tree  ==null?null:tree.getId();
        List<ZtreeVO> childList = Lists.newArrayList();
        for (UserGroup m : total){
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
    public List<UserVO> selectAllUserAndUserGroup(List<User> list) {
        return null;
    }

    @Override
    public Integer insertUserGroup(UserGroup userGroup) {
        userGroup.setId(this.baseMapper.selectMaxId());
        int i=this.baseMapper.insert(userGroup);
        if (userGroup.getLevel()==1){
            userGroup.setParentIds(userGroup.getId()+",");
        }else{
            Map<String,Object> param=new HashMap<>();
            param.put("id",userGroup.getParentId());
            UserGroup g=this.baseMapper.selectUserGroup(param).get(0);
            userGroup.setParentIds(g.getParentIds()+userGroup.getId()+",");

        }
        this.baseMapper.updateById(userGroup);
        return i;
    }

    @Override
    public Integer selectNameIsExist(UserGroup userGroup) {
        return this.baseMapper.selectNameIsExist(userGroup);
    }

    @Override
    public DataTable<UserVO> selectUserByPage(DataTable dt){
        List<UserVO>  users=this.baseMapper.selectUserByPage(dt);
        dt.setRows(users);
        dt.setTotal(this.baseMapper.selectUserTotal(dt));
        return dt;
    }

    @Override
    public Integer insertUserToUserGroup(Long groupId, Long userId) {
        return baseMapper.insertUserToUserGroup(groupId,userId);
    }

    @Override
    public Integer deleteUserFromUserGroup(Long groupId, Long userId) {
        return baseMapper.deleteUserFromUserGroup(groupId,userId);
    }

    @Override
    public List<UserVO> selectUserOfUserGroup(Map<String,Object> params) {
        return this.baseMapper.selectUserOfUserGroup(params);
    }
}
