package cn.com.smart.web.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.apache.commons.lang3.StringUtils;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.exception.DaoException;
import cn.com.smart.exception.ServiceException;
import cn.com.smart.helper.ObjectTreeHelper;
import cn.com.smart.helper.TreeHelper;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TNMenu;
import cn.com.smart.web.bean.entity.TNRole;
import cn.com.smart.web.cache.impl.MenuMemoryCache;
import cn.com.smart.web.cache.impl.RoleMenuMemoryCache;
import cn.com.smart.web.dao.impl.MenuDao;
import cn.com.smart.web.dao.impl.RoleDao;
import cn.com.smart.web.dao.impl.RoleMenuDao;
import cn.com.smart.web.plugins.ZTreeData;

/**
 * 
 * @author XUWENYI
 *
 */
@Service("menuServ")
public class MenuService extends MgrServiceImpl<TNMenu> {

	@Autowired
	private MenuDao menuDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private RoleMenuDao roleMenuDao;
	@Autowired
	private ObjectTreeHelper objTreeHelper;
	
	@Autowired
	private MenuMemoryCache menuCache;
	@Autowired
	private RoleMenuMemoryCache roleMenuCache;

	/**
	 * 获取菜单信息
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<Object> findObjAll() throws ServiceException {
		SmartResponse<Object> smartResp = new SmartResponse<Object>();
		smartResp.setMsg(OP_NOT_DATA_SUCCESS_MSG);
		try {
			List<Object> objs = menuCache.queryObjAll();
			if(null == objs)
				objs = menuDao.queryObjAll();
			if(null != objs && objs.size()>0) {
				objs = objTreeHelper.outPutTree(objs);
				if(null != objs && objs.size()>0) {
					smartResp.setResult(OP_SUCCESS);
					smartResp.setMsg(OP_SUCCESS_MSG);
					smartResp.setDatas(objs);
					smartResp.setTotalNum(objs.size());
				}
			} else {
				smartResp.setResult(OP_NOT_DATA_SUCCESS);
				smartResp.setMsg(OP_NOT_DATA_SUCCESS_MSG);
			}
		} catch (DaoException e) {
			throw new ServiceException(e.getMessage(),e.getCause());
		} catch (Exception e) {
			throw new ServiceException(e.getCause());
		}
		return smartResp;
	}
	
	/**
	 *  保存
	 * @param menu
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<String> save(TNMenu menu) throws ServiceException {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		try {
			if(null != menu){
				Serializable id = menuDao.save(menu);
				if(null != id) {
					smartResp.setResult(OP_SUCCESS);
					smartResp.setMsg(OP_SUCCESS_MSG);
					TNRole role = roleDao.adminRole();
					List<TNMenu> menuList = new ArrayList<TNMenu>();
					menuList.add(menu);
					if(null != role) {
						roleMenuDao.save(role.getId(), menuList);
						menuList = null;
					}
					menuCache.refreshCache();
					roleMenuCache.refreshCache();
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
	 * 更新菜单
	 * @param menu
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<String> update(TNMenu menu) throws ServiceException {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		try {
			if(null != menu && menuDao.update(menu)) {
				//获取管理员角色
				TNRole role = roleDao.adminRole();
				if(null != role) {
					if(roleMenuDao.deleteByRoleMenu(role.getId(),menu.getId())) {
						List<TNMenu> menuList = new ArrayList<TNMenu>();
						menuList.add(menu);
						roleMenuDao.save(role.getId(), menuList);
						menuList = null;
				    }
					menuCache.refreshCache();
					roleMenuCache.refreshCache();
			    }
				smartResp.setResult(OP_SUCCESS);
				smartResp.setMsg(OP_SUCCESS_MSG);
			}
		} catch (DaoException e) {
			throw new ServiceException(e.getMessage(),e.getCause());
		} catch (Exception e) {
			throw new ServiceException(e.getCause());
		}
		return smartResp;
	}
	
	/**
	 *  删除
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<String> delete(String id) {
		SmartResponse<String> smartResp = new SmartResponse<String>();
		try {
			if(menuDao.delete(id)) {
				smartResp.setResult(OP_SUCCESS);
				smartResp.setMsg(OP_SUCCESS_MSG);
				menuCache.refreshCache();
				roleMenuCache.refreshCache();
			}
		} catch (DaoException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return smartResp;
	}
	
	
	/**
	 *  获取菜单信息
	 * @param menuId
	 * @param menus
	 * @return
	 * @throws ServiceException
	 */
	public TNMenu getMenuById(String menuId,List<TNMenu> menus) throws ServiceException {
		TNMenu menuTmp = null;
		try {
			if(null != menus && menus.size()>0 && StringUtils.isNotEmpty(menuId)) {
				for (TNMenu menu : menus) {
					if (menu.getId().equals(menuId)) {
						menuTmp = menu;
						break;
					}
				}
			menus = null;
			}
		} catch (Exception e) {
			throw new ServiceException(e.getCause());
		}
		return menuTmp;
	}

	
	/**
	 * 获取菜单树
	 * @param tmpMenu
	 * @param menus
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<TNMenu> getMenuTree(TNMenu tmpMenu,List<TNMenu> menus) throws ServiceException {
		SmartResponse<TNMenu> smartResp = new SmartResponse<TNMenu>();
		try {
			if(null == tmpMenu) {
				tmpMenu = new TNMenu();
				tmpMenu.setId("0");
			}
			if (null != tmpMenu) {
				if(null != menus && menus.size()>0) {
					TreeHelper<TNMenu> treeHelper = new TreeHelper<TNMenu>();
					try {
						menus = treeHelper.outPutTree(menus, tmpMenu, false);
						if (null != menus && menus.size() > 0) {
							smartResp.setResult(OP_SUCCESS);
							smartResp.setMsg(OP_SUCCESS_MSG);
							smartResp.setDatas(menus);
							smartResp.setSize(menus.size());
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						menus = null;
						tmpMenu = null;
					}
				}
			}
		} catch (Exception e) {
			throw new ServiceException(e.getCause());
		}
		return smartResp;
	}
	
	/**
	 * 获取菜单树
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<TNMenu> getMenuTree() throws ServiceException {
		SmartResponse<TNMenu> smartResp = new SmartResponse<TNMenu>();
		try {
		List<TNMenu> menus = menuCache.findAll();
		if(null == menus)
			menus = menuDao.findAll();
		if(null != menus && menus.size()>0) {
				TreeHelper<TNMenu> treeHelper = new TreeHelper<TNMenu>();
				menus = treeHelper.outPutTree(menus);
				if (null != menus && menus.size() > 0) {
					smartResp.setResult(OP_SUCCESS);
					smartResp.setMsg(OP_SUCCESS_MSG);
					smartResp.setDatas(menus);
					smartResp.setSize(menus.size());
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
	 *  获取菜单树
	 * @param roleIds
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<TNMenu> getMenuTree(List<String> roleIds) throws ServiceException {
		SmartResponse<TNMenu> smartResp = new SmartResponse<TNMenu>();
		try {
			if(CollectionUtils.isNotEmpty(roleIds)) {
				List<TNMenu> menus = menuCache.queryMenus(roleIds);
				if(null != menus && menus.size()>0) {
					TreeHelper<TNMenu> treeHelper = new TreeHelper<TNMenu>();
					menus = treeHelper.outPutTree(menus);
					if (null != menus && menus.size() > 0) {
						smartResp.setResult(OP_SUCCESS);
						smartResp.setMsg(OP_SUCCESS_MSG);
						smartResp.setDatas(menus);
						smartResp.setSize(menus.size());
					}
					menus = null;
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
	 * 该角色下的菜单树
	 * @param roleId
	 * @return
	 * @throws ServiceException
	 */
	public SmartResponse<ZTreeData> roleMenuTree(String roleId) throws ServiceException {
		SmartResponse<ZTreeData> smartResp = new SmartResponse<ZTreeData>();
		try {
			if(StringUtils.isNotEmpty(roleId)) {
				List<String> roleIds = new ArrayList<String>(1);
				roleIds.add(roleId);
				List<TNMenu> menus = menuCache.queryMenus(roleIds);
				if(null != menus && menus.size()>0) {
					try {
						TreeHelper<TNMenu> menuTreeHelper = new TreeHelper<TNMenu>();
						List<TNMenu> menuTrees = menuTreeHelper.outPutTree(menus);
						menuTreeHelper = null;
						if(null != menuTrees && menuTrees.size()>0) {
							List<ZTreeData> zTreeDatas = new ArrayList<ZTreeData>();
							ZTreeData zTreeData = null;
							for (TNMenu menu : menuTrees) {
								zTreeData = new ZTreeData();
								zTreeData.setId(menu.getId());
								zTreeData.setName(menu.getName());
								zTreeData.setpId(menu.getParentId());
								zTreeData.setFlag("menu");
								zTreeDatas.add(zTreeData);
							}
							zTreeData = null;
							smartResp.setResult(OP_SUCCESS);
							smartResp.setMsg(OP_SUCCESS_MSG);
							smartResp.setDatas(zTreeDatas);
							smartResp.setTotalNum(zTreeDatas.size());
							zTreeDatas = null;
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				menus = null;
			}
		} catch (DaoException e) {
			throw new ServiceException(e.getMessage(),e.getCause());
		} catch (Exception e) {
			throw new ServiceException(e.getCause());
		}
		return smartResp;
	}

}
