<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/class-config.js"></script>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="teacher-class-add" action="studyTeacher/saveClass" target=".bootstrap-dialog-message">
       <input type="hidden" name="teacherId" id="teacherId" value="${teacherId}">
       <input type="hidden" name="classroomName" id="classroomName">

       <div class="form-group m-b-10">
           <label for="input01" class="col-sm-2 control-label">名称</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control require" name="name" data-label-name="名称" id="input01" />
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="weekInfo" class="col-sm-2 control-label">星期</label>
           <div class="col-sm-9 p-l-0">
               <select name="weekInfo" class="form-control require" id="weekInfo">
                   <option value="">--请选择--</option>
                   <option value="1" >星期一</option>
                   <option value="2" >星期二</option>
                   <option value="3" >星期三</option>
                   <option value="4" >星期四</option>
                   <option value="5" >星期五</option>
                   <option value="6" >星期六</option>
                   <option value="7" >星期天</option>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="courseIndex" class="col-sm-2 control-label">授课时间</label>
           <div class="col-sm-9 p-l-0">
               <select name="courseIndex" class="form-control require" id="courseIndex">
                   <option value="">--请选择--</option>
                   <option value="1" >8:00-10:30</option>
                   <option value="2" >13:00-15:30</option>
                   <option value="3" >18:00-20:30</option>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="classroomId" class="col-sm-2 control-label">教室</label>
           <div class="col-sm-9 p-l-0">
               <select name="classroomId" class="form-control require" id="classroomId">
                   <option value="">--请选择--</option>
                   <c:forEach items="${classrooms}" var="classroom">
                       <option value="${classroom.id}" >${classroom.name}</option>
                   </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="description" class="col-sm-2 control-label">描述</label>
           <div class="col-sm-9 p-l-0">
               <textarea class="form-control" name="description" data-label-name="描述" rows="8" id="description" cols="60"></textarea>
           </div>
       </div>


       <div class="text-center">
           <button type="button"
                   class="btn btn-sm btn-success cnoj-class-config-submit"
                   data-uri="studyTeacher/saveClass.json"
                   data-config-id="${teacherId}"
                   data-form-id="teacher-class-add"
                   data-alert-msg="请正确填写！"
                   data-refresh-uri="studyTeacher/classList?id=${teacherId}"
                   data-refresh-target="#teacher-class-tab" > &nbsp;
               <i class="glyphicon glyphicon-ok-sign"></i> 确定 &nbsp;</button>
       </div>
	</form>
</div><!-- wrap-content-dialog -->