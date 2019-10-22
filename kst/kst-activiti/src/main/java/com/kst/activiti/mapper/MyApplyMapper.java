package com.kst.activiti.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kst.activiti.dto.ActApplyWorkFlow;
import com.kst.activiti.vo.MyApplyVO;
import com.kst.common.base.vo.DataTable;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
public interface MyApplyMapper extends BaseMapper<ActApplyWorkFlow> {
    /**列表
     * @param dt
     * @throws Exception
     */
    List<MyApplyVO> datalistPage(DataTable dt);

    /**新增
     * @param dt
     * @throws Exception
     */
     void save(DataTable dt)throws Exception;

    /**删除
     * @param pd
     * @throws Exception
     */
     void delete(DataTable pd)throws Exception;

    /**修改
     * @param pd
     * @throws Exception
     */
     void edit(DataTable pd)throws Exception;

    /**通过id获取数据
     * @param pd
     * @throws Exception
     */
     MyApplyVO findById(DataTable pd)throws Exception;

    /**批量删除
     * @param ArrayDATA_IDS
     * @throws Exception
     */
     void deleteAll(String[] ArrayDATA_IDS)throws Exception;
}
