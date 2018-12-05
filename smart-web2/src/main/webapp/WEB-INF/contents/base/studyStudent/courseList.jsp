<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<div class="wrap-content">
    <div class="panel no-border">
        <div class="panel-search">
              <form class="form-inline cnoj-entry-submit" id="search-form-user" method="post" role="form" action="studyStudent/courseList" target="#student-course-tab">
                  <input type="hidden" name="id" value="${searchParam.id }" />
	              <div class="form-group p-r-10">
		              <label for="status">状态：</label>
		              <select name="status" class="form-control" id="status">
			              <option value="NORMAL" >正常</option>
			              <option value="ALL" >全部</option>
			              <option value="EXIT_COURSE" >已退班</option>
		              </select>
	              </div>
				  <div class="form-group p-l-10">
					  <span class="btn btn-info btn-sm cnoj-search-submit">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
				  </div>
              </form>
          </div>

		<cnoj:table smartResp="${smartResp }" headers="名称,星期,时间,教室,教师,状态,签到类型" isCheckbox="1" isRowSelected="1" page="${pageParam }" currentUri="${currentUri }"
		 delBtn="${delBtn }" customBtns="${customBtns}"
		 />
	</div>

</div>