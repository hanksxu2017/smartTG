package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyStStudentSignRecord;
import cn.com.smart.web.dao.impl.StudyStatisticsStudentCourseSignRecordDao;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
public class StudyStStudentSignRecordService extends MgrServiceImpl<TGStudyStStudentSignRecord> {

	@Override
	public StudyStatisticsStudentCourseSignRecordDao getDao() {
		return (StudyStatisticsStudentCourseSignRecordDao)super.getDao();
	}

	public List<TGStudyStStudentSignRecord> findByStatisticsId(String statisticsId) {
		Map<String, Object> params = new HashMap<>();
		params.put("statisticsId", statisticsId);
		return this.findByParam(params).getDatas();
	}


}
