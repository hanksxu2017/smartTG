package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyClassroom;
import cn.com.smart.web.bean.entity.TGStudySystemMessage;
import cn.com.smart.web.dao.impl.StudyClassroomDao;
import cn.com.smart.web.dao.impl.StudySystemMessageDao;
import org.springframework.stereotype.Service;

/**
 * 版本服务类
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudySystemMessageService extends MgrServiceImpl<TGStudySystemMessage> {

	@Override
	public StudySystemMessageDao getDao() {
		return (StudySystemMessageDao)super.getDao();
	}


}
