package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyStTeacher;
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
public class StudyStTeacherService extends MgrServiceImpl<TGStudyStTeacher> {

	@Override
	public StudyStatisticsTeacherDao getDao() {
		return (StudyStatisticsTeacherDao)super.getDao();
	}

	public TGStudyStTeacher getByMonthAndTeacher(String month, String teacherId) {
		Map<String, Object> params = new HashMap<>();
		params.put("month", month);
		params.put("teacherId", teacherId);
		List<TGStudyStTeacher> recList = this.findByParam(params).getDatas();
		if(CollectionUtils.isNotEmpty(recList)) {
			return recList.get(0);
		}

		return null;
	}

}
