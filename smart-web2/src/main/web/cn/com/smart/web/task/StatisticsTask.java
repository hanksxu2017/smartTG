package cn.com.smart.web.task;

import cn.com.smart.web.service.StudyStatisticsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

@Slf4j
public class StatisticsTask {

	@Autowired
	private StudyStatisticsService statisticsService;

	public void execute() {
		log.info("------统计任务开始执行------");
		this.statisticsService.doTeacherMonthStatistics();
	}
}
