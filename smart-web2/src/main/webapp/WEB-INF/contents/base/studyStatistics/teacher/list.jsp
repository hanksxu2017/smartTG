<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="wrap-content">
	<div class="panel panel-default no-border">
	    <div class="panel-search">
              <form class="form-inline cnoj-entry-submit" id="search-form" method="post" role="form" action="studyStatistics/teacher/list">

	              <div class="form-group p-r-10">
		              <label for="tIdSelForSearchStatistics" class="control-label">授课教师</label>
			              <select class="form-control" id="tIdSelForSearchStatistics" name="teacherId">
				              <option value="">--请选择--</option>
				              <c:forEach items="${teachers}" var="teacher">
					              <option value="${teacher.id}"  <c:if test="${searchParam.teacherId eq teacher.id}">selected</c:if>  >${teacher.name}</option>
				              </c:forEach>
			              </select>
	              </div>

	              <div class="form-group p-r-10">
		              <label for="monthSelForSearchStatistics" class="control-label">月份</label>
			              <select class="form-control" id="monthSelForSearchStatistics" name="month">
				              <c:forEach items="${monthList}" var="item">
					              <option value="${item.month}" <c:if test="${searchParam.month eq item.month}">selected</c:if>  >${item.monthDesc}</option>
				              </c:forEach>
			              </select>
	              </div>

				  <div class="form-group p-l-10">
					  <span class="btn btn-primary btn-sm cnoj-search-submit">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
				  </div>
              </form>
          </div>
		<!-- table -->

		<cnoj:table smartResp="${smartResp}" headers="月份,教师,班级,学生,课时数,课时人次,退班,退学,退班率,退学率,创建时间"
		  isCheckbox="1" isRowSelected="1" currentUri="${currentUri}"
		  refreshBtn="${refreshBtn}"
		  page="${pageParam}"
		/>
   </div>
</div>