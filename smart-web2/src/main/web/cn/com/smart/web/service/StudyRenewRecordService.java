package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyRenewRecord;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.dao.impl.StudyRenewRecordDao;
import cn.com.smart.web.dao.impl.StudyStudentDao;
import org.springframework.stereotype.Service;

/**
 *
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudyRenewRecordService extends MgrServiceImpl<TGStudyRenewRecord> {

	@Override
	public StudyRenewRecordDao getDao() {
		return (StudyRenewRecordDao)super.getDao();
	}


}
