<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<div class="wrap-content-dialog">
	<form class="form-horizontal" role="form" id="form-add" action="studyClassroom/rental/save">
		<input type="hidden" name="classroomName" id="classroomName">
		<input type="hidden" name="courseTime" id="courseTime">

		<div class="form-group m-b-10">
			<label for="tenantNameForAddRental" class="col-sm-2 control-label">租赁人</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="tenantName" data-label-name="名称" id="tenantNameForAddRental"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="tenantPhoneForAddRental" class="col-sm-2 control-label">联系方式</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="tenantPhone" data-label-name="名称" id="tenantPhoneForAddRental"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="classroomSelForAddRental" class="col-sm-2 control-label">教室</label>
			<div class="col-sm-9 p-l-0">
				<select name="classroomId" class="form-control require" id="classroomSelForAddRental">
					<option value="">--请选择--</option>
					<c:forEach items="${classrooms}" var="classroom">
						<option value="${classroom.id}">${classroom.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="weekInfoForAddRental" class="col-sm-2 control-label">星期</label>
			<div class="col-sm-9 p-l-0">
				<select name="weekInfo" class="form-control require" id="weekInfoForAddRental">
					<option value="">--请选择--</option>
					<c:forEach items="${weekInfoList}" var="weekInfo">
						<option value="${weekInfo.busiValue}" >${weekInfo.busiName}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="courseTimeForAddRental" class="col-sm-2 control-label">租赁时间</label>
			<div class="col-sm-9 p-l-0">
				<select name="courseTimeIndex" class="form-control require" id="courseTimeForAddRental">
					<option value="">--请选择--</option>
				</select>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="endDateForAddRental" class="col-sm-2 control-label">到期时间</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control cnoj-date require" data-date-format="yyyy-mm-dd" name="endDate"
				       data-label-name="出生日期" id="endDateForAddRental"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="descriptionForAddRental" class="col-sm-2 control-label">备注</label>
			<div class="col-sm-9 p-l-0">
				<textarea class="form-control require" name="description" data-label-name="备注" rows="8" id="descriptionForAddRental"
				          cols="60"></textarea>
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
        $("#classroomSelForAddRental").change(function () {
            var text = $(this).find("option:selected").text();
            $("#classroomName").val(text);

			getIdleCourseTime($(this).val(), $("#weekInfoForAddRental").val())
        });

        $("#courseTimeForAddRental").change(function () {
            $("#courseTime").val($(this).find("option:selected").text());
        });

        $("#weekInfoForAddRental").change(function () {
            getIdleCourseTime($("#classroomSelForAddRental").val(), $(this).val())
        });

    });
    
    function getIdleCourseTime(classroomId, weekInfo) {
        if(null != weekInfo && null != classroomId) {
            $("#courseTimeForAddRental").empty();
            $("#courseTimeForAddRental").append("<option value=''>--请选择--</option>");
            var url = "${ctx}/studyClassroom/rental/getIdleCourseTime?weekInfo=" + weekInfo + "&classroomId=" + classroomId;
            $.ajax({
                type: "GET",
                url: url,
                success: function(data){
                    if(data.result === '1') {
                        $.each(data.datas, function(index, value){
                            $("#courseTimeForAddRental").append("<option value='" + value.busiValue +"'>" + value.busiName + "</option>");
                        });
                    }
                }
            });
        }
    }
</script>