<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="wrap-content">
	<div class="panel no-border" id="courseRecordSimpleList">
		<div class="panel-search borer-bottom">
			<form class="form-inline cnoj-entry-submit" id="search-form-user" method="post" role="form"
			      action="studyCourse/record/simpList" target="#courseRecord-tab">

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

				<div class="form-group p-r-10">
					<label for="teacherId">日期:</label>
					<select name="selectCourseDate" class="form-control" id="selectCourseDate">
						<option value="">--请选择--</option>
						<c:forEach items="${courseDates}" var="courseDate">
							<option value="${courseDate.courseDate}"
							        <c:if test="${searchParam.selectCourseDate eq courseDate.courseDate}">selected</c:if>
							        <c:if test="${curDate eq courseDate.courseDate}">style="background: #84C1FF"</c:if>
									>${courseDate.description}</option>
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
		<cnoj:tableItem smartResp="${smartResp}"
		                headers="授课时间,名称,状态"
		                headerWidths="45%,40%,15%"
		                isRowSelected="1"
		                currentUri="${currentUri }"
		                selectedEventProp="${selectedEventProp }"
		                refreshBtn="${refreshBtn}"
		                page="${pageParam }"
		/>
	</div>
</div>
<script>
    $(function () {
        var trs = $("#courseRecordSimpleList").find('table').find('tbody');
    });

</script>
