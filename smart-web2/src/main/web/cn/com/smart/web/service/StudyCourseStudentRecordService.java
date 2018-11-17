package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.entity.TGStudyCourseStudentRecord;
import cn.com.smart.web.dao.impl.StudyCourseRecordDao;
import cn.com.smart.web.dao.impl.StudyCourseStudentRecordDao;
import org.springframework.stereotype.Service;

/**
 *
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudyCourseStudentRecordService extends MgrServiceImpl<TGStudyCourseStudentRecord> {

	@Override
	public StudyCourseStudentRecordDao getDao() {
		return (StudyCourseStudentRecordDao)super.getDao();
	}

}
