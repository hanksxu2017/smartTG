package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyClassRoom;
import cn.com.smart.web.bean.entity.TGStudySchool;
import cn.com.smart.web.dao.impl.StudyClassroomDao;
import cn.com.smart.web.dao.impl.StudySchoolDao;
import org.springframework.stereotype.Service;

/**
 * 版本服务类
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudyClassroomService extends MgrServiceImpl<TGStudyClassRoom> {

	@Override
	public StudyClassroomDao getDao() {
		return (StudyClassroomDao)super.getDao();
	}

}
