<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="form-edit" action="studyClassroom/update">
       <input type="hidden" name="id" value="${objBean.id}">
       <input type="hidden" name="studySchoolName" id="studySchoolName" value="${objBean.studySchoolName}">
       <div class="form-group m-b-10">
           <label for="input01" class="col-sm-2 control-label">校区</label>
           <div class="col-sm-9 p-l-0">
               <select name="studySchoolId" class="form-control" id="input01">
                   <c:forEach items="${schools}" var="school">
                       <option value="${school.id}" <c:if test="${school.id == objBean.studySchoolId}">selected</c:if> >${school.name}</option>
                   </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="input02" class="col-sm-2 control-label">名称</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control require" name="name" data-label-name="名称" id="input02" value="${objBean.name}"/>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="input03" class="col-sm-2 control-label">描述</label>
           <div class="col-sm-9 p-l-0">
               <textarea class="form-control require" name="description" data-label-name="描述" rows="8" id="input03" cols="60">${objBean.description}</textarea>
           </div>
       </div>

       <div class="text-center">
           <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyClassroom/list">
               <i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
       </div>
	</form>
</div><!-- wrap-content-dialog -->

<script>
    $(function () {
        $("#input01").change(function () {
            var text = $(this).find("option:selected").text()
            $("#studySchoolName").val(text);
        });

    });
</script>