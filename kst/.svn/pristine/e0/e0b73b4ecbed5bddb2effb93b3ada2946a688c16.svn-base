package com.kst.isms.service.impl;

import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.isms.entity.Question;
import com.kst.isms.entity.Topic;
import com.kst.isms.mapper.TopicMapper;
import com.kst.isms.service.ITopicService;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.vo.UserVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

@Service
public class TopicServiceImpl extends BaseService<TopicMapper, Topic> implements ITopicService {

    @Override
    public String getFinishDegree(Long topicId) {
        Integer finish=this.baseMapper.selectFinishUserTopic(topicId);
        Integer all=this.baseMapper.selectUserTopic(topicId).size();
        String finishDegree=finish+"/"+all;
        return finishDegree;
    }

    @Override
    public DataTable<Topic> selectTopicPage(DataTable dt) {
        dt.setRows(this.baseMapper.selectTopicPage(dt));
        dt.setTotal(this.baseMapper.selectTopicTotal(dt));
        return dt;
    }

    @Override
    public Integer insertUserTopic(Long userId, Long topicId) {
        return this.baseMapper.insertUserTopic(userId,topicId);
    }

    @Override
    public void deleteUserTopic(Long userId,Long topicId) {
        this.baseMapper.deleteUserTopic(userId,topicId);
    }

    @Override
    public List<UserVO> selectUserFromUserTopic(Long topicId) {
        return this.baseMapper.selectUserTopic(topicId);
    }

    @Override
    public List<Long> selectUserIds(Long topicId) {
        return this.baseMapper.selectUserIds(topicId);
    }
}
