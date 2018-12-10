<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>普陀围棋协会</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- 引入 Bootstrap -->
	<link href="../../../../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link rel="icon" href="../../../../images/logo.png">
	<style type="text/css">
		.bg {
			background-size: cover;
			background: url('../../../../images/bkh5.jpg') no-repeat fixed center;
		}
	</style>
</head>
<body class="bg">


<div>

	<div>
		<ul class="nav nav-tabs">
			<li class="active"><a href="#">课时点名</a></li>
<%--			<li><a href="#">课时统计</a></li>
			<li><a href="#">本周课时</a></li>--%>
		</ul>
	</div>
	<div style="margin-top: 6px;width: 70%">
		<select class="form-control select-sm" id="chooseCourseRecForSign">
			<c:choose>
				<c:when test="${courseRecordList != null}">
					<option value="">--请选择课时--</option>
					<c:forEach items="${courseRecordList}" var="courseRecord">
						<option value="${courseRecord.id}">${courseRecord.courseName}</option>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<option value="">--未找到待签到课时--</option>
				</c:otherwise>
			</c:choose>
		</select>
	</div>

	<div id="courseInfoDiv" style="margin-top: 6px;display: none;">
		<div class="panel panel-info">
			<div class="panel-body">
				<label>时间:<span id="courseTime">2018-11-29 18:30-20:00</span></label><br/>
				<label>教室:<span id="classroomName">灵秀一</span></label><br/>
				<label>应到:<span id="planCount">12</span>&nbsp;实到:<span id="actualCount">8</span>&nbsp;缺席:<span id="absentCount">1</span>&nbsp;未签:<span id="unSignCount">3</span></label><br/>
			</div>
		</div>


	</div>

	<div>
		<table class="table table-condensed" id="studentTable">

			<thead>
			<tr>
				<th style="width: 30%;">学生</th>
				<th style="width: 70%;">操作</th>
			</tr>
			</thead>
		</table>
	</div>
</div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../../../../js/jquery-1.11.3.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../../../../plugins/bootstrap/js/bootstrap.min.js"></script>


<script>
    $(function () {
        $("#subUnSigned").on("click", function () {
			var studentId = $("#studentIdWhoAbsent").val();
			var courseRecordId = $("#chooseCourseRecForSign").val();

			alert(studentId + "---缺席了--" + courseRecordId);
			// 统一使用缺席
            var url = "${ctx}/studyTeacherH5/subStudentSign?courseRecordId=" + courseRecordId + "&studentId=" + studentId + "&status=OTHER_ABSENT";
            $.ajax({
                type: "GET",
                url: url,
                success: function(data){
					if(null != data.result && '1' === data.result) {
                        $('#myModal').modal('hide');
					} else {
						$("#failureMsg").text(data.msg);
					}
                }
            });

        });

        $("#chooseCourseRecForSign").change(function () {
			var courseRecId = $(this).val();
			if(null != courseRecId && '' !== courseRecId) {
                $.ajax({
                    type: "GET",
                    url: "${ctx}/studyTeacherH5/queryCourseRecord?courseRecordId=" + courseRecId,
                    success: function(data){
                        if(null != data.result && '1' === data.result) {
                            $("#courseTime").text(data.data.courseDate + ' ' + data.data.courseTime);
                            $("#classroomName").text(data.data.classroomName);
                            $("#planCount").text(data.data.studentQuantityPlan);
                            $("#actualCount").text(data.data.studentQuantityActual);
                            var absent = data.data.studentPersonalLeave + data.data.studentPlayTruant;
                            $("#absentCount").text(absent);

                            var unSign = data.data.studentQuantityPlan - data.data.studentQuantityActual;
                            $("#unSignCount").text(unSign);
                            $("#courseInfoDiv").show();
                        }
                    }
                });

                $.ajax({
                    type: "GET",
                    url: "${ctx}/studyTeacherH5/queryStudent?courseRecordId=" + courseRecId,
                    success: function(data){
                        initStudentTable(data);
                    }
                });
			}

        });
    });
	
    function initStudentTable(data) {
        $("#studentTable tr:not(:first)").empty("");
	    if(data.result !== '1') {
            $("#studentTable").append("<tr><td colspan='3' style='text-align: center;'>无学生信息</td></tr>");
	    } else {
            $.each(data.datas, function(index,value){
                var tr = "<tr>";
                tr += "<td>" + value.studentName + "</td>";
                if(value.status === 'SIGNED') {
                    tr += "<td>";
                    tr += "<button class='btn btn-success sign-signed' data-studentId='" + value.studentId + "'>签到</button>";
                    tr += "<button class='btn sign-absent' data-studentid='" + value.studentId + "'>请假</button>";
                    tr += "<button class='btn sign-absent' data-studentid='" + value.studentId + "'>缺课</button>";
                    tr += "</td>";
                } else if(value.status === 'PERSONAL_LEAVE') {
                    tr += "<td>";
                    tr += "<button class='btn sign-signed' data-studentId='" + value.studentId + "'>签到</button>";
                    tr += "<button class='btn btn-info sign-absent' data-studentid='" + value.studentId + "'>请假</button>";
                    tr += "<button class='btn sign-absent' data-studentid='" + value.studentId + "'>缺课</button>";
                    tr += "</td>";
                } else if(value.status === 'PLAY_TRUANT') {
                    tr += "<td>";
                    tr += "<button class='btn sign-signed' data-studentId='" + value.studentId + "'>签到</button>";
                    tr += "<button class='btn sign-absent' data-studentid='" + value.studentId + "'>请假</button>";
                    tr += "<button class='btn btn-danger sign-absent' data-studentid='" + value.studentId + "'>缺课</button>";
                    tr += "</td>";
                } else {
                    tr += "<td>";
                    tr += "<button class='btn sign-signed' data-studentId='" + value.studentId + "'>签到</button>";
                    tr += "<button class='btn sign-absent' data-studentid='" + value.studentId + "'>请假</button>";
                    tr += "<button class='btn sign-absent' data-studentid='" + value.studentId + "'>缺课</button>";
                    tr += "</td>";
                }
                tr += "</tr>";
                $("#studentTable").append(tr);
            });
	    }
    }

</script>


</body>
</html>




