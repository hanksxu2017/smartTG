package cn.com.smart.web.dao.impl;

import cn.com.smart.dao.impl.BaseDaoImpl;
import cn.com.smart.res.SQLResUtil;
import cn.com.smart.res.sqlmap.SqlMapping;
import cn.com.smart.web.bean.entity.TGStudyClassroom;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 版本DAO
 * @author XUWENYI <br />
 * 2018年11月15日
 * @version 1.0
 * @since 1.0
 */
@Repository
public class StudyClassroomDao extends BaseDaoImpl<TGStudyClassroom> {

	private SqlMapping sqlMap;
	private Map<String,Object> params;

	public StudyClassroomDao() {
		sqlMap = SQLResUtil.getBaseSqlMap();
	}
}
