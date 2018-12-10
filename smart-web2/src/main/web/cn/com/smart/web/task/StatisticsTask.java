package cn.com.smart.web.task;

import cn.com.smart.web.service.StudyStService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

@Slf4j
public class StatisticsTask {

	@Autowired
	private StudyStService statisticsService;

	public void execute() {
		log.info("------统计任务--开始------");
		this.statisticsService.doTeacherMonthStatistics();

		this.statisticsService.doStudentStatistics();
		log.info("------统计任务--結束------");
	}

}
