<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="<%=basePath%>"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/class-config.js"></script>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="teacher-course-add" action="studyCourse/saveCourse" target=".bootstrap-dialog-message">
       <input type="hidden" name="teacherId" id="teacherId" value="${teacher.id}">
	   <input type="hidden" name="teacherName" id="teacherName" value="${teacher.name}">
       <input type="hidden" name="schoolName" id="schoolName">
       <input type="hidden" name="classroomName" id="classroomName">
       <input type="hidden" name="courseTime" id="courseTime">

<%--       <div class="form-group m-b-10">
           <label for="nameForTechAddCourse" class="col-sm-2 control-label">名称</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control require" name="name" data-label-name="名称" id="nameForTechAddCourse" />
           </div>
       </div>--%>

	   <div class="form-group m-b-10">
		   <label for="teacherNameForTechAddCourse" class="col-sm-2 control-label">教师</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control input-readonly" data-label-name="教师" id="teacherNameForTechAddCourse" value="${teacher.name}" readonly/>
		   </div>
	   </div>

       <div class="form-group m-b-10">
           <label for="weekInfoForTechAddCourse" class="col-sm-2 control-label">星期</label>
           <div class="col-sm-9 p-l-0">
               <select name="weekInfo" class="form-control require" id="weekInfoForTechAddCourse">
                   <option value="">--请选择--</option>
	               <c:forEach items="${weekInfoList}" var="weekInfo">
		               <option value="${weekInfo.busiValue}" >${weekInfo.busiName}</option>
	               </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="courseTimeForTechAddCourse" class="col-sm-2 control-label">授课时间</label>
           <div class="col-sm-9 p-l-0">
               <select name="courseTimeIndex" class="form-control require" id="courseTimeForTechAddCourse">
                   <option value="">--请选择--</option>
                   <c:forEach items="${courseTimes}" var="courseTime">
                       <option value="${courseTime.busiValue}" >${courseTime.busiName}</option>
                   </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="schoolIdForTechAddCourse" class="col-sm-2 control-label">校区</label>
           <div class="col-sm-9 p-l-0">
               <select name="schoolId" class="form-control require" id="schoolIdForTechAddCourse">
                   <option value="">--请选择--</option>
                   <c:forEach items="${schools}" var="school">
                       <option value="${school.id}" >${school.name}</option>
                   </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="classroomIdForTechAddCourse" class="col-sm-2 control-label">教室</label>
           <div class="col-sm-9 p-l-0">
               <select name="classroomId" class="form-control require" id="classroomIdForTechAddCourse">
                   <option value="">--请选择--</option>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="descriptionForTechAddCourse" class="col-sm-2 control-label">描述</label>
           <div class="col-sm-9 p-l-0">
               <textarea class="form-control" name="description" data-label-name="描述" rows="8" id="descriptionForTechAddCourse" cols="60"></textarea>
           </div>
       </div>


       <div class="text-center">
           <button type="button"
                   class="btn btn-sm btn-success cnoj-class-config-submit"
                   data-uri="studyCourse/saveCourse"
                   data-config-id="${teacherId}"
                   data-form-id="teacher-course-add"
                   data-alert-msg="请正确填写！"
                   data-refresh-uri="studyTeacher/courseList?id=${teacherId}"
                   data-refresh-target="#teacher-course-tab" > &nbsp;
               <i class="glyphicon glyphicon-ok-sign"></i> 确定 &nbsp;</button>
       </div>
	</form>
</div><!-- wrap-content-dialog -->

<script>
    $(function () {
        $("#schoolIdForTechAddCourse").change(function () {
            var text = $(this).find("option:selected").text();
            $("#schoolName").val(text);
            var value = $(this).find("option:selected").val();
            if(null == value || '' == value) {
                $("#classroomIdForTechAddCourse").val('');
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

        $("#classroomIdForTechAddCourse").change(function () {
            $("#classroomName").val($(this).find("option:selected").text());
        });
        
        $("#courseTimeForTechAddCourse").change(function () {
            $("#courseTime").val($(this).find("option:selected").text());
        });

    });

    function initClassroomSelect(data) {
        $("#classroomIdForTechAddCourse").empty();
        if(null != data && "1" === data.result && data.totalNum > 0) {
            $("#classroomIdForTechAddCourse").append("<option value=''>--请选择--</option>");
            $.each(data.datas, function(index, classroom) {
                $("#classroomIdForTechAddCourse").append("<option value='" + classroom.id + "'>" + classroom.name + "</option>");
            });
        } else {
            $("#classroomIdForTechAddCourse").append("<option value=''>--无教室信息--</option>");
        }
    }

</script>