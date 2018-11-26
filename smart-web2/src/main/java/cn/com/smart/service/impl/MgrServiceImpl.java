package cn.com.smart.service.impl;

import java.io.Serializable;
import java.util.*;

import cn.com.smart.bean.BaseBean;
import cn.com.smart.bean.BaseBeanImpl;
import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.exception.DaoException;
import cn.com.smart.exception.ServiceException;
import cn.com.smart.res.SQLResUtil;
import cn.com.smart.service.IMgrService;
import cn.com.smart.web.utils.DataUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;

/**
 * 管理服务实现类
 * @author XUWENYI
 * @version 1.0
 * @since 1.0
 *
 */
public abstract class MgrServiceImpl<T extends BaseBean> extends BaseEntityServiceImpl<T> implements IMgrService<T> {
	
	@Override
	public SmartResponse<String> save(T t) throws ServiceException {
		SmartResponse<String> fsResp = new SmartResponse<String>();
		fsResp.setMsg("保存失败");
		if(null != t) {
			try {
				Serializable id = getDao().save(t);
				if(null != id) {
					fsResp.setResult(OP_SUCCESS);
					fsResp.setMsg("保存成功");
					fsResp.setData(id.toString());
				}
			} catch(DaoException ex) {
				throw new ServiceException(ex.fillInStackTrace());
			}
		}
		return fsResp;
	}

	@Override
	public SmartResponse<String> save(BaseBeanImpl bean) throws ServiceException {
		SmartResponse<String> fsResp = new SmartResponse<String>();
		fsResp.setMsg("保存失败");
		if(null != bean) {
			try {
				Serializable id = getOPDao().saveObj(bean);
				if(null != id) {
					fsResp.setResult(OP_SUCCESS);
					fsResp.setMsg("保存成功");
					fsResp.setData(id.toString());
				}
			} catch(DaoException ex) {
				throw new ServiceException(ex.fillInStackTrace());
			}
		}
		return fsResp;
	}

	@Override
	public SmartResponse<String> update(T t) throws ServiceException {
		SmartResponse<String> fsResp = new SmartResponse<String>();
		fsResp.setMsg("更新失败");
		if(null != t) {
			try {
				if(getDao().update(t)) {
					fsResp.setResult(OP_SUCCESS);
					fsResp.setMsg("更新成功");
				}
			} catch(DaoException ex) {
				throw new ServiceException(ex.fillInStackTrace());
			}
		}
		return fsResp;
	}
	
	@Override
	public SmartResponse<String> update(BaseBeanImpl bean) throws ServiceException {
		SmartResponse<String> fsResp = new SmartResponse<String>();
		fsResp.setMsg("更新失败");
		if(null != bean) {
			try {
				if(getOPDao().updateObj(bean)) {
					fsResp.setResult(OP_SUCCESS);
					fsResp.setMsg("更新成功");
				}
			} catch(DaoException ex) {
				throw new ServiceException(ex.fillInStackTrace());
			}
		}
		return fsResp;
	}

	@Override
	public SmartResponse<String> delete(String id) throws ServiceException {
		SmartResponse<String> fsResp = new SmartResponse<String>();
		fsResp.setMsg("删除失败");
		if(StringUtils.isNotEmpty(id)) {
			try {
				if(getDao().delete(id)) {
					fsResp.setResult(OP_SUCCESS);
					fsResp.setMsg("删除成功");
				}
			} catch(DaoException ex) {
				throw new ServiceException(ex.fillInStackTrace());
			}
		}
		return fsResp;
	}

	@Override
	public SmartResponse<String> save(List<T> ts) throws ServiceException {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		smartResp.setMsg("保存失败");
		if(CollectionUtils.isNotEmpty(ts)) {
			List<Serializable> ids = getDao().save(ts);
			if(CollectionUtils.isNotEmpty(ids)) {
				smartResp.setResult(OP_SUCCESS);
				smartResp.setMsg("保存成功");
				smartResp.setDatas(toString(ids));
			}
		}
		return smartResp;
	}

	private List<String> toString(Collection<?> objs) {
		List<String> list = new ArrayList();
		Iterator var3 = objs.iterator();

		while(var3.hasNext()) {
			Object obj = var3.next();
			list.add(obj.toString());
		}

		return list.size() > 0 ? list : null;
	}

	@Override
	public SmartResponse<String> update(List<T> ts) throws ServiceException {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		smartResp.setMsg("保存失败");
		if(CollectionUtils.isNotEmpty(ts)) {
			if(getDao().update(ts)) {
				smartResp.setResult(OP_SUCCESS);
				smartResp.setMsg("保存成功");
			}
		}
		return smartResp;
	}
	
	@Override
	public SmartResponse<String> execute(String resId,Map<String,Object> params) throws ServiceException {
		int result = -1;
		SmartResponse<String> smartResp = new SmartResponse<String>();
		if(StringUtils.isEmpty(resId)) {
			throw new RuntimeException("参数无效");
		}
		//判断处理是否有逗号分割的多条数据组合
		if(null != params && params.size()>0) {
			for (String key : params.keySet()) {
				if(!params.get(key).getClass().isArray()) {
					String value = DataUtil.handleNull(params.get(key));
					if(StringUtils.isNotEmpty(value) && value.indexOf(",")>-1) {
						String[] values = value.split(",");
						params.put(key, values);
					}
				}//if
			}//for
		}
		String sql = SQLResUtil.getOpSqlMap().getSQL(resId);
		if(StringUtils.isEmpty(sql)) {
			throw new NullPointerException("sql["+resId+"]获取到的值为空");
		}
		if(sql.indexOf(";")>-1) {
			result = getDao().executeSql(Arrays.asList(sql.split(";")), params)?1:-1;
		} else {
			if(StringUtils.isNotEmpty(sql)) {
				result = getDao().executeSql(sql, params);
			}
		}
		sql = null;
		params = null;
		if(result>0) {
			smartResp.setResult(IConstant.OP_SUCCESS);
			smartResp.setMsg("执行成功");
		}
		return smartResp;
	}

	@Override
	public SmartResponse<String> execute(String resId, String id) throws ServiceException {
		Map<String, Object> param = null;
		if(StringUtils.isNotEmpty(id)) {
			param = new HashMap<String, Object>();
			param.put("id", id);
		}
		return execute(resId, param);
	}


	@Override
	public SmartResponse<String> deleteByField(Map<String, Object> param) throws ServiceException {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		if(getDao().deleteByField(param)) {
			smartResp.setResult(OP_SUCCESS);
			smartResp.setMsg(OP_SUCCESS_MSG);
		}
		return smartResp;
	}
}
