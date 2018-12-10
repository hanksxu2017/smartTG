package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.*;
import cn.com.smart.web.dao.impl.StudyStatisticsStudentDao;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
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
public class StudyStStudentService extends MgrServiceImpl<TGStudyStStudent> {

	@Override
	public StudyStatisticsStudentDao getDao() {
		return (StudyStatisticsStudentDao)super.getDao();
	}

	/**
	 * 查询统计记录
	 * @param studentId 学生编号
	 * @param month     月份
	 * @return          统计对象
	 */
	public TGStudyStStudent findByStudentId(String studentId, String month) {
		Map<String, Object> params = new HashMap<>();
		params.put("studentId", studentId);
		params.put("month", month);
		List<TGStudyStStudent> statisticsStudentList = this.findByParam(params).getDatas();
		if(CollectionUtils.isEmpty(statisticsStudentList)) {
			return null;
		}
		return statisticsStudentList.get(0);
	}


}
