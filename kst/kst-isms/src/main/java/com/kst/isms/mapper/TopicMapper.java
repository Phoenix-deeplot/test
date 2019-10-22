package com.kst.isms.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.isms.entity.Question;
import com.kst.isms.entity.Topic;
import com.kst.sys.api.entity.User;
import com.kst.sys.api.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 问题表 Mapper 接口
 * </p>
 *
 * @author lxm
 * @since 2019-5-28
 */
@Mapper
public interface TopicMapper extends BaseMapper<Topic> {

    List<Topic> selectTopicPage(DataTable dt);

    Integer selectFinishUserTopic(Long topicId);

    List<UserVO> selectUserTopic(Long topicId);

    Integer selectTopicTotal(DataTable dt);

    Integer insertUserTopic(@Param("userId") Long userId, @Param("topicId") Long topicId);

    void deleteUserTopic(@Param("userId") Long userId,@Param("topicId") Long topicId);

    List<Long> selectUserIds(Long topicId);
}