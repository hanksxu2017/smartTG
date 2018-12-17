<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<div class="wrap-content">
	<div class="panel no-border">
        <div class="panel-search borer-bottom">
              <form class="form-inline cnoj-entry-submit" id="search-form-user" method="post" role="form" action="studyTeacher/simpList" target="#teacher-tab">
	              <div class="form-group p-r-10">
		              <label for="teacherId">教师:</label>
		              <select name="teacherId" class="form-control" id="teacherId">
			              <option value="">--请选择--</option>
			              <c:forEach items="${teachers}" var="teacher">
				              <option value="${teacher.id}"
				                      <c:if test="${searchParam.teacherId eq teacher.id}">selected</c:if> >${teacher.name}</option>
			              </c:forEach>
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
		<cnoj:tableItem smartResp="${smartResp}" headers="姓名,班级数" isRowSelected="1" currentUri="${currentUri }"
		  selectedEventProp="${selectedEventProp }" page="${pageParam }"
		 />
	</div>
</div>