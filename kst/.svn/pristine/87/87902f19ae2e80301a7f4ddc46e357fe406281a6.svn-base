package com.kst.isms.service;

import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.isms.entity.Question;
import com.kst.isms.entity.Topic;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.vo.UserVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

public interface ITopicService extends IBaseService<Topic> {

    String getFinishDegree(Long topicId);

    DataTable<Topic> selectTopicPage(DataTable dt);

    Integer insertUserTopic(Long userId,Long topicId);

    void deleteUserTopic(Long userId,Long topicId);

    List<UserVO> selectUserFromUserTopic(Long topicId);

    List<Long> selectUserIds(Long topicId);

}
