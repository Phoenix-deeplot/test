package com.kst.sys.service.impl;

import com.google.common.collect.Lists;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.ZtreeVO;
import com.kst.common.constant.Setting;
import com.kst.sys.api.entity.Directory;
import com.kst.sys.api.entity.Resource;
import com.kst.sys.api.vo.DirectoryVO;
import com.kst.sys.mapper.DirectoryMapper;
import com.kst.sys.api.service.IDirectoryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("directoryService")
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class DirectoryServiceImpl extends BaseService<DirectoryMapper, Directory> implements IDirectoryService {

    @Override
    public List<ZtreeVO> selectAll() {
        List<DirectoryVO> directories=baseMapper.selectDirectory(null);
        List<ZtreeVO> list= Lists.newArrayList();
        return getZTree(null,directories,list);
    }

    //转换为ztree
    private  List<ZtreeVO> getZTree(ZtreeVO tree, List<DirectoryVO> total, List<ZtreeVO> result){
        Long pid = tree  ==null?null:tree.getId();
        List<ZtreeVO> childList = Lists.newArrayList();
        for (DirectoryVO m : total){
            if(String.valueOf(m.getParentId()).equals(String.valueOf(pid))) {
                ZtreeVO ztreeVO = new ZtreeVO();
                ztreeVO.setId(m.getId());
                ztreeVO.setName(m.getName());
                ztreeVO.setPid(pid);
                ztreeVO.setIsParent(true);
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
    public Integer updateDirectoryById(Directory directory) {
        return baseMapper.updateById(directory);
    }

    @Override
    public Integer insertDirectory(Directory directory) {
        directory.setId(this.baseMapper.selectMaxId());
        int i=this.baseMapper.insert(directory);
        Long time=new Date().getTime();
        if (directory.getLevel()==1){
            directory.setParentIds(directory.getId()+",");
            directory.setUrl("/"+ Setting.BASEFLODER+"/directory/"+time);
        }else{
            Map<String,Object> param=new HashMap<>();
            param.put("id",directory.getParentId());
            DirectoryVO g=this.baseMapper.selectDirectory(param).get(0);
            directory.setParentIds(g.getParentIds()+directory.getId()+",");
            directory.setUrl(g.getUrl()+"/"+time);
        }
        System.out.println("路径："+directory.getUrl());

        File d = new File("");// 参数为空
        String courseFile = null;
        try {
            courseFile = d.getCanonicalPath();
        } catch (IOException e) {
            e.printStackTrace();
        }
        File file=new File(courseFile+directory.getUrl());
        if(file.mkdirs()){
            System.out.println("创建路径成功");
        }else{
            System.out.println("创建路径失败");
        }
        this.baseMapper.updateById(directory);
        return i;
    }

    @Override
    public Integer deleteDirectory(Directory directory) {
        return this.baseMapper.deleteDirectory(directory);
    }

    @Override
    public DirectoryVO selectDirectoryById(Long id) {
        Map<String,Object> params=new HashMap<>();
        params.put("id",id);
        return this.baseMapper.selectDirectory(params).get(0);
    }

    @Override
    public Integer selectNameIsExist(Directory directory) {
        return this.baseMapper.selectNameIsExist(directory);
    }

    @Override
    public Integer insertDirectoryResource(Long directoryId, Long resourceId) {
        return this.baseMapper.insertDirectoryResource(directoryId,resourceId);
    }

    @Override
        public Integer deleteDirectoryResource(Long directoryId, Long resourceId) {
        Resource r=new Resource();
        r.setDelFlag(true);
        r.setId(resourceId);
        return this.baseMapper.deleteDirectoryResource(directoryId,resourceId);
    }

}
