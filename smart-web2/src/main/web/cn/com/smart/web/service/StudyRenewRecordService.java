package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyRenewRecord;
import cn.com.smart.web.bean.entity.TGStudyStudent;
import cn.com.smart.web.dao.impl.StudyRenewRecordDao;
import cn.com.smart.web.dao.impl.StudyStudentDao;
import org.apache.commons.collections.CollectionUtils;
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
public class StudyRenewRecordService extends MgrServiceImpl<TGStudyRenewRecord> {

	@Override
	public StudyRenewRecordDao getDao() {
		return (StudyRenewRecordDao)super.getDao();
	}

	/**
	 * 查询学生的续费记录
	 * @param studentId 学生编号
	 * @return          续费记录列表
	 */
	List<TGStudyRenewRecord> findByStudentId(String studentId) {
		Map<String, Object> params = new HashMap<>();
		params.put("studentId", studentId);
		return this.findByParam(params).getDatas();
	}

}
