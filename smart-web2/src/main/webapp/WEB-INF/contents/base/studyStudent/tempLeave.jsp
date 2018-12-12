<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="form-edit" action="studyStudent/subTempLeave">
       <input type="hidden" name="studentId" value="${student.id}">

	   <div class="form-group m-b-10">
		   <label for="name" class="col-sm-2 control-label">学生</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control input-readonly" data-label-name="名称" id="name" value="${student.name}" readonly/>
		   </div>
	   </div>

	   <div class="form-group m-b-10">
		   <label for="remainCourse" class="col-sm-2 control-label">剩余课时</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control input-readonly" data-label-name="名称" id="remainCourse" value="${student.remainCourse}" readonly/>
		   </div>
	   </div>

	   <div class="form-group m-b-10">
		   <label for="statusSelect" class="col-sm-2 control-label">休学更改</label>
		   <div class="col-sm-9 p-l-0">
			   <select class="form-control require" name="status" id="statusSelect">
				   <option value="TEMP_LEAVE" <c:if test="${student.status eq 'TEMP_LEAVE'}">selected</c:if> >休学</option>
				   <option value="BACK_STUDY" <c:if test="${student.status eq 'NORMAL'}">selected</c:if> >返校</option>
			   </select>
		   </div>
	   </div>

       <div class="text-center">
           <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyStudent/list?name=${searchStudentName}">
               <i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
       </div>
	</form>
</div><!-- wrap-content-dialog -->
