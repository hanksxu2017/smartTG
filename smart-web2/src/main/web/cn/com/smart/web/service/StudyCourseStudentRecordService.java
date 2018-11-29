package cn.com.smart.web.service;

import cn.com.smart.constant.enumEntity.CourseStudentStatusEnum;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.entity.TGStudyCourseStudentRecord;
import cn.com.smart.web.dao.impl.StudyCourseRecordDao;
import cn.com.smart.web.dao.impl.StudyCourseStudentRecordDao;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

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
		for(CourseStudentStatusEnum statusEnum : CourseStudentStatusEnum.values()) {
			if(!statusEnum.equals(CourseStudentStatusEnum.CANCEL_AS_EXIT)) {
				statusList.add(statusEnum.name());
			}
		}
		return statusList;
	}

}
