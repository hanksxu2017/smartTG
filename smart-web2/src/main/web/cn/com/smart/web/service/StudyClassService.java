package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyClass;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.dao.impl.StudyClassDao;
import cn.com.smart.web.dao.impl.StudyTeacherDao;
import org.springframework.stereotype.Service;

/**
 *
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudyClassService extends MgrServiceImpl<TGStudyClass> {

	@Override
	public StudyClassDao getDao() {
		return (StudyClassDao)super.getDao();
	}


}
