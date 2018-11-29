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
		html, body {
			margin: 0;
			padding: 0;
			width: auto;
			background: url('../../../../images/bkh5.jpg') no-repeat center top;
			/*background-size: cover;*/
		}
	</style>
</head>
<body>

<div class="container-fluid">

	<div>
		<ul class="nav nav-tabs">
			<li class="active"><a href="#">课时点名</a></li>
			<li><a href="#">课时统计</a></li>
			<li><a href="#">本周课时</a></li>
		</ul>
	</div>
	<div style="margin-top: 6px;">
		<select class="form-control" id="chooseCourseRecForSign">
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

	<div style="margin-top: 6px;">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">课时信息</h3>
			</div>
			<div class="panel-body">
				<label>日期:<span>2018-11-29 18:30-20:00</span></label><br/>
				<label>教室:<span>灵秀一</span></label><br/>
				<label>应到:<span>12</span>&nbsp;实到:<span>8</span>&nbsp;缺席:<span>1</span>&nbsp;未签:<span>3</span></label><br/>
			</div>
		</div>


	</div>

	<div>
		<table class="table table-condensed" id="studentTable">

			<thead>
			<tr>
				<th style="width: 30%">学生</th>
				<th style="width: 30%">状态</th>
				<th style="width: 40%">操作</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<td>学生小白</td>
				<td><span class="glyphicon glyphicon-ok text-success"></span></td>
				<td>
					<button class="btn btn-info">撤销</button>
				</td>
			</tr>
			<tr>
				<td>学生小青</td>
				<td></td>
				<td>
					<button class="btn btn-success">签到</button>
					<button class="btn btn-danger" data-toggle="modal" data-target="#myModal">缺席</button>
				</td>
			</tr>
			<tr>
				<td>学生小红</td>
				<td><span class="glyphicon glyphicon-remove text-danger"></span></td>
				<td>
					<button class="btn btn-info">撤销</button>
				</td>
			</tr>
			<tr>
				<td>学生小灰</td>
				<td></td>
				<td>
					<button class="btn btn-success">签到</button>
					<button class="btn btn-danger" data-toggle="modal" data-target="#myModal">缺席</button>
				</td>
			</tr>
			</tbody>
		</table>
	</div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h5 class="modal-title" id="myModalLabel">
					学生缺席
				</h5>
			</div>

			<div class="modal-body">
				<div class="form-group m-b-10">
					<input type="hidden" id="studentIdWhoAbsent"/>
					<label for="studentName" class="control-label">学生姓名</label>
					<input type="text" class="form-control input-readonly" data-label-name="学生姓名" id="studentName" readonly/>
				</div>
				<div class="form-group m-b-10">
					<label for="input01" class="control-label">签到操作</label>
					<input type="text" class="form-control input-readonly" data-label-name="签到操作" id="input01"
					       value="缺席" readonly/>
				</div>
				<div>
					<span class="text-danger" id="failureMsg"></span>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" class="btn btn-primary" id="subUnSigned">
					提交更改
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
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

        //绑定模态框展示的方法 
        $('#myModal').on('show.bs.modal', function (event) {
            // 触发事件的按钮  
            var button = $(event.relatedTarget);
            // 解析出whatever内容  
            var studentId = button.data('studentid');
            var studentName = button.data('studentname');
            //获得模态框本身
            var modal = $(this);
            modal.find("#failureMsg").text('');
            modal.find('#studentName').val(studentName);
            modal.find('#studentIdWhoAbsent').val(studentId);
        });


        $("#chooseCourseRecForSign").change(function () {
			var courseRecId = $(this).val();
			if(null != courseRecId && '' !== courseRecId) {
                var url = "${ctx}/studyTeacherH5/queryStudent?courseRecordId=" + courseRecId;
                $.ajax({
                    type: "GET",
                    url: url,
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
                if(value.status === 'NORMAL') {
					tr += "<td></td>";
                    tr += "<td>";
                    tr += "<button class='btn btn-success sign-signed' data-studentId='" + value.studentId + "'>签到</button>";
                    tr += "<button class='btn btn-danger sign-absent' data-toggle='modal' data-target='#myModal' data-studentid='" + value.studentId + "' data-studentname='" + value.studentName + "'>缺席</button>";
                    tr += "</td>";
                } else if(value.status === 'SIGNED') {
                    tr += "<td><span class='glyphicon glyphicon-ok text-success'></span></td>";
	                tr += "<td><button class='btn btn-info sign-cancel' data-studentId='" + value.studentId + "'>撤销</button></td>";
                } else {
                    tr += "<td><span class='glyphicon glyphicon-remove text-danger'></span></td>";
                    tr += "<td><button class='btn btn-info' data-studentId='" + value.studentId + "'>撤销</button></td>";
                }
                tr += "</tr>";
                $("#studentTable").append(tr);
            });
	    }
    }

</script>


</body>
</html>




