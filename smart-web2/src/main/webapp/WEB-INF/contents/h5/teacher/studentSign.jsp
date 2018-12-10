<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
            /*background: url('../../../../images/bkh5.jpg') no-repeat fixed center;*/
        }

        td, th {
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>
<body class="bg">


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
                <label>应到:<span id="planCount">12</span>&nbsp;实到:<span id="actualCount">8</span>&nbsp;缺席:<span
                        id="absentCount">1</span>&nbsp;未签:<span id="unSignCount">3</span></label><br/>
            </div>
        </div>


    </div>

    <div>
        <table class="table table-condensed table-bordered" id="studentTable">

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

        $("#chooseCourseRecForSign").change(function () {
            var courseRecId = $(this).val();
            if (null != courseRecId && '' !== courseRecId) {
                $.ajax({
                    type: "GET",
                    url: "${ctx}/studyTeacherH5/queryCourseRecord?courseRecordId=" + courseRecId,
                    success: function (data) {
                        if (null != data.result && '1' === data.result) {
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
                    success: function (data) {
                        initStudentTable(data);
                    }
                });
            }

        });
    });

    function subStudentSign(btn) {
        var studentId = $(btn).data('studentid');
        var courseRecordId = $('#chooseCourseRecForSign').val();
        var status = $(btn).data('type');
        if (null != studentId && '' != studentId &&
            null != status && '' != status &&
            null != courseRecordId && '' != courseRecordId) {
            var url = '${ctx}/studyTeacherH5/subStudentSign?studentId=' + studentId +
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
            $.each(data.datas, function (index, value) {
                var tr = "<tr>";
                tr += "<td style='valign:middle;padding-top: 14px;'>" + value.studentName + "</td>";
                if (value.status === 'SIGNED') {
                    tr += "<td>";
                    tr += "<button class='btn btn-success' data-type='signed' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>签到</button>&nbsp;";
                    tr += "<button class='btn' data-type='leave' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>请假</button>&nbsp;";
                    tr += "<button class='btn' data-type='truant' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>缺课</button>";
                    tr += "</td>";
                } else if (value.status === 'PERSONAL_LEAVE') {
                    tr += "<td>";
                    tr += "<button class='btn' data-type='signed' data-type='signed' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>签到</button>";
                    tr += "<button class='btn btn-info' data-type='leave' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>请假</button>";
                    tr += "<button class='btn' data-type='truant' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>缺课</button>";
                    tr += "</td>";
                } else if (value.status === 'PLAY_TRUANT') {
                    tr += "<td>";
                    tr += "<button class='btn' data-type='signed' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>签到</button>";
                    tr += "<button class='btn' data-type='leave' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>请假</button>";
                    tr += "<button class='btn btn-danger' data-type='truant' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>缺课</button>";
                    tr += "</td>";
                } else {
                    tr += "<td>";
                    tr += "<button class='btn' data-type='signed' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>签到</button>&nbsp;";
                    tr += "<button class='btn' data-type='leave' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>请假</button>&nbsp;";
                    tr += "<button class='btn' data-type='truant' data-studentid='" + value.studentId + "' onclick='subStudentSign(this)'>缺课</button>";
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




