package cn.com.smart.web.bean.search;

import cn.com.smart.filter.bean.FilterParam;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StudentClassRelSearch extends FilterParam {

    private String studentName;

    private String classId;

    private String teacherId;

}
