package cn.com.smart.dao.impl;

import cn.com.smart.bean.BaseBean;
import cn.com.smart.dao.IBaseDao;
import cn.com.smart.exception.DaoException;
import cn.com.smart.web.utils.DataUtil;
import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 基础Dao实现类
 * @author XUWENYI
 * @version 1.0
 * @since JDK版本大于等于1.6
 * 
 * 2015年8月22日
 * @param <T>
 */
public abstract class BaseDaoImpl<T extends BaseBean> extends UpdateDaoImpl<T> implements IBaseDao<T>{

	@Override
	public int getSortOrder(Serializable id) throws DaoException {
		int sortOrder = 1;
		Map<String,Object> param = null;
		String hql = "select max(sortOrder) from "+clazz.getName();
		if(null != id && StringUtils.isNotEmpty(id.toString())) {
			hql = hql+" where parentId=:id";
			param = new HashMap<String, Object>();
			param.put("id", id);
		}
		List<Object> lists = queryObjHql(hql,param);
		if(null != lists && lists.size()>0) {
			try {
			  Object obj = lists.get(0);
			  if(DataUtil.isDecimal(obj.toString())) {
				  sortOrder = (int)Double.parseDouble(obj.toString());
			  } else {
				  sortOrder = Integer.parseInt(obj.toString());
			  }
			  sortOrder++;
			} catch (Exception e) {
				sortOrder = 1;
			}
		}
		return sortOrder;
	}
	
}
