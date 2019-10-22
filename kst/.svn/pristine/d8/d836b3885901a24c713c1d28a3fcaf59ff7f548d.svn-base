package com.kst.isms.service;


import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.isms.entity.Question;
import com.kst.isms.vo.QuestionVO;

import java.util.List;
import java.util.Map;
import java.util.Set;


public interface IQuestionService extends IBaseService<Question> {
    DataTable<QuestionVO> selectQuestionList(DataTable dt);

    QuestionVO selectQuestionById(Long id);

    List<QuestionVO> selectQuestionByTopicId(Map<String,Object> params);

    List<Long> selectIds(Long id);

    List<QuestionVO> selectAutoQuestions(Map<String,Object> params);

    void insertTopicQuestion(Long topicId, Set<Question> questions);

    Integer deleteTopicQuestion(Long topicId);
}
