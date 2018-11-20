<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/class-config.js"></script>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="teacher-course-add" action="studyCourse/saveCourse" target=".bootstrap-dialog-message">
       <input type="hidden" name="teacherId" id="teacherId" value="${teacherId}">
       <input type="hidden" name="schoolName" id="schoolName">
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
           <label for="courseTime" class="col-sm-2 control-label">授课时间</label>
           <div class="col-sm-9 p-l-0">
               <select name="courseTime" class="form-control require" id="courseTime">
                   <option value="">--请选择--</option>
                   <option value="8:00-10:30" >8:00-10:30</option>
                   <option value="13:00-15:30" >13:00-15:30</option>
                   <option value="18:00-20:30" >18:00-20:30</option>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="schoolId" class="col-sm-2 control-label">校区</label>
           <div class="col-sm-9 p-l-0">
               <select name="schoolId" class="form-control require" id="schoolId">
                   <option value="">--请选择--</option>
                   <c:forEach items="${schools}" var="school">
                       <option value="${school.id}" >${school.name}</option>
                   </c:forEach>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="classroomId" class="col-sm-2 control-label">教室</label>
           <div class="col-sm-9 p-l-0">
               <select name="classroomId" class="form-control require" id="classroomId">
                   <option value="">--请选择--</option>
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
        $("#schoolId").change(function () {
            var text = $(this).find("option:selected").text();
            $("#schoolName").val(text);
            var value = $(this).find("option:selected").val();
            if(null == value || '' == value) {
                $("#classroomId").val('');
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

        $("#classroomId").change(function () {
            $("#classroomName").val($(this).find("option:selected").text());
        });

    });

    function initClassroomSelect(data) {
        $("#classroomId").empty();
        if(null != data && "1" === data.result && data.totalNum > 0) {
            $("#classroomId").append("<option value=''>--请选择--</option>");
            $.each(data.datas, function(index, classroom) {
                $("#classroomId").append("<option value='" + classroom.id + "'>" + classroom.name + "</option>");
            });
        } else {
            $("#classroomId").append("<option value=''>--无教室信息--</option>");
        }
    }

</script>