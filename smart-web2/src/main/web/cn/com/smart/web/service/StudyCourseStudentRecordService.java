package cn.com.smart.web.service;

import cn.com.smart.constant.enumEntity.CourseStudentRecordStatusEnum;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyCourseStudentRecord;
import cn.com.smart.web.dao.impl.StudyCourseStudentRecordDao;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
public class StudyCourseStudentRecordService extends MgrServiceImpl<TGStudyCourseStudentRecord> {

	@Override
	public StudyCourseStudentRecordDao getDao() {
		return (StudyCourseStudentRecordDao)super.getDao();
	}

	/**
	 * 获取非离班的课时记录
	 * @return
	 */
	public List<String> getQueryStatus() {
		List<String> statusList = new ArrayList<>();
		for(CourseStudentRecordStatusEnum statusEnum : CourseStudentRecordStatusEnum.values()) {
			if(!statusEnum.equals(CourseStudentRecordStatusEnum.CANCEL_AS_EXIT)) {
				statusList.add(statusEnum.name());
			}
		}
		return statusList;
	}

	/**
	 * 获取学生的所有课时记录
	 * @param studentId
	 * @return
	 */
	public List<TGStudyCourseStudentRecord> findByStudentId(String studentId) {
		// 检查指定课时的所有学生是否已经全部签到
		Map<String, Object> params = new HashMap<>();
		params.put("studentId", studentId);
		params.put("status", this.getQueryStatus().toArray());
		return this.findByParam(params).getDatas();
	}
}
