package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.bean.entity.TGStudyTeacherVxApply;
import cn.com.smart.web.bean.entity.TGStudyVxUserInfo;
import cn.com.smart.web.dao.impl.StudyTeacherVxApplyDao;
import cn.com.smart.web.dao.impl.StudyVxUserInfoDao;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudyVxUserInfoService extends MgrServiceImpl<TGStudyVxUserInfo> {

	@Override
	public StudyVxUserInfoDao getDao() {
		return (StudyVxUserInfoDao)super.getDao();
	}

	public TGStudyVxUserInfo getVxUserInfoByOpenId(String openId) {
		Map<String, Object> params = new HashMap<>();
		params.put("openId", openId);
		List<TGStudyVxUserInfo> vxUserInfoList = this.findByParam(params).getDatas();
		if(CollectionUtils.isNotEmpty(vxUserInfoList)) {
			return vxUserInfoList.get(0);
		}
		return null;
	}

}
