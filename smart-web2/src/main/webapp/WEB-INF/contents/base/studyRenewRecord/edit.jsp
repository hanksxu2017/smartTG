<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="form-edit" action="studyRenewRecord/update">
       <input type="hidden" name="id" value="${renewRecord.id}">

	   <div class="form-group m-b-10">
		   <label for="studentName" class="col-sm-2 control-label">学生</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control input-readonly" data-label-name="名称" id="studentName" value="${student.name}" readonly/>
		   </div>
	   </div>

	   <div class="form-group m-b-10">
		   <label for="renewAmount" class="col-sm-2 control-label">应付金额(单位元)</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control input-readonly" id="renewAmount" data-label-name="应付金额" value="${student.renewAmount}" readonly/>
		   </div>
	   </div>

	   <div class="form-group m-b-10">
		   <label for="amount" class="col-sm-2 control-label">补缴金额(单位元)</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control require" name="amount" data-label-name="补缴额度" id="amount" value="${renewRecord.amount}"/>
		   </div>
	   </div>

       <div class="form-group m-b-10">
           <label for="courseCount" class="col-sm-2 control-label">新增课时</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control require" name="courseCount" data-label-name="新增课时" id="courseCount" value="${renewRecord.courseCount}"/>
           </div>
       </div>

	   <div class="form-group m-b-10">
		   <label for="input10" class="col-sm-2 control-label">备注</label>
		   <div class="col-sm-9 p-l-0">
			   <textarea class="form-control" name="description" rows="3" id="input10" cols="60">${renewRecord.description}</textarea>
		   </div>
	   </div>


       <div class="text-center">
           <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyRenewRecord/list">
               <i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
       </div>
	</form>
</div><!-- wrap-content-dialog -->
