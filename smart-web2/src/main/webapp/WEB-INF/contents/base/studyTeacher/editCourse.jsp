<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="<%=basePath%>"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/class-config.js"></script>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="teacher-course-edit" action="studyCourse/subEditCourse" target=".bootstrap-dialog-message">
	   <input type="hidden" name="id" value="${course.id}">
       <input type="hidden" name="teacherId" id="teacherId" value="${course.teacherId}">
       <input type="hidden" name="schoolName" id="schoolName" value="${course.schoolName}">
       <input type="hidden" name="classroomName" id="classroomName" value="${course.classroomName}">
	   <input type="hidden" name="courseTime" id="courseTime" value="${course.courseTime}">

	   <div class="form-group m-b-10">
		   <label for="teacherNameForEditCourse" class="col-sm-2 control-label">教师</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control input-readonly" data-label-name="教师"
			          id="teacherNameForEditCourse" value="${course.teacherName}" readonly/>
		   </div>
	   </div>

       <div class="form-group m-b-10">
           <label for="nameForTechEditCourse" class="col-sm-2 control-label">名称</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control require" name="name" data-label-name="名称" id="nameForTechEditCourse" value="${course.name}"/>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="weekInfoForTechAddCourse" class="col-sm-2 control-label">星期</label>
           <div class="col-sm-9 p-l-0">
               <select name="weekInfo" class="form-control require" id="weekInfoForTechAddCourse">
                   <option value="">--请选择--</option>
	               <c:forEach items="${weekInfoList}" var="weekInfo">
		               <option value="${weekInfo.busiValue}"  <c:if test="${course.weekInfo eq weekInfo.busiValue}">selected</c:if> >${weekInfo.busiName}</option>
	               </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="courseTimeForTechEditCourse" class="col-sm-2 control-label">授课时间</label>
           <div class="col-sm-9 p-l-0">
               <select name="courseTimeIndex" class="form-control require" id="courseTimeForTechEditCourse">
                   <option value="">--请选择--</option>
	               <c:forEach items="${courseTimes}" var="courseTime">
		               <option value="${courseTime.busiValue}"  <c:if test="${course.courseTimeIndex eq courseTime.busiValue}">selected</c:if> >${courseTime.busiName}</option>
	               </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="schoolIdForTechEditCourse" class="col-sm-2 control-label">校区</label>
           <div class="col-sm-9 p-l-0">
               <select name="schoolId" class="form-control require" id="schoolIdForTechEditCourse">
                   <option value="">--请选择--</option>
                   <c:forEach items="${schools}" var="school">
                       <option value="${school.id}"  <c:if test="${course.schoolId eq school.id}">selected</c:if> >${school.name}</option>
                   </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="classroomIdForTechEditCourse" class="col-sm-2 control-label">教室</label>
           <div class="col-sm-9 p-l-0">
               <select name="classroomId" class="form-control require" id="classroomIdForTechEditCourse">
                   <option value="">--请选择--</option>
	               <c:forEach items="${classrooms}" var="classroom">
		               <option value="${classroom.id}"  <c:if test="${course.classroomId eq classroom.id}">selected</c:if> >${classroom.name}</option>
	               </c:forEach>
               </select>
           </div>
       </div>

	   <div class="form-group m-b-10">
		   <label for="createTimeForEditCourse" class="col-sm-2 control-label">建班日期</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control cnoj-date require" data-date-format="yyyy-mm-dd" name="createTimeStr" id="createTimeForEditCourse"
			          data-label-name="建班日期" value="<fmt:formatDate value="${course.createTime}" type="both" pattern="yyyy-MM-dd"></fmt:formatDate>"/>
		   </div>
	   </div>

       <div class="form-group m-b-10">
           <label for="descriptionForTechEditCourse" class="col-sm-2 control-label">描述</label>
           <div class="col-sm-9 p-l-0">
               <textarea class="form-control" name="description" data-label-name="描述" rows="8" id="descriptionForTechEditCourse" cols="60">${course.description}</textarea>
           </div>
       </div>


       <div class="text-center">
           <button type="button"
                   class="btn btn-sm btn-success cnoj-class-config-submit"
                   data-uri="studyCourse/subEditCourse"
                   data-config-id="${course.teacherId}"
                   data-form-id="teacher-course-edit"
                   data-alert-msg="请正确填写！"
                   data-refresh-uri="studyTeacher/courseList?id=${course.teacherId}"
                   data-refresh-target="#teacher-course-tab" > &nbsp;
               <i class="glyphicon glyphicon-ok-sign"></i> 确定 &nbsp;</button>
       </div>
	</form>
</div><!-- wrap-content-dialog -->

<script>
    $(function () {
        $("#schoolIdForTechEditCourse").change(function () {
            var text = $(this).find("option:selected").text();
            $("#schoolName").val(text);
            var value = $(this).find("option:selected").val();
            if(null == value || '' == value) {
                $("#classroomIdForTechEditCourse").val('');
            } else {
                var url = "${ctx}/studyClassroom/queryBySchool?schoolId=" + value;
                $.ajax({
                    type: "GET",
                    url: url,
                    success: function(data){
                        initClassroomSelect(data);
                    }
                });
            }
        });


        $("#courseTimeForTechEditCourse").change(function () {
            $("#courseTime").val($(this).find("option:selected").text());
        });

        $("#classroomIdForTechEditCourse").change(function () {
            $("#classroomName").val($(this).find("option:selected").text());
        });

    });

    function initClassroomSelect(data) {
        $("#classroomIdForTechEditCourse").empty();
        if(null != data && "1" === data.result && data.totalNum > 0) {
            $("#classroomIdForTechEditCourse").append("<option value=''>--请选择--</option>");
            $.each(data.datas, function(index, classroom) {
                $("#classroomIdForTechEditCourse").append("<option value='" + classroom.id + "'>" + classroom.name + "</option>");
            });
        } else {
            $("#classroomIdForTechEditCourse").append("<option value=''>--无教室信息--</option>");
        }
    }

</script>