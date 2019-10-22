package com.kst.sys.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.common.base.service.impl.BaseService;
import com.kst.sys.api.entity.ModulePara;
import com.kst.sys.api.service.IModuleParaService;

import com.kst.sys.mapper.ModuleParaMapper;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class ModuleServiceParaImpl extends BaseService<ModuleParaMapper, ModulePara> implements IModuleParaService {

    @Override
    public boolean getModuleUseFlag(String moduleNo) {
        boolean ret=false;
        QueryWrapper wrapper=new QueryWrapper();
        wrapper.eq("para_id","moduleData");
        ModulePara modulePara=this.baseMapper.selectOne(wrapper);
        JSONObject jsonObject=JSONObject.fromObject(modulePara.getParaJson());
        Map<String,String> map=jsonObject;
        String val=map.get(moduleNo);
        if(val==null || val==""){
            ret=false;
        }else{
            if(val.equals("1")){
                ret=true;
            }
        }
        return ret;
    }
}
