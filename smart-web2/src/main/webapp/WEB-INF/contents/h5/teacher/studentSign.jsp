<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="ctx" value="<%=basePath%>"/>
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

        td, th {
            text-align: center;
        }
    </style>
</head>
<body class="bg">

<input type="hidden" id="teacherId" value="${teacherId}">
<div class="container-fluid" style="width: 100%;align-content: center">

    <div>
        <ul class="nav nav-tabs">
            <li class="active"><a href="#">课时点名</a></li>
            <%--			<li><a href="#">课时统计</a></li>
                        <li><a href="#">本周课时</a></li>--%>
        </ul>
    </div>
    <div style="margin-top: 6px;width: 80%;align-self: center">
        <select class="form-control select-sm" id="chooseCourseRecForSign">
            <c:choose>
                <c:when test="${courseRecordList != null}">
                    <option value="">--请选择课时--</option>
                    <c:forEach items="${courseRecordList}" var="courseRecord">
                        <option value="${courseRecord.id}" <c:if test="${not empty chooseCourseRecord && chooseCourseRecord.id eq courseRecord.id}">selected</c:if> >${courseRecord.courseName}</option>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <option value="">--未找到待签到课时--</option>
                </c:otherwise>
            </c:choose>
        </select>
    </div>

	<div id="courseInfoDiv" style="margin-top: 6px;background-color:rgba(255, 255, 255, 0.5);" <c:if test="${empty chooseCourseRecord}">hidden</c:if> >
				<div class="panel-body">
					<label>时间:<span id="courseTime"><c:if test="${not empty chooseCourseRecord}">${chooseCourseRecord.courseDate}&nbsp;${chooseCourseRecord.courseTime}</c:if></span></label><br/>
					<label>教室:<span id="classroomName"><c:if test="${chooseCourseRecord != null}">${chooseCourseRecord.classroomName}</c:if></span></label><br/>
					<label>应到:<span id="planCount"><c:if test="${chooseCourseRecord != null}">${chooseCourseRecord.studentQuantityPlan}</c:if></span>
						&nbsp;实到:<span id="actualCount"><c:if test="${chooseCourseRecord != null}">${chooseCourseRecord.studentQuantityActual}</c:if></span>
						&nbsp;缺席:<span id="absentCount"><c:if test="${chooseCourseRecord != null}">${chooseCourseRecord.studentPersonalLeave + chooseCourseRecord.studentPlayTruant}</c:if></span>
						&nbsp;未签:<span id="unSignCount"><c:if test="${chooseCourseRecord != null}">${chooseCourseRecord.studentQuantityPlan - chooseCourseRecord.studentQuantityActual - chooseCourseRecord.studentPersonalLeave - chooseCourseRecord.studentPlayTruant}</c:if></span>
						&nbsp;补课:<span id="makeUpCount">${makeUpCount}</span></label>
					<br/>

						<c:if test="${not empty chooseCourseRecord}">
							<c:choose>
								<c:when test="${chooseCourseRecord.status eq 'NORMAL_END'}">
									<span class="text-info">已结课</span>
								</c:when>
								<c:otherwise>
									<span class="text-warning">未结课</span>
								</c:otherwise>
							</c:choose>
						</c:if>
					<c:if test="{empty chooseCourseRecord}"><span id="courseRecordStatus"></span></c:if>
				</div>
			</div>


    <div style="margin-top: 6px;">
        <table class="table table-condensed table-bordered" id="studentTable">

            <thead>
            <tr>
                <th style="width: 30%;">学生</th>
                <th style="width: 70%;">操作</th>
            </tr>
            </thead>
            <c:if test="${studentRecordList != null}">
	            <c:forEach var="item" items="${studentRecordList}">
		            <tr>
			            <td style='valign:middle;padding-top: 14px;'><p>${item.studentName}</p></td>
			            <c:choose>
				            <c:when test="${item.status eq 'SIGNED'}">
			                    <td>
				                    <button class='btn btn-success' data-type='signed' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>签到</button>
				                    <button class='btn' data-type='leave' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>请假</button>
				                    <button class='btn' data-type='truant' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>缺课</button>
			                    </td>
				            </c:when>
				            <c:when test="${item.status eq 'PERSONAL_LEAVE'}">
					            <td>
						            <button class='btn' data-type='signed' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>签到</button>
						            <button class='btn btn-info' data-type='leave' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>请假</button>
						            <button class='btn' data-type='truant' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>缺课</button>
					            </td>
				            </c:when>
				            <c:when test="${item.status eq 'PLAY_TRUANT'}">
					            <td>
						            <button class='btn' data-type='signed' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>签到</button>
						            <button class='btn' data-type='leave' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>请假</button>
						            <button class='btn btn-danger' data-type='truant' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>缺课</button>
					            </td>
				            </c:when>
				            <c:when test="${item.status eq 'X_MAKE_UP'}">
					            <td style='text-align:left;padding-left:18px;'><button class='btn btn-info' data-studentid='" + value.studentId + "' onclick='removeMakeUp(this)'><i class='glyphicon glyphicon-remove'>移除补课</i></button></td></tr>
				            </c:when>
							<c:otherwise>
								<td>
									<button class='btn' data-type='signed' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>签到</button>
									<button class='btn' data-type='leave' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>请假</button>
									<button class='btn' data-type='truant' data-studentid='${item.studentId}' onclick='subStudentSign(this)'>缺课</button>
								</td>
							</c:otherwise>
			            </c:choose>
		            </tr>
	            </c:forEach>
	            <tr>
		            <td colspan='2' style='text-align:left;padding-left:18px;'>
			            <button <c:if test="${empty canSign || !(canSign eq 'YES')}">disabled='disabled'</c:if> class='btn btn-info' onclick='jumpToChooseStu()'><i class='glyphicon glyphicon-plus'>学生补课</i></button>
		            </td>
	            </tr>
            </c:if>
        </table>
    </div>
