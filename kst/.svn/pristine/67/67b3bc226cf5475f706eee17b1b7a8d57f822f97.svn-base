package com.kst.ams.service.impl;

import com.alibaba.fastjson.JSON;
import com.kst.ams.mapper.ChartMapper;
import com.kst.ams.service.IChartService;
import com.kst.ams.vo.ChartVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.sys.api.entity.Dict;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class ChartServiceImpl implements IChartService {

    @Resource
    private ChartMapper chartMapper;

    @Override
    public List<ChartVO> selectPieData(Map<String, Object> params) {
        return this.chartMapper.selectPieData(params);
    }

    @Override
    public List<ChartVO> selectUseRatio(Map<String, Object> params) {
        return this.chartMapper.selectUseRatio(params);
    }

    @Override
    public List<ChartVO> selectDivideAssetOnLastYear(List<Dict> dicts,Date selectDate) {
        List<ChartVO> retList=new ArrayList<>();
        for (Dict dict:dicts){
            ChartVO c=new ChartVO();
            c.setClassifyName(dict.getLabel());
            Map<String,Object> params=new HashMap<>();
            params.put("classifyId",dict.getValue());
            params.put("selectDate",selectDate);
            List<ChartVO> list=this.chartMapper.selectDivideAssetOnLastYear(params);
            List<ChartVO> list1=this.chartMapper.selectAssetByLastYear(params);
            List<Double> priceList=new ArrayList<>();
            List<Integer> amountList=new ArrayList<>();
            List<Double> allPriceList=new ArrayList<>();
            List<Integer> allAmountList=new ArrayList<>();

            for (ChartVO chartVO:list){
                priceList.add(chartVO.getPrice());
                amountList.add(chartVO.getAmount());
                boolean re=false;
                ChartVO vo=new ChartVO();
                for (ChartVO chartVO2:list1){
                    if(chartVO2.getYymm().equals(chartVO.getYymm())){
                        vo=chartVO2;
                        re=true;
                    }
                }
                if(re){
                    allPriceList.add(chartVO.getPrice()+vo.getPrice());
                    allAmountList.add(chartVO.getAmount()+vo.getAmount());
                }else{
                    allPriceList.add(chartVO.getPrice());
                    allAmountList.add(chartVO.getAmount());
                }
            }
            c.setEveryMonthPrice(priceList);
            c.setEveryMonthAmount(amountList);
            c.setEveryMonthAllPrice(allPriceList);
            c.setEveryMonthAllAmount(allAmountList);
            retList.add(c);
        }
        return retList;
    }

    @Override
    public List<ChartVO> selectNextYearAssetData(List<Dict> dicts, Date selectDate) {
        System.out.println("进入查询bar数据");
        List<ChartVO> retList=new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
        for (Dict dict:dicts){
            ChartVO chartVO=new ChartVO();
            List<Double> assetPrice=new ArrayList<>();
            List<Integer> assetAmount=new ArrayList<>();
            List<Double> dividePrice=new ArrayList<>();
            List<String> xText=new ArrayList<>();

            Map<String,Object> params=new HashMap<>();
            params.put("selectDate",selectDate);
            params.put("classifyId",dict.getValue());
            params.put("type",1);
            List<ChartVO> assetList=this.chartMapper.selectAssetByNextYear(params);
            params.put("type",2);
            List<ChartVO> divideAssetList=this.chartMapper.selectAssetByNextYear(params);
            Calendar date = Calendar.getInstance();
            date.setTime(selectDate);
            //循环十二个月
            for (int i=0;i<12;i++){
                boolean ret=false;
                ChartVO temp=new ChartVO();
                for (ChartVO c:assetList){
                    if(sdf.format(date.getTime()).equals(c.getYymm())){
                        ret=true;
                        temp=c;
                    }
                }
                if(ret){
                    assetPrice.add(temp.getPrice());
                    assetAmount.add(temp.getAmount());
                }else{
                    assetPrice.add(0.0);
                    assetAmount.add(0);
                }

                temp=new ChartVO();
                ret=false;
                for (ChartVO c:divideAssetList){
                    if(sdf.format(date.getTime()).equals(c.getYymm())){
                        ret=true;
                        temp=c;
                    }
                }

                if(ret){
                    dividePrice.add(temp.getPrice());
                }else{
                    dividePrice.add(0.0);
                }
                date.add(Calendar.MONTH, 1);
            }
            chartVO.setClassifyName(dict.getLabel());
            chartVO.setEveryMonthAllPrice(assetPrice);
            chartVO.setEveryMonthAllAmount(assetAmount);
            chartVO.setEveryMonthPrice(dividePrice);
            retList.add(chartVO);
        }
        return retList;
    }
}
