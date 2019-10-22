package com.kst.sys.utils;

import java.util.*;

public final class RfidLabel {

    private static final int MAX_CAPACITY = 1000;// 最大容量
    private static final Hashtable<String , Object> map = new Hashtable<>();

    private static  final Set<String> epcs=new HashSet<>();

    private static RfidLabel cache = null;

    private RfidLabel(){};
    /**
     * 获取该类实例
     */
    public synchronized static RfidLabel getSimpleCache(){
        if(cache==null){
            cache = new RfidLabel();
        }
        return cache;
    }

    /**
     * 检查是否存在在key
     * @param key 键名称
     * @return  true 或 false
     */
    public boolean contains(String key) {
        return map.contains(key);
    }

    /**
     * 删除指定key
     * @param key 键名称
     */
    public void remove(String key) {
        map.remove(key);
    }
    /**
     * 清空缓存
     */
    public void rmoveAll (){
        map.clear();
    }
    /**
     * 根据指定的键值获取对应的val
     * @param key
     *      指定的键值
     * @return
     *      返回该key对应的Object值
     */
    public Object get (String key){
        return map.get(key);
    }
    /**
     * 获取所有缓存
     * @return Map集合
     */
    public Map<String , Object> getAll() {
        Map<String , Object> hashMap = new HashMap<>();
        Enumeration<String> keys = map.keys();
        while(keys.hasMoreElements()) {
            String key = keys.nextElement();
            Object val = map.get(key);
            hashMap.put(key, val);
        }
        return hashMap;
    }
    /**
     * 将key映射到val加入缓存对象中
     * @param key
     *          名称
     * @param val
     *          该名称对应的Object数据
     */
    public void put (String key,Object val){
        if (val == null) {
            throw new NullPointerException();
        }
        if(map.size()>= MAX_CAPACITY){
            map.clear();
            map.put(key, val);
        }
        if(map.containsKey(key)){
            return ;
        }
        map.put(key, val);
    }

    /**
     * 存入byte数组
     * @param epc
     */
    public void setEpcs(String epc){
        epcs.add(epc);
    }

    public void removeAllEpcs(){
        epcs.clear();
    }

    /**
     * 判断是否存在于epcs中
     * @param epc
     * @return
     */
    public boolean isConstainsEpcs(String epc){
        return epcs.contains(epc);
    }


}
