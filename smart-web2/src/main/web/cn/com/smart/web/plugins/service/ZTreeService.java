package cn.com.smart.web.plugins.service;

import java.util.ArrayList;
import java.util.List;

import cn.com.smart.web.utils.DataUtil;
import org.springframework.stereotype.Component;

import cn.com.smart.web.plugins.ZTreeData;

import org.apache.commons.lang3.StringUtils;

/**
 * zTree插件服务类
 * @author XUWENYI
 *
 */
@Component
public class ZTreeService {

	public List<ZTreeData> convert(List<Object> trees,boolean isAsync) {
		List<ZTreeData> zTreeDatas = null;
		if(null != trees && trees.size()>0) {
			ZTreeData zTreeData = null;
			zTreeDatas = new ArrayList<ZTreeData>();
			for (Object objTmp : trees) {
				Object[] objTmpArray = (Object[]) objTmp;
				if(objTmpArray.length>5) {
					zTreeData = new ZTreeData();
					zTreeData.setId(DataUtil.handleNull(objTmpArray[3]));
					zTreeData.setpId(DataUtil.handleNull(objTmpArray[4]));
					zTreeData.setName(DataUtil.handleNull(objTmpArray[5]));
					zTreeData.setIsParent(isParent(trees, DataUtil.handleNull(objTmpArray[3]),4));
					
					if(isAsync) {
						Object parentObj = objTmpArray[objTmpArray.length-1];
						int count = Integer.parseInt(DataUtil.handleNumNull(parentObj));
						zTreeData.setIsParent((count>0?true:false));
					} else {
						zTreeData.setIsParent(isParent(trees, DataUtil.handleNull(objTmpArray[3]), 4));
					}
					zTreeDatas.add(zTreeData);
				} else {
					zTreeData = new ZTreeData();
					zTreeData.setId(DataUtil.handleNull(objTmpArray[0]));
					zTreeData.setpId(DataUtil.handleNull(objTmpArray[1]));
					zTreeData.setName(DataUtil.handleNull(objTmpArray[3]));
					zTreeData.setIsParent(isParent(trees, DataUtil.handleNull(objTmpArray[0]),1));
					
					if(isAsync) {
						Object parentObj = objTmpArray[objTmpArray.length-1];
						int count = Integer.parseInt(DataUtil.handleNumNull(parentObj));
						zTreeData.setIsParent((count>0?true:false));
					} else {
						zTreeData.setIsParent(isParent(trees, DataUtil.handleNull(objTmpArray[0]),1));
					}
					zTreeDatas.add(zTreeData);
				}
			}
			zTreeData = null;
		}
		return zTreeDatas;
	}
	
	/**
	 * 判断是否为父节点
	 * @param trees
	 * @param id
	 * @param pos
	 * @return
	 */
	public boolean isParent(List<Object> trees,String id, int pos) {
		boolean is = false;
		if(StringUtils.isNotEmpty(id) && trees != null && trees.size()>0 ) {
			for (Object objTmp : trees) {
				Object[] objTmpArray = (Object[]) objTmp;
				if(DataUtil.handleNull(objTmpArray[pos]).equals(id)) {
					is = true;
					break;
				}
			}
		}
		return is;
	}
	
}
