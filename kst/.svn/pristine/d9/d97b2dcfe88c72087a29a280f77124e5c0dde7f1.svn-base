package com.kst.isms.service.impl;


import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.isms.entity.Question;
import com.kst.isms.vo.QuestionVO;
import com.kst.isms.mapper.QuestionMapper;
import com.kst.isms.service.IQuestionService;
import org.apache.commons.lang3.Conversion;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * <p>
 * 字典表 服务实现类
 * </p>
 *
 * @author zjf
 * @since 2017-11-26
 */
@Service
public class QuestionServiceImpl extends BaseService<QuestionMapper, Question> implements IQuestionService {


    @Override
    public DataTable<QuestionVO> selectQuestionList(DataTable dt) {
        dt.setRows(this.baseMapper.selectQuestionList(dt));
        dt.setTotal(this.baseMapper.selectQuestionTotal(dt));
        return dt;
    }

    @Override
    public QuestionVO selectQuestionById(Long id) {

        return baseMapper.selectQuestionById(id);
    }

    @Override
    public List<QuestionVO> selectQuestionByTopicId(Map<String,Object> params) {
        return this.baseMapper.selectQuestionByTopicId(params);
    }

    @Override
    public List<Long> selectIds(Long id) {
        List<String> list= this.baseMapper.selectIds(id);
        List<Long> ids=new ArrayList<>();
        for(String str : list) {
            Long i = Long.parseLong(str);
            ids.add(i);
        }
        return ids;
    }

    @Override
    public List<QuestionVO> selectAutoQuestions(Map<String, Object> params) {
        return this.baseMapper.selectAutoQuestions(params);
    }

    @Override
    public void insertTopicQuestion(Long topicId, Set<Question> questions) {
        baseMapper.insertTopicQuestion(topicId,questions);
    }

    @Override
    public Integer deleteTopicQuestion(Long topicId){
        return this.baseMapper.deleteTopicQuestion(topicId);
    }
}
