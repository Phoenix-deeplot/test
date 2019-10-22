package com.kst.isms.service.impl;

import com.kst.common.base.service.impl.BaseService;
import com.kst.isms.entity.UserTest;
import com.kst.isms.mapper.UserTestMapper;
import com.kst.isms.service.IUserTestService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserTestServiceImpl extends BaseService<UserTestMapper, UserTest> implements IUserTestService {
    @Override
    public UserTest selectHistoryTest(Long userId,Long topicId) {
        Map<String,Object> params=new HashMap<>();
        params.put("userId",userId);
        params.put("topicId",topicId);
        return this.baseMapper.selectHistoryTest(params);
    }
}
