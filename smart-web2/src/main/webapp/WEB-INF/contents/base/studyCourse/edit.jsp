<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="form-edit" action="studyCourse/update">
       <input type="hidden" name="id" value="${objBean.id}">
       <input type="hidden" name="teacherId" id="teacherId" value="${objBean.teacherId}">
       <input type="hidden" name="className" id="className" value="${objBean.className}">
       <input type="hidden" name="classroomName" id="classroomName" value="${objBean.classroomName}">

       <div class="form-group m-b-10">
          <label for="weekInfo" class="col-sm-2 control-label">星期</label>
          <div class="col-sm-9 p-l-0">
              <select name="weekInfo" class="form-control require" id="weekInfo">
                  <option value="">--请选择--</option>
                  <option value="星期一" <c:if test="${objBean.weekInfo eq '星期一'}">selected</c:if> >星期一</option>
                  <option value="星期二" <c:if test="${objBean.weekInfo eq '星期二'}">selected</c:if> >星期二</option>
                  <option value="星期三" <c:if test="${objBean.weekInfo eq '星期三'}">selected</c:if> >星期三</option>
                  <option value="星期四" <c:if test="${objBean.weekInfo eq '星期四'}">selected</c:if> >星期四</option>
                  <option value="星期五" <c:if test="${objBean.weekInfo eq '星期五'}">selected</c:if> >星期五</option>
                  <option value="星期六" <c:if test="${objBean.weekInfo eq '星期六'}">selected</c:if> >星期六</option>
                  <option value="星期天" <c:if test="${objBean.weekInfo eq '星期天'}">selected</c:if> >星期天</option>
              </select>
          </div>
      </div>

<div class="form-group m-b-10">
     <label for="courseTime" class="col-sm-2 control-label">授课时间</label>
     <div class="col-sm-9 p-l-0">
         <select name="courseTime" class="form-control require" id="courseTime">
             <option value="">--请选择--</option>
             <option value="8:00-10:30" <c:if test="${objBean.courseTime eq '8:00-10:30'}">selected</c:if> >8:00-10:30</option>
             <option value="18:00-20:30" <c:if test="${objBean.courseTime eq '18:00-20:30'}">selected</c:if> >18:00-20:30</option>
         </select>
     </div>
 </div>

       <div class="form-group m-b-10">
           <label for="classId" class="col-sm-2 control-label">班级</label>
           <div class="col-sm-9 p-l-0">
               <select name="classId" class="form-control require" id="classId">
                   <option value="">--请选择--</option>
                   <c:forEach items="${classes}" var="c">
                       <option value="${c.id}" <c:if test="${c.id eq objBean.classId}">selected</c:if> >${c.name}</option>
                   </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="classId" class="col-sm-2 control-label">授课教师</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control input-readonly" name="teacherName" data-label-name="授课教师"
                      id="teacherName" value="${objBean.teacherName}" readonly/>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="classroomId" class="col-sm-2 control-label">教室</label>
           <div class="col-sm-9 p-l-0">
               <select name="classroomId" class="form-control require" id="classroomId">
                   <c:forEach items="${classrooms}" var="classroom">
                       <option value="${classroom.id}" <c:if test="${classroom.id eq objBean.classroomId}">selected</c:if> >${classroom.name}</option>
                   </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="description" class="col-sm-2 control-label">描述</label>
           <div class="col-sm-9 p-l-0">
               <textarea class="form-control" name="description" data-label-name="描述" rows="8" id="description" cols="60">${objBean.description}</textarea>
           </div>
       </div>

  <div class="text-center">
      <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyCourse/list">
          <i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
  </div>
</form>
</div><!-- wrap-content-dialog -->

<script>
$(function () {

   $("#classroomId").change(function () {
       var text = $(this).find("option:selected").text();
       $("#classroomName").val(text);
   });

   $("#classId").change(function () {
       var text = $(this).find("option:selected").text();
       $("#className").val(text);

       var url = "${ctx}/studyClass/queryClass?id=" + $(this).find("option:selected").val();
       // 查询授课教师
        $.ajax({
            type: "GET",
            url: url,
            success: function(data){
                $("#teacherName").val(data.teacherName);
                $("#teacherId").val(data.teacherId);
            }
        });

   });

});
</script>