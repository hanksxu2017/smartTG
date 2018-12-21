<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="<%=basePath%>"/>
<div class="wrap-content-dialog">
	<form class="form-horizontal" role="form" id="form-add" action="studyClassroom/rental/subEdit">
		<input type="hidden" name="classroomName" id="classroomName" value="${classroomRental.classroomName}">
		<input type="hidden" name="courseTime" id="courseTime" value="${classroomRental.courseTime}">
        <input type="hidden" name="id" value="${classroomRental.id}">

		<div class="form-group m-b-10">
			<label for="tenantNameForEditRental" class="col-sm-2 control-label">租赁人</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="tenantName" data-label-name="名称"
					   id="tenantNameForEditRental" value="${classroomRental.tenantName}"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="tenantPhoneForEditRental" class="col-sm-2 control-label">联系方式</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="tenantPhone" data-label-name="名称"
					   id="tenantPhoneForEditRental" value="${classroomRental.tenantPhone}"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="classroomSelForEditRental" class="col-sm-2 control-label">教室</label>
			<div class="col-sm-9 p-l-0">
				<select name="classroomId" class="form-control require" id="classroomSelForEditRental">
					<option value="">--请选择--</option>
					<c:forEach items="${classrooms}" var="classroom">
						<option value="${classroom.id}" <c:if test="${classroom.id eq classroomRental.classroomId}">selected</c:if> >${classroom.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="weekInfoForEditRental" class="col-sm-2 control-label">星期</label>
			<div class="col-sm-9 p-l-0">
				<select name="weekInfo" class="form-control require" id="weekInfoForEditRental">
					<option value="">--请选择--</option>
					<c:forEach items="${weekInfoList}" var="weekInfo">
						<option value="${weekInfo.busiValue}" <c:if test="${weekInfo.busiValue eq classroomRental.weekInfo}">selected</c:if> >${weekInfo.busiName}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="courseTimeForEditRental" class="col-sm-2 control-label">租赁时间</label>
			<div class="col-sm-9 p-l-0">
				<select name="courseTimeIndex" class="form-control require" id="courseTimeForEditRental">
					<option value="${classroomRental.courseTimeIndex}">${classroomRental.courseTime}</option>
				</select>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="endDateForEditRental" class="col-sm-2 control-label">到期时间</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control cnoj-date require" data-date-format="yyyy-mm-dd" name="endDate"
				       data-label-name="出生日期" id="endDateForEditRental" value="${classroomRental.endDate}"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="descriptionForEditRental" class="col-sm-2 control-label">备注</label>
			<div class="col-sm-9 p-l-0">
				<textarea class="form-control require" name="description" data-label-name="备注" rows="8" id="descriptionForEditRental"
				          cols="60">${classroomRental.description}</textarea>
			</div>
		</div>

		<div class="text-center">
			<button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyClassroom/rental/list">
				<i class="glyphicon glyphicon-ok-sign"></i> 确定
			</button>
		</div>
	</form>
</div>
<!-- wrap-content-dialog -->

<script>
    $(function () {
        $("#classroomSelForEditRental").change(function () {
            var text = $(this).find('option:selected').text();
            $("#classroomName").val(text);

			getIdleCourseTime($(this).val(), $("#weekInfoForEditRental").val())
        });

        $("#courseTimeForEditRental").change(function () {
            $("#courseTime").val($(this).find("option:selected").text());
        });

        $("#weekInfoForEditRental").change(function () {
            getIdleCourseTime($("#classroomSelForEditRental").val(), $(this).val())
        });

    });
    
    function getIdleCourseTime(classroomId, weekInfo) {
        if(null != weekInfo && '' !== weekInfo && null != classroomId && '' !== classroomId) {
            $("#courseTimeForEditRental").empty();
            $("#courseTimeForEditRental").append("<option value=''>--请选择--</option>");
            var url = "${ctx}/studyClassroom/rental/getIdleCourseTime?weekInfo=" + weekInfo + "&classroomId=" + classroomId;
            $.ajax({
                type: "GET",
                url: url,
                success: function(data){
                    if(data.result === '1') {
                        $.each(data.datas, function(index, value){
                            $("#courseTimeForEditRental").append("<option value='" + value.busiValue +"'>" + value.busiName + "</option>");
                        });
                    }
                }
            });
        }
    }
</script>