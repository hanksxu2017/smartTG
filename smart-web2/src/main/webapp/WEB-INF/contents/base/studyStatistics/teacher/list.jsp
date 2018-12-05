<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<div class="wrap-content">
	<div class="panel panel-default no-border">
<%--	    <div class="panel-search">
              <form class="form-inline cnoj-entry-submit" id="search-form" method="post" role="form" action="studyStatistics/teacher/list">
                  <div class="form-group p-r-10">
				    <label for="search-input01">学生姓名:</label>
				    <input type="text" class="form-control input-form-control" id="search-input01" name="studentName" placeholder="学生姓名" value="${searchParam.studentName}"/>
				  </div>
				  <div class="form-group p-l-10">
					  <span class="btn btn-primary btn-sm cnoj-search-submit">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
				  </div>
              </form>
          </div>--%>
		<!-- table -->

		<cnoj:table smartResp="${smartResp}" headers="月份,教师,班级,学生,课时数,课时人次,退班,退学,新生,新生退班,新生退学,退班率,退学率,新生退班率,新生退学率,创建时间"
		  isCheckbox="1" isRowSelected="1" currentUri="${currentUri}"
		  refreshBtn="${refreshBtn}"
		  page="${pageParam}"
		/>
   </div>
</div>