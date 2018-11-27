package cn.com.smart.web.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.apache.commons.lang3.StringUtils;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.bean.TreeProp;
import cn.com.smart.exception.DaoException;
import cn.com.smart.exception.ServiceException;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TNMenu;
import cn.com.smart.web.bean.entity.TNResource;
import cn.com.smart.web.bean.entity.TNRole;
import cn.com.smart.web.bean.entity.TNRoleUser;
import cn.com.smart.web.cache.impl.RoleMenuMemoryCache;
import cn.com.smart.web.cache.impl.RoleResourceMemoryCache;
import cn.com.smart.web.dao.impl.MenuDao;
import cn.com.smart.web.dao.impl.RoleDao;
import cn.com.smart.web.dao.impl.RoleMenuDao;
import cn.com.smart.web.dao.impl.RoleResourceDao;
import cn.com.smart.web.dao.impl.RoleUserDao;

/**
 * 
 * @author XUWENYI
 *
 */
@Service("roleServ")
public class RoleService extends MgrServiceImpl<TNRole> {

	@Autowired
	private RoleDao roleDao;
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private RoleMenuDao roleMenuDao;
	@Autowired
	private ResourceService resServ;
	@Autowired
	private RoleResourceDao roleResDao;
	@Autowired
	private RoleUserDao roleUserDao;

	@Autowired
	private RoleMenuMemoryCache roleMenuCache;
	@Autowired
	private RoleResourceMemoryCache roleResCache;
	
	/**
	 * 保存
	 * @param role
	 * @param menuIds
	 * @param resAuths
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<String> save(TNRole role,String[] menuIds,List<TreeProp> resAuths) throws ServiceException {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		try {
			if(null != role) {
				Serializable id = roleDao.save(role);
				if(null != id && StringUtils.isNotEmpty(id.toString())) {
					boolean is = true;
					boolean isMenu = true;
					boolean isRes = true;
					if(null != menuIds && menuIds.length>0 ) {
						List<TNMenu> menus = menuDao.find(menuIds);
						if(null != menus && menus.size()>0) {
							isMenu = roleMenuDao.save(id.toString(), menus);
							if(!isMenu)
								roleDao.delete(role.getId());
						}
						menus = null;
					}
					if(null != resAuths && resAuths.size()>0 && is && isMenu) {
					  	List<TNResource> resources = resServ.treeProp2Res(resAuths);
					  	resAuths = null;
					  	if(null != resources && resources.size()>0) {
					  		isRes = roleResDao.save(id.toString(),resources);
					  		if(!isRes) {
					  			roleDao.delete(role.getId());
					  			if(null != roleMenuDao) {
					  				roleMenuDao.delete(menuIds);
					  			}
					  		}
					  	}
					  	resources = null;
					}
					if(is && isMenu && isRes) {
						smartResp.setResult(OP_SUCCESS);
						smartResp.setMsg(OP_SUCCESS_MSG);
						roleResCache.refreshCache();
						roleMenuCache.refreshCache();
					}
				} 
			}
		} catch (DaoException e) {
			throw new ServiceException(e.getMessage(),e.getCause());
		} catch (Exception e) {
			throw new ServiceException(e.getCause());
		}
		return smartResp;
	}
	
	
	/**
	 * 更新
	 * @param role
	 * @param menuIds
	 * @param resAuths
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<String> update(TNRole role,String[] menuIds,List<TreeProp> resAuths) throws ServiceException {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		try {
			if(null != role) {
				if(roleDao.update(role)) {
					boolean is = true;
					if(null != menuIds && menuIds.length>0) {
						if(roleMenuDao.deleteByRole(role.getId())) {
							List<TNMenu> menus = menuDao.find(menuIds);
							is = roleMenuDao.save(role.getId(), menus);
							menus = null;
						}
					} else {
						roleMenuDao.deleteByRole(role.getId());
					}
					if(null != resAuths && resAuths.size()>0) {
						if(roleResDao.deleteByRole(role.getId())) {
						  	List<TNResource> resources = resServ.treeProp2Res(resAuths);
						  	resAuths = null;
						  	if(null != resources && resources.size()>0) {
						  		is = roleResDao.save(role.getId(),resources);
						  	}
						  	resources = null;
						}
					} else {
						roleResDao.deleteByRole(role.getId());
					}
					if(is) {
						smartResp.setResult(OP_SUCCESS);
						smartResp.setMsg(OP_SUCCESS_MSG);
						
						roleResCache.refreshCache();
						roleMenuCache.refreshCache();
					}
				} 
			}
		} catch (DaoException e) {
			throw new ServiceException(e.getMessage(),e.getCause());
		} catch (Exception e) {
			throw new ServiceException(e.getCause());
		}
		return smartResp;
	}
	
	/**
	 * 删除角色
	 * @param id
	 * @return
	 */
	public SmartResponse<String> delete(String id) {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		smartResp.setMsg("角色删除失败");
		if(StringUtils.isNotEmpty(id)) {
			if(roleDao.delete(id)) {
				smartResp.setResult(OP_SUCCESS);
				smartResp.setMsg("角色删除成功");
				
				roleResCache.refreshCache();
				roleMenuCache.refreshCache();
			}
		}
		return smartResp;
	}
	
