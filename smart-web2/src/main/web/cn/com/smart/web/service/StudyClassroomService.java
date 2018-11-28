package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyClassroom;
import cn.com.smart.web.dao.impl.StudyClassroomDao;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 版本服务类
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudyClassroomService extends MgrServiceImpl<TGStudyClassroom> {

	@Override
	public StudyClassroomDao getDao() {
		return (StudyClassroomDao)super.getDao();
	}

}
