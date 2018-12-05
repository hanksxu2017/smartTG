package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyClassroom;
import cn.com.smart.web.bean.entity.TGStudyStatisticsTeacher;
import cn.com.smart.web.dao.impl.StudyClassroomDao;
import cn.com.smart.web.dao.impl.StudyStatisticsTeacherDao;
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
public class StudyStatisticsTeacherService extends MgrServiceImpl<TGStudyStatisticsTeacher> {

	@Override
	public StudyStatisticsTeacherDao getDao() {
		return (StudyStatisticsTeacherDao)super.getDao();
	}

	public TGStudyStatisticsTeacher getByMonthAndTeacher(String month, String teacherId) {
		Map<String, Object> params = new HashMap<>();
		params.put("month", month);
		params.put("teacherId", teacherId);
		List<TGStudyStatisticsTeacher> recList = this.findByParam(params).getDatas();
		if(CollectionUtils.isNotEmpty(recList)) {
			return recList.get(0);
		}

		return null;
	}

}
