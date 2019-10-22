package com.kst.isms.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.common.base.vo.DataTable;
import com.kst.isms.entity.Question;
import com.kst.isms.vo.QuestionVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
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
public interface QuestionMapper extends BaseMapper<Question> {

    List<QuestionVO> selectQuestionList(DataTable dt);

    Integer selectQuestionTotal(DataTable dt);

    QuestionVO selectQuestionById(Long id);

    List<QuestionVO> selectQuestionByTopicId(Map<String,Object> params);

    List<String> selectIds(Long id);

    List<QuestionVO> selectAutoQuestions(Map<String,Object> params);

    void insertTopicQuestion(@Param("topicId") Long topicId, @Param("questions") Set<Question> questions);

    Integer deleteTopicQuestion(Long topicId);

}