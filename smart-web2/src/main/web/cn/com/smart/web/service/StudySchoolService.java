package cn.com.smart.web.service;

import cn.com.smart.service.impl.MgrServiceImpl;
import cn.com.smart.web.bean.entity.TGStudySchool;
import cn.com.smart.web.bean.entity.TNVersion;
import cn.com.smart.web.constant.enums.VersionType;
import cn.com.smart.web.dao.impl.StudySchoolDao;
import cn.com.smart.web.dao.impl.VersionDao;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 版本服务类
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Service
public class StudySchoolService extends MgrServiceImpl<TGStudySchool> {

	@Override
	public StudySchoolDao getDao() {
		return (StudySchoolDao)super.getDao();
	}

}
