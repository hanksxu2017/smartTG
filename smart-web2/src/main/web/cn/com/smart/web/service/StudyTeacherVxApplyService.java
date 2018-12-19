package cn.com.smart.web.service;

import cn.com.smart.constant.IConstant;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyCourseRecord;
import cn.com.smart.web.bean.entity.TGStudyCourseStudentRecord;
import cn.com.smart.web.bean.entity.TGStudyTeacherVxApply;
import cn.com.smart.web.constant.enums.tg.CourseStudentRecordStatusEnum;
import cn.com.smart.web.dao.impl.StudyCourseRecordDao;
import cn.com.smart.web.dao.impl.StudyTeacherVxApplyDao;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
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
public class StudyTeacherVxApplyService extends MgrServiceImpl<TGStudyTeacherVxApply> {

	@Override
	public StudyTeacherVxApplyDao getDao() {
		return (StudyTeacherVxApplyDao)super.getDao();
	}


}
