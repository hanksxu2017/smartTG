package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyClassRoom;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.dao.impl.StudyClassroomDao;
import cn.com.smart.web.dao.impl.StudyCourseDao;
import org.springframework.stereotype.Service;

/**
 * 版本服务类
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudyCourseService extends MgrServiceImpl<TGStudyCourse> {

	@Override
	public StudyCourseDao getDao() {
		return (StudyCourseDao)super.getDao();
	}

}
