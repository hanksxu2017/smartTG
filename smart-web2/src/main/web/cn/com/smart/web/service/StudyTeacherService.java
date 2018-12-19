package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudySchool;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.dao.impl.StudySchoolDao;
import cn.com.smart.web.dao.impl.StudyTeacherDao;
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
public class StudyTeacherService extends MgrServiceImpl<TGStudyTeacher> {

	@Override
	public StudyTeacherDao getDao() {
		return (StudyTeacherDao)super.getDao();
	}

	public TGStudyTeacher getTeacherByPhone(String phone) {
		Map<String, Object> params = new HashMap<>();
		params.put("phone", phone);
		return getOneByParams(params);
	}

	private TGStudyTeacher getOneByParams(Map<String, Object> params) {
		List<TGStudyTeacher> teacherList = this.findByParam(params).getDatas();
		if(CollectionUtils.isNotEmpty(teacherList)) {
			return teacherList.get(0);
		}
		return null;
	}

	public TGStudyTeacher getTeacherByOpenId(String openid) {
		Map<String, Object> params = new HashMap<>();
		params.put("openid", openid);
		return getOneByParams(params);
	}

}
