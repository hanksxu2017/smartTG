package cn.com.smart.web.bean.course;

import cn.com.smart.web.bean.entity.TGStudyClassroom;
import cn.com.smart.web.bean.entity.TGStudyCourse;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class CourseTh {

	// 默认空出2个单元格
	int blankCount = 2;

	// 教室名称
	List<TGStudyClassroom> classroomList = new ArrayList<>();
}
