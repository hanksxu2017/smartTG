package cn.com.smart.web.service;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.constant.enumEntity.CourseStudentStatusEnum;
import cn.com.smart.constant.enumEntity.SystemMessageEnum;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.entity.TGStudyCourseStudentRecord;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.dao.impl.StudyCourseDao;
import cn.com.smart.web.dao.impl.StudyCourseRecordDao;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
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
public class StudyCourseRecordService extends MgrServiceImpl<TGStudyCourseRecord> {

	@Override
	public StudyCourseRecordDao getDao() {
		return (StudyCourseRecordDao)super.getDao();
	}


	/**
	 * 检查课时的学生是否已经全部进行了签到操作
	 *
	 * @param courseRecordId 课时记录序号
	 */
	public void updateCourseRecordToEndIfAllSigned(String courseRecordId, List<TGStudyCourseStudentRecord> courseStudentRecordList) {
		if (!CollectionUtils.isEmpty(courseStudentRecordList)) {
			// 所有学生课时记录已处理
			boolean isAllSigned = true;

			int actual = 0;
			int personalLeave = 0;
			int playTruant = 0;
			int otherAbsent = 0;

			for (TGStudyCourseStudentRecord courseStudentRecord : courseStudentRecordList) {
				if (StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.NORMAL.name())) {
					isAllSigned = false;
					break;
				}
				if (StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.SIGNED.name())) {
					actual++;
				} else if (StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.PERSONAL_LEAVE.name())) {
					personalLeave++;
				} else if (StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.PLAY_TRUANT.name())) {
					playTruant++;
				} else if (StringUtils.equals(courseStudentRecord.getStatus(), CourseStudentStatusEnum.OTHER_ABSENT.name())) {
					otherAbsent++;
				}
			}

			if (isAllSigned) {
				TGStudyCourseRecord courseRecord = this.find(courseRecordId).getData();
				courseRecord.setStudentQuantityPlan(courseStudentRecordList.size());
				courseRecord.setStudentQuantityActual(actual);
				courseRecord.setStudentPersonalLeave(personalLeave);
				courseRecord.setStudentPlayTruant(playTruant);
				courseRecord.setStudentOtherAbsent(otherAbsent);

				courseRecord.setUpdateTime(new Date());
				courseRecord.setStatus(IConstant.STATUS_COURSE_END);

				this.update(courseRecord);
			}
		}
	}

}
