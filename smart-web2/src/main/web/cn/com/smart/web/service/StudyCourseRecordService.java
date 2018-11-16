package cn.com.smart.web.service;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.dao.impl.StudyCourseDao;
import cn.com.smart.web.dao.impl.StudyCourseRecordDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 *
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudyCourseRecordService extends MgrServiceImpl<TGStudyCourseRecord> {

	@Override
	public StudyCourseRecordDao getDao() {
		return (StudyCourseRecordDao)super.getDao();
	}

}
