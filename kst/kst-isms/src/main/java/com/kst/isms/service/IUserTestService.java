package com.kst.isms.service;

import com.kst.common.base.service.IBaseService;
import com.kst.isms.entity.UserTest;

import java.util.List;

public interface IUserTestService extends IBaseService<UserTest> {

    UserTest selectHistoryTest(Long userId,Long topicId);

}
