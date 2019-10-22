package com.kst.activiti.service;

import com.kst.activiti.dto.ActApplyWorkFlow;
import com.kst.activiti.vo.MyApplyVO;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;

import java.util.List;

/**
 * 申请服务接口
 */
public interface MyApplyService extends IBaseService<ActApplyWorkFlow> {
    /**新增
     * @param pd
     * @throws Exception
     */
    public void save(DataTable pd)throws Exception;

    /**删除
     * @param pd
     * @throws Exception
     */
    public void delete(DataTable pd)throws Exception;

    /**修改
     * @param pd
     * @throws Exception
     */
    public void edit(DataTable pd)throws Exception;

    /**列表
     * @param page
     * @throws Exception
     */
    public List<MyApplyVO> list(DataTable page)throws Exception;

    /**通过id获取数据
     * @param pd
     * @throws Exception
     */
    public ActApplyWorkFlow findById(DataTable pd)throws Exception;

    /**批量删除
     * @param ArrayDATA_IDS
     * @throws Exception
     */
    public void deleteAll(String[] ArrayDATA_IDS)throws Exception;

}