	/**
	 * 角色中添加用户
	 * @param roleId
	 * @param userIds
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<String> addUser2Role(String roleId,String[] userIds) throws ServiceException {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		try {
			if(StringUtils.isNotEmpty(roleId) && null != userIds && userIds.length>0) {
				if(!roleUserDao.isUserInRoleExist(roleId, userIds)) {
					List<TNRoleUser> roleUsers = new ArrayList<TNRoleUser>();
					TNRoleUser roleUser = null;
					for (int i = 0; i < userIds.length; i++) {
						roleUser = new TNRoleUser();
						roleUser.setRoleId(roleId);
						roleUser.setUserId(userIds[i]);
						roleUsers.add(roleUser);
					}
					List<Serializable> ids = roleUserDao.save(roleUsers);
					if(null != ids && ids.size()>0) {
						smartResp.setResult(OP_SUCCESS);
						smartResp.setMsg(OP_SUCCESS_MSG);
					}
					ids = null;
					roleUser = null;
					roleUsers = null;
				} else {
					smartResp.setMsg("用户已添加到角色里面，不能重复添加！");
				}
				userIds = null;
			}
		} catch (DaoException e) {
			throw new ServiceException(e.getMessage(),e.getCause());
		} catch (Exception e) {
			throw new ServiceException(e.getCause());
		}
		return smartResp;
	}

	/**
	 * 判断是否为超级管理员
	 * @param roleIds
	 * @return
	 * @throws ServiceException
	 */
	public boolean isSuperAdmin(List<String> roleIds) throws ServiceException {
		boolean is = false;
		try {
			if(null != roleIds && roleIds.size()>0) {
				String[] roleIdArray = new String[roleIds.size()];
				roleIds.toArray(roleIdArray);
				is = roleDao.isContainsSuperAdminRole(roleIdArray);
				roleIdArray = null;
			}
			roleIds = null;
		} catch (DaoException e) {
			throw new ServiceException(e.getMessage(),e.getCause());
		} catch (Exception e) {
			throw new ServiceException(e.getCause());
		}
		return is;
	}
	
	/**
     * 从角色中删除用户
     * @param roleId
     * @param userId
     * @return
     */
    public SmartResponse<String> deleteUser(String roleId, String userId) {
        SmartResponse<String> smartResp = new SmartResponse<String>();
        smartResp.setMsg("删除失败");
        if(StringUtils.isEmpty(roleId) || StringUtils.isEmpty(userId)) {
            return smartResp;
        }
        Map<String, Object> param = new HashMap<String, Object>(2);
        param.put("roleId", roleId);
        param.put("id", userId);
        if(roleUserDao.delete(param)) {
            smartResp.setResult(OP_SUCCESS);
            smartResp.setMsg("删除成功");
        }
        return smartResp;
    }
	
	/**
	 * 从角色中删除组织架构
	 * @param roleId
	 * @param orgId
	 * @return
	 */
	public SmartResponse<String> deleteOrg(String roleId, String orgId) {
	    SmartResponse<String> smartResp = new SmartResponse<String>();
	    smartResp.setMsg("删除失败");
	    if(StringUtils.isEmpty(roleId) || StringUtils.isEmpty(orgId)) {
	        return smartResp;
	    }
	    Map<String, Object> param = new HashMap<String, Object>(2);
	    param.put("roleId", roleId);
	    param.put("id", orgId);
	    return smartResp;
	}
	
	/**
     * 从角色中删除职位
     * @param roleId
     * @param positionId
     * @return
     */
    public SmartResponse<String> deletePosition(String roleId, String positionId) {
        SmartResponse<String> smartResp = new SmartResponse<String>();
        smartResp.setMsg("删除失败");
        if(StringUtils.isEmpty(roleId) || StringUtils.isEmpty(positionId)) {
            return smartResp;
        }
        Map<String, Object> param = new HashMap<String, Object>(2);
        param.put("roleId", roleId);
        param.put("id", positionId);
        return smartResp;
    }
	
}
