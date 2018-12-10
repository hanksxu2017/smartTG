package cn.com.smart.web.task;

import cn.com.smart.utils.DateUtil;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import cn.com.smart.web.service.CourseBusinessService;
import cn.com.smart.web.service.StudyCourseService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;

/**
 * 生成周課時
 */
@Slf4j
public class GenerateWeekCourseTask {

	@Autowired
	private CourseBusinessService courseBusinessService;

	@Autowired
	private StudyCourseService courseService;

	public void execute() {
		log.info("------生成周課時任務--开始------");
		Date curDate = new Date();
		if(1 != DateUtil.getWeek(curDate)) {
			log.error("开始日期非星期一,拒绝生成!------【請及時查看任務執行時間配置信息】");
			return;
		}
		List<TGStudyCourse> courseList = this.courseService.findNormal().getDatas();
		if(CollectionUtils.isEmpty(courseList)) {
			log.error("未找到有效課時信息!------【請及時查看班級配置信息】");
			return;
		}

		this.courseBusinessService.generateWeekCourseRecord(curDate, courseList);
		log.info("------生成周課時任務--結束------");
	}

}
