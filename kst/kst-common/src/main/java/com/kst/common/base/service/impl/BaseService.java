package com.kst.common.base.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.enums.SqlLike;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kst.common.base.service.IBaseService;
import com.kst.common.base.vo.DataTable;
import com.kst.common.constant.SearchParam;
import com.kst.common.utils.StringUtils;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;

/**
 * @author chen
 */
public class BaseService<M extends BaseMapper<T>, T> extends ServiceImpl<M, T> implements IBaseService<T> {

    /**
     * 是否加载 查询条件
     *
     * @param cnd
     * @param k
     * @param v
     * @return
     */
    protected boolean idLoadCnd(String cnd, String k, Object v) {
        return k.startsWith(cnd) && null != v && v.toString().length() > 0;
    }

    /**
     * 加载 搜索条件
     *
     * @param params
     * @param wrapper
     */
    private void loadSearchParam(Map<String, Object> params, QueryWrapper<T> wrapper) {
        if (!CollectionUtils.isEmpty(params)) {
            params.forEach((searchKey, param) -> {
                if (idLoadCnd(SearchParam.SEARCH_EQ, searchKey, param)) {
                    wrapper.eq(searchKey.split(SearchParam.SEARCH_EQ)[1], param);
                } else if (idLoadCnd(SearchParam.SEARCH_LLIKE, searchKey, param)) {
                    wrapper.likeLeft(searchKey.split(SearchParam.SEARCH_LLIKE)[1], String.valueOf(param));
                } else if (idLoadCnd(SearchParam.SEARCH_RLIKE, searchKey, param)) {
                    wrapper.likeRight(searchKey.split(SearchParam.SEARCH_RLIKE)[1], String.valueOf(param));
                } else if (idLoadCnd(SearchParam.SEARCH_LIKE, searchKey, param)) {
                    wrapper.like(searchKey.split(SearchParam.SEARCH_LIKE)[1], String.valueOf(param));
                }else if (idLoadCnd(SearchParam.SEARCH_IN, searchKey, param)) {
                    wrapper.in(searchKey.split(SearchParam.SEARCH_IN)[1], (List)param);
                }else if (idLoadCnd(SearchParam.SEARCH_NOT_IN, searchKey, param)) {
                    wrapper.notIn(searchKey.split(SearchParam.SEARCH_NOT_IN)[1], (List)param);
                }else if (idLoadCnd(SearchParam.SEARCH_NE, searchKey, param)) {
                    wrapper.ne(searchKey.split(SearchParam.SEARCH_NE)[1], String.valueOf(param));
                }else if (idLoadCnd(SearchParam.SEARCH_ISNULL, searchKey, param)) {
                    wrapper.isNull(searchKey.split(SearchParam.SEARCH_ISNULL)[1]);
                }
            });
        }
    }

    /**
     * 加载 排序条件
     */
    private void loadSort(Map<String, String> sorts, QueryWrapper<T> wrapper) {
        if (!CollectionUtils.isEmpty(sorts)) {
            sorts.forEach((column, sort) -> {
                if ("asc".equalsIgnoreCase(sort)) {
                    wrapper.orderByAsc(StringUtils.humpToLine(column));
                } else {
                    wrapper.orderByDesc(StringUtils.humpToLine(column));
                }
            });
        }
    }

    /**
     * 分页 搜索
     *
     * @param dt
     * @return
     */
    @Override
    public DataTable<T> pageSearch(DataTable<T> dt) {
        Page<T> page = new Page<>(dt.getPageNumber(), dt.getPageSize());
        QueryWrapper<T> wrapper = new QueryWrapper<>();
        loadSearchParam(dt.getSearchParams(), wrapper);
        loadSort(dt.getSorts(), wrapper);
        wrapper.eq("del_flag",false);
        page(page, wrapper);
        //int count = count(wrapper);
        dt.setTotal((int)page.getTotal());
        dt.setRows(page.getRecords());
        return dt;
    }
}
