package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyStudentClassRel;
import cn.com.smart.web.bean.entity.TGStudyStudentCourseRel;
import cn.com.smart.web.dao.impl.StudyStudentClassRelDao;
import cn.com.smart.web.dao.impl.StudyStudentCourseRelDao;
import org.springframework.stereotype.Service;

/**
 *
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudyStudentCourseRelService extends MgrServiceImpl<TGStudyStudentCourseRel> {

	@Override
	public StudyStudentCourseRelDao getDao() {
		return (StudyStudentCourseRelDao)super.getDao();
	}


}
