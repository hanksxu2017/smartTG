package cn.com.smart.web.service;

import cn.com.smart.constant.IConstant;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.bean.entity.TGStudyTeacher;
import cn.com.smart.web.constant.enums.tg.SystemMessageEnum;
import cn.com.smart.web.dao.impl.StudyStudentDao;
import cn.com.smart.web.dao.impl.StudyTeacherDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 *
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudyStudentService extends MgrServiceImpl<TGStudyStudent> {

	@Autowired
	private StudySystemMessageService systemMessageService;

	@Override
	public StudyStudentDao getDao() {
		return (StudyStudentDao)super.getDao();
	}

	/**
	 * 减少学生课时
	 * @param student   学生对象
	 * @param count     课时减少的数量
	 */
	public void reduceRemainCourse(TGStudyStudent student, int count) {
		student.setCourseSeriesUnSigned(0);
		student.setUpdateTime(new Date());
		student.setRemainCourse(student.getRemainCourse() - count);
		this.update(student);

		// 取消学生连续缺课的系统提醒
		this.systemMessageService.processSystemMessageBySystem(SystemMessageEnum.STUDENT_ABSENT_NOTE, student.getId());

		if (student.getRemainCourse() <= IConstant.NOTIFY_COURSE_RENEW) {
			// 课时不足
			String content = "学生[" + student.getName() + "]仅剩余 " + student.getRemainCourse() + "课时!";
			this.systemMessageService.broadSystemMessage(SystemMessageEnum.STUDENT_REMAIN_COURSE_NOTE, content, student.getId());
		}
	}
}
