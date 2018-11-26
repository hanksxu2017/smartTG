package cn.com.smart.web.cache.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import org.apache.commons.lang3.StringUtils;

import cn.com.smart.cache.InitCache;
import cn.com.smart.res.sqlmap.LoadingSQLMapFile;
import cn.com.smart.res.sqlmap.SQLMapException;
import cn.com.smart.res.sqlmap.SQLMapFile;
import cn.com.smart.web.bean.entity.TNSqlResource;
import cn.com.smart.web.service.SqlResourceService;

/**
 * SQL资源缓存
 * @author XUWENYI  2017年12月3日
 * @version 1.0
 * @since JDK1.7
 */
@Component
public class SqlResourceMemoryCache implements InitCache {

    private static final Logger logger = LoggerFactory.getLogger(SqlResourceMemoryCache.class);
    @Autowired
    private SqlResourceService sqlResourceServ;
    
    @Override
    public void initCache() {
        try {
            List<TNSqlResource> sqlResources = sqlResourceServ.findAll().getDatas();
            if(CollectionUtils.isNotEmpty(sqlResources)) {
                SQLMapFile sqlMapFile = LoadingSQLMapFile.getInstance().getDbSqlMap();
                Map<String, String> sqlMaps = sqlMapFile.getSqlMaps();
                if(null == sqlMaps) {
                    sqlMaps = new HashMap<String, String>();
                    sqlMapFile.setSqlMaps(sqlMaps);
                }
                for (TNSqlResource sqlRes : sqlResources) {
                    if(!sqlMaps.containsKey(sqlRes.getResName())) {
                        sqlMaps.put(sqlRes.getResName(), sqlRes.getSql());
                    }
                }
            }
        } catch (SQLMapException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 添加或更新SQL资源
     * @param resName 资源名称
     * @param sql SQL语句
     */
    public synchronized void addOrUpdate(String resName, String sql) {
        if(StringUtils.isEmpty(resName) || StringUtils.isEmpty(sql)) {
            return;
        }
        try {
            SQLMapFile sqlMapFile = LoadingSQLMapFile.getInstance().getDbSqlMap();
            Map<String, String> sqlMaps = sqlMapFile.getSqlMaps();
            sqlMaps.put(resName, sql);
        } catch (SQLMapException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 删除资源
     * @param resName 资源名称
     */
    public synchronized void remove(String resName) {
        if(StringUtils.isEmpty(resName)) {
            return;
        }
        try {
            SQLMapFile sqlMapFile = LoadingSQLMapFile.getInstance().getDbSqlMap();
            Map<String, String> sqlMaps = sqlMapFile.getSqlMaps();
            sqlMaps.remove(resName);
        } catch (SQLMapException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void refreshCache() {
        throw new UnsupportedOperationException("在方法不支持操作");
    }

    
    
}
