package com.kst.pjs.service.impl;

import com.google.common.collect.Lists;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.pjs.entity.ProjectGroup;
import com.kst.pjs.mapper.ProjectGroupMapper;
import com.kst.pjs.service.IProjectGroupService;
import com.kst.sys.api.entity.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ProjectGroupServiceImpl extends BaseService<ProjectGroupMapper, ProjectGroup> implements IProjectGroupService {
    @Override
    public List<ZtreeVO> selectProjectGroupTree(Map<String, Object> params) {
        List<ProjectGroup> groups=this.baseMapper.selectProjectGroup(params);
        List<ZtreeVO> list= Lists.newArrayList();
        return getZTree(null,groups,list);
    }

    @Override
    public List<ProjectGroup> selectProjectGroup(Map<String, Object> params) {
        return this.baseMapper.selectProjectGroup(params);
    }

    @Override
    public Integer insertProjectGroup(ProjectGroup projectGroup) {
        projectGroup.setId(this.baseMapper.selectMaxId());
        Integer i=this.baseMapper.insert(projectGroup);
        if (projectGroup.getLevel()==1){
            projectGroup.setParentIds(projectGroup.getId()+",");
        }else{
            Map<String,Object> param=new HashMap<>();
            param.put("id",projectGroup.getParentId());
            ProjectGroup g=this.baseMapper.selectProjectGroup(param).get(0);
            projectGroup.setParentIds(g.getParentIds()+projectGroup.getId()+",");

        }
        this.baseMapper.updateById(projectGroup);
        return i;
    }

    @Override
    public List<User> selectUserByPjId(Long pjId) {
        Map<String,Object> params=new HashMap<>();
        params.put("pjId",pjId);
        return this.baseMapper.selectUserByPjId(params);
    }

    @Override
    public DataTable<User> selectProjectGroupUserPage(DataTable dt) {
        dt.setRows(this.baseMapper.selectProjectUserByPage(dt));
        dt.setTotal(this.baseMapper.selectProjectUserTotal(dt));
        return dt;
    }

    @Override
    public List<Long> selectDistinct() {
        return this.baseMapper.selectDistinctId();
    }

    private  List<ZtreeVO> getZTree(ZtreeVO tree, List<ProjectGroup> total, List<ZtreeVO> result){
        Long pid = tree  ==null?null:tree.getId();
        List<ZtreeVO> childList = Lists.newArrayList();
        for (ProjectGroup m : total){
            if(String.valueOf(m.getParentId()).equals(String.valueOf(pid))) {
                ZtreeVO ztreeVO = new ZtreeVO();
                ztreeVO.setId(m.getId());
                ztreeVO.setName(m.getNickName()+"("+m.getPosition()+")");
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


}