</div>

<div class="modal fade" id="signFailedModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<span id="showSignFailedMsg">暂时无法进行点名操作</span>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
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

        $("#chooseCourseRecForSign").change(function () {
            var courseRecId = $(this).val();
            if (null != courseRecId && '' !== courseRecId) {
                $.ajax({
                    type: "GET",
                    url: "${ctx}/h5/queryCourseRecord?courseRecordId=" + courseRecId,
                    success: function (data) {
                        if (null != data.result && '1' === data.result) {
                            loadCourseInfo(data.data, data.size);
                        }
                    }
                });

                $.ajax({
                    type: "GET",
                    url: "${ctx}/h5/queryStudent?courseRecordId=" + courseRecId,
                    success: function (data) {
                        initStudentTable(data);
                    }
                });
            }

        });
    });
    
    function loadCourseInfo(data, makeUpCount) {
        $("#courseTime").text(data.courseDate + ' ' + data.courseTime);
        $("#classroomName").text(data.classroomName);
        $("#planCount").text(data.studentQuantityPlan);
        $("#actualCount").text(data.studentQuantityActual);
        var absent = data.studentPersonalLeave + data.studentPlayTruant;
        $("#absentCount").text(absent);

        var unSign = data.studentQuantityPlan - data.studentQuantityActual - absent;
        $("#unSignCount").text(unSign);

        $("#makeUpCount").text(makeUpCount);

        if(data.status === 'NORMAL_END') {
            $("#courseRecordStatus").text('已结课');
            if(!$("#courseRecordStatus").hasClass('text-info')) {
                $("#courseRecordStatus").addClass('text-info');
            }
        } else {
            $("#courseRecordStatus").text('未结课');
            if(!$("#courseRecordStatus").hasClass('text-warning')) {
                $("#courseRecordStatus").addClass('text-warning');
            }
        }

        $("#courseInfoDiv").show();
    }

    function subStudentSign(btn) {
        var studentId = $(btn).data('studentid');
        var courseRecordId = $('#chooseCourseRecForSign').val();
        var status = $(btn).data('type');
        if (null != studentId && '' != studentId &&
            null != status && '' != status &&
            null != courseRecordId && '' != courseRecordId) {
            var url = '${ctx}/h5/subStudentSign?studentId=' + studentId +
                '&courseRecordId=' + courseRecordId + '&status=' + status;
            $.ajax({
                type: 'GET',
                url: url,
                success: function (data) {
                    if ('1' === data.result) {
                        if ('signed' === status) {
                            switchBtnClass(btn, 'btn-success');
                        } else if ('leave' === status) {
                            switchBtnClass(btn, 'btn-warning');
                        } else if ('truant' === status) {
                            switchBtnClass(btn, 'btn-danger');
                        }

                        loadCourseInfo(data.data, data.size);
                    } else {
                        $("#showSignFailedMsg").text(data.msg);
                        $('#signFailedModal').modal('show');
                    }
                }
            });
        }
    }

    function switchBtnClass(btn, btnClassType) {
        // 先渲染自己
        if (!$(btn).hasClass(btnClassType)) {
            $(btn).addClass(btnClassType);
        }
        // 清空兄弟节点
        $.each(['btn-success', 'btn-warning', 'btn-danger'], function (index, value) {
            $.each($(btn).siblings(), function (bIndex, bValue) {
                if ($(bValue).hasClass(value)) {
                    $(bValue).removeClass(value);
                }
            });
        });

    }

    function initStudentTable(data) {
        $("#studentTable tr:not(:first)").empty("");
        if (data.result !== '1') {
            $("#studentTable").append("<tr><td colspan='3' style='text-align: center;'>无学生信息</td></tr>");
        } else {
            var isCanSign = true;
            if(data.size === -1) {
                isCanSign = false;
            }
            $.each(data.datas, function (index, value) {
                var tr = "<tr>";
                tr += "<td style='valign:middle;padding-top: 14px;'><p>" + value.studentName + "</p></td>";
                if (value.status === 'SIGNED') {
                    tr += "<td>";
                    tr += createButton('btn-success', 'signed', value.studentId, isCanSign, '签到');
                    tr += createButton('', 'leave', value.studentId, isCanSign, '请假');
                    tr += createButton('', 'truant', value.studentId, isCanSign, '缺课');
                    tr += "</td>";
                } else if (value.status === 'PERSONAL_LEAVE') {
                    tr += "<td>";
                    tr += createButton('', 'signed', value.studentId, isCanSign, '签到');
                    tr += createButton('btn-info', 'leave', value.studentId, isCanSign, '请假');
                    tr += createButton('', 'truant', value.studentId, isCanSign, '缺课');
                    tr += "</td>";
                } else if (value.status === 'PLAY_TRUANT') {
                    tr += "<td>";
                    tr += createButton('', 'signed', value.studentId, isCanSign, '签到');
                    tr += createButton('', 'leave', value.studentId, isCanSign, '请假');
                    tr += createButton('btn-danger', 'truant', value.studentId, isCanSign, '缺课');
                    tr += "</td>";
                } else if(value.status === 'X_MAKE_UP') {
                    tr += "<td style='text-align:left;padding-left:18px;'><button class='btn btn-info' data-studentid='" + value.studentId + "' onclick='removeMakeUp(this)'><i class='glyphicon glyphicon-plus'>学生补课</i></button></td>";
                } else {
                    tr += "<td>";
                    tr += createButton('', 'signed', value.studentId, isCanSign, '签到');
                    tr += createButton('', 'leave', value.studentId, isCanSign, '请假');
                    tr += createButton('', 'truant', value.studentId, isCanSign, '缺课');
                    tr += "</td>";
                }
                tr += "</tr>";
                $("#studentTable").append(tr);
            });
            if(isCanSign) {
                var addMakeUpTr = "<tr><td colspan='2' style='text-align:left;padding-left:18px;'><button class='btn btn-info' onclick='jumpToChooseStu()'><i class='glyphicon glyphicon-plus'>学生补课</i></button></td></tr>";
            } else {
                var addMakeUpTr = "<tr><td colspan='2' style='text-align:left;padding-left:18px;'><button disabled='disabled' class='btn btn-info' onclick='jumpToChooseStu()'><i class='glyphicon glyphicon-plus'>学生补课</i></button></td></tr>";

            }
            $("#studentTable").append(addMakeUpTr);
        }
    }

    function createButton(classType, type, studentId, isCanSign, btnName) {
        var stBtn = '';
        if(isCanSign) {
            stBtn = "<button class='btn " + classType + "' data-type='" + type + "' data-studentid='" + studentId + "' onclick='subStudentSign(this)'>" + btnName + "</button>&nbsp;";
        } else {
            stBtn = "<button disabled='disabled' class='btn " + classType + "' data-type='" + type + "' data-studentid='" + studentId + "' onclick='subStudentSign(this)'>" + btnName + "</button>&nbsp;";
        }
        return stBtn;
    }
    
    function jumpToChooseStu() {
        var url = "${ctx}/h5/makeUpStudent?courseRecordId=" + $("#chooseCourseRecForSign").val() + "&teacherId=" + $("#teacherId").val();
        window.location.href = url;
    }
    
    function removeMakeUp(removeBtn) {
        var tr = $(removeBtn).parent().parent();
        var studentId = $(this).data('studentid');
        var courseRecordId = $('#chooseCourseRecForSign').val();
        var uri = "/h5/removeMakeUp?courseRecordId=" + courseRecordId + "&studentId=" + studentId;

        $.ajax({
            type: "GET",
            url: uri,
            success: function (data) {
                if('1' === data.result) {
                    tr.remove();
                } else {
                    alert(data.msg);
                }
            }
        });
    }

</script>


</body>
</html>




