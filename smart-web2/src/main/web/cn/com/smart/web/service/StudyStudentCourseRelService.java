package cn.com.smart.web.service;

import cn.com.smart.bean.SmartResponse;
import cn.com.smart.constant.IConstant;
import cn.com.smart.exception.DaoException;
import cn.com.smart.exception.ServiceException;
import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudyStudentClassRel;
import cn.com.smart.web.bean.entity.TGStudyStudentCourseRel;
import cn.com.smart.web.dao.impl.StudyStudentClassRelDao;
import cn.com.smart.web.dao.impl.StudyStudentCourseRelDao;
import com.mixsmart.utils.StringUtils;
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
}
