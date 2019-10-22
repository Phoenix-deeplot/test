package com.kst.ams.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.kst.ams.entity.AssetExamine;
import com.kst.ams.entity.AssetInfo;
import com.kst.ams.mapper.AssetInfoMapper;
import com.kst.ams.service.IAssetInfoService;
import com.kst.ams.vo.AssetDiscardVO;
import com.kst.ams.vo.AssetExamineDetailVO;
import com.kst.ams.vo.AssetInfoVO;
import com.kst.ams.vo.AssetListVO;
import com.kst.common.base.service.impl.BaseService;
import com.kst.common.base.vo.DataTable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zjf
 * @since 2017-10-31
 */
@Service
@Transactional(readOnly = true, rollbackFor = Exception.class)
public class AssetInfoServiceImpl extends BaseService<AssetInfoMapper, AssetInfo> implements IAssetInfoService {

    @Override
    public int assetInfoCount(String key, String value) {
        QueryWrapper<AssetInfo> wrapper = new QueryWrapper<>();
        wrapper.eq(key,value);
        int count = baseMapper.selectCount(wrapper);
        return count;
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetInfo(AssetInfo assetInfo) {
        assetInfo.setDelFlag(true);
        baseMapper.updateById(assetInfo);
    }

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public void deleteAssetInfo(List<AssetInfo> assetInfos) {
        for (AssetInfo s : assetInfos){
            s.setDelFlag(true);
        }
        updateBatchById(assetInfos);
    }

    @Override
    public List<AssetInfo> getAll() {
        QueryWrapper<AssetInfo> wrapper = new QueryWrapper<>();
        return baseMapper.selectList(wrapper);
    }
    @Transactional(readOnly = false, rollbackFor = Exception.class)
    @Override
    public int updateTakeUserIdByNo(AssetInfo assetInfo) {
        int count = baseMapper.updateById(assetInfo);
        return count;
    }

    @Override
    public String noToPageNo(AssetInfo assetInfo) {
        if (assetInfo == null)
            return "";
        String inputNo = "";
        QueryWrapper<AssetInfo> wrapper = new QueryWrapper<>();
        wrapper.eq("no",assetInfo.getNo());
        AssetInfo resultInfo = baseMapper.selectOne(wrapper);
        if (resultInfo != null) {
            inputNo = resultInfo.getAssetInputNo();
        }

        return inputNo;
    }

    @Override
    public DataTable<AssetInfoVO> selectTakeOutAssetList(DataTable dt) {
        dt.setRows(this.baseMapper.selectTakeOutAsset(dt));
        dt.setTotal(this.baseMapper.selectTakeOutAssetTotal(dt));
        return dt;
    }

    @Override
    public Boolean selectSoftAmount(String assetNo) {
        return this.baseMapper.selectSoftAmount(assetNo);
    }

    @Override
    public List<AssetListVO> selectAssetList(Map<String, Object> params) {
        List<AssetListVO> list=this.baseMapper.selectAssetList(params);
        AssetListVO assetSum=new AssetListVO();
        assetSum.setName("合计");
        for (AssetListVO vo:list){
            Integer useAmount=0;
            Integer re1=this.baseMapper.selectSoftUseAmount(vo.getAssetInputNo());
            if(re1==0){
                useAmount=this.baseMapper.selectApplyUseAmount(vo.getAssetInputNo());
            }else{
                useAmount=re1;
            }
            vo.setPcInfo(this.baseMapper.selectPcInfo(vo.getAssetInputNo()));
            vo.setNetInfo(this.baseMapper.selectNetInfo(vo.getAssetInputNo()));
            vo.setSoftwareInfos(this.baseMapper.selectSoftInfo(vo.getAssetInputNo()));
            vo.setUseAmount(useAmount);
            vo.setUseRatio(String.format("%.2f",Double.valueOf(useAmount)/Double.valueOf(vo.getAmount())*100)+"%");
            assetSum.setAmount(assetSum.getAmount()+vo.getAmount());
            assetSum.setPrice(assetSum.getPrice()+vo.getPrice());
            assetSum.setUseAmount(assetSum.getUseAmount()+vo.getUseAmount());
        }
        list.add(assetSum);
        return list;
    }

    @Override
    public List<AssetListVO> selectAssetListDetail(Map<String, Object> params) {
        List<AssetListVO> list=this.baseMapper.selectAssetList(params);
        AssetListVO assetSum=new AssetListVO();
        assetSum.setName("合计");
        for (AssetListVO vo:list){
            Integer useAmount=0;
            Integer re1=this.baseMapper.selectSoftUseAmount(vo.getAssetInputNo());
            if(re1==0){
                useAmount=this.baseMapper.selectApplyUseAmount(vo.getAssetInputNo());
            }else{
                useAmount=re1;
            }
            vo.setPcInfo(this.baseMapper.selectPcInfo(vo.getAssetInputNo()));
            vo.setNetInfo(this.baseMapper.selectNetInfo(vo.getAssetInputNo()));
            vo.setSoftwareInfos(this.baseMapper.selectSoftInfo(vo.getAssetInputNo()));
            vo.setUseAmount(useAmount);
            vo.setUseRatio(String.format("%.2f",Double.valueOf(useAmount)/Double.valueOf(vo.getAmount())*100)+"%");
            assetSum.setAmount(assetSum.getAmount()+vo.getAmount());
            assetSum.setPrice(assetSum.getPrice()+vo.getPrice());
            assetSum.setUseAmount(assetSum.getUseAmount()+vo.getUseAmount());
        }
        list.add(assetSum);
        return list;
    }

    @Override
    public List<AssetExamineDetailVO> selectAssetExamine(String assetNo) {
        List<AssetExamineDetailVO> list=this.baseMapper.selectAssetExamine(assetNo);
        AssetExamineDetailVO detailVO=new AssetExamineDetailVO();
        detailVO.setName("合计");
        for (AssetExamineDetailVO vo:list){
            Integer useAmount=0;
            Integer re1=this.baseMapper.selectSoftUseAmount(vo.getAssetNo());
            if(re1==0){
                useAmount=this.baseMapper.selectApplyUseAmount(vo.getAssetNo());
            }else{
                useAmount=re1;
            }
            vo.setUseAmount(useAmount);
            detailVO.setUseAmount(detailVO.getUseAmount()+vo.getUseAmount());
            detailVO.setAmount(detailVO.getAmount()+vo.getAmount());
        }
        list.add(detailVO);

        return list;
    }

    @Override
    public List<AssetDiscardVO> selectAssetDiscardByDate(Map<String,Object> params) {
        List<AssetDiscardVO> list=this.baseMapper.selectAssetDiscardByDate(params);
        AssetDiscardVO sumDiscard=new AssetDiscardVO();
        sumDiscard.setName("合计");
        for (AssetDiscardVO vo:list){
            sumDiscard.setAmount(sumDiscard.getAmount()+vo.getAmount());
            sumDiscard.setPrice(sumDiscard.getPrice()+vo.getPrice());
        }
        list.add(sumDiscard);
        return list;
    }

    @Override
    public List<AssetInfoVO> selectCSVData(Map<String, Object> params) {
        return this.baseMapper.selectCSVData(params);
    }
}
