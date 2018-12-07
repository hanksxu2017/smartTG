package cn.com.smart.web.service;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.constant.enumEntity.StudentCourseRelStatusEnum;
import cn.com.smart.exception.DaoException;
import cn.com.smart.exception.ServiceException;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyStudentCourseRel;
import cn.com.smart.web.dao.impl.StudyStudentCourseRelDao;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
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
public class StudyStudentCourseRelService extends MgrServiceImpl<TGStudyStudentCourseRel> {

	@Override
	public StudyStudentCourseRelDao getDao() {
		return (StudyStudentCourseRelDao)super.getDao();
	}

	@Override
	public SmartResponse<String> delete(String id) throws ServiceException {
		SmartResponse<String> fsResp = new SmartResponse<String>();
		fsResp.setMsg("删除失败");
		if(StringUtils.isNotEmpty(id)) {
			try {
				TGStudyStudentCourseRel rel = getDao().find(id);
				if (null != rel) {
					rel.setStatus(IConstant.STATUS_DELETE);
					rel.setUpdateTime(new Date());
					if(getDao().update(rel)) {
                        fsResp.setResult(OP_SUCCESS);
                        fsResp.setMsg("删除成功");
                    }
				}
			} catch(DaoException ex) {
				throw new ServiceException(ex.fillInStackTrace());
			}
		}
		return fsResp;
	}

	/**
	 * 学生退班
	 * @param param
	 * @return
	 * @throws ServiceException
	 */
	@Override
	public SmartResponse<String> deleteByField(Map<String, Object> param) throws ServiceException {
		SmartResponse<String> smartResponse = new SmartResponse<>();
		List<TGStudyStudentCourseRel> relList = this.findByParam(param).getDatas();
		if(CollectionUtils.isNotEmpty(relList)) {
			for(TGStudyStudentCourseRel rel : relList) {
				rel.setStatus(StudentCourseRelStatusEnum.EXIT_COURSE.name());
				rel.setUpdateTime(new Date());
			}
			this.update(relList);
		}

		smartResponse.setResult(IConstant.OP_SUCCESS);
		smartResponse.setMsg("退班操作成功");
		return smartResponse;
	}

	public List<TGStudyStudentCourseRel> findNormalByStudentId(String studentId) {
		Map<String, Object> params = new HashMap<>();
		params.put("status", StudentCourseRelStatusEnum.NORMAL.name());
		params.put("studentId", studentId);
		return this.findByParam(params).getDatas();
	}
}
