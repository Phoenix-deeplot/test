package com.kst.isms.service.impl;


import com.kst.common.base.service.impl.BaseService;
import com.kst.isms.entity.QuestionItem;
import com.kst.isms.mapper.QuestionItemMapper;
import com.kst.isms.service.IQuestionItemService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 字典表 服务实现类
 * </p>
 *
 * @author zjf
 * @since 2017-11-26
 */
@Service
public class QuestionItemServiceImpl extends BaseService<QuestionItemMapper, QuestionItem> implements IQuestionItemService {

}
