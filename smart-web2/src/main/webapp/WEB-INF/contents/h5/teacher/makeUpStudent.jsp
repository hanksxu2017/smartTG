<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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


<div class="container-fluid" style="width: 100%">

    <div style="padding-top: 6px;">
        <ul class="pager">
            <li class="previous"><a href="${ctx}/h5/login?teacherId=${teacherId}&courseRecordId=${courseRecordId}">&larr; 返回上一页</a></li>
        </ul>

    </div>
    <div style="padding-top: 2px;">
        <div class="input-group col-sm-4">
            <form method="post" role="form" action="/h5/makeUpStudent">
                <input type="text" class="form-control" name="name" placeholder="学生姓名关键字" value="${studentName}">
                <input type="hidden" id="courseRecordId" name="courseRecordId" value="${courseRecordId}">
                <button class="btn btn-info" type="submit" style="padding-top: 6px;">搜索</button>
            </form>
        </div><!-- /input-group -->
    </div>

    <div style="margin-top: 6px;align-content: center">
        <table class="table table-striped table-condensed" id="absentStudentTable" style="width: 80%;">

            <thead>
            <tr>
                <th style="width: 40%;">学生</th>
                <th style="width: 30%;">缺课数</th>
                <th style="width: 30%;">操作</th>
            </tr>
            </thead>

            <tbody>
                <c:choose>
                    <c:when test="${smartResp.totalNum > 0}">
                        <c:forEach var="item" items="${smartResp.datas}">
                            <tr>
                                <td style='valign:middle;padding-top: 14px;'><p>${item[1]}</p></td>
                                <td style='valign:middle;padding-top: 14px;'><p>${item[3]}</p></td>
                                <td style='valign:middle;padding-top: 14px;'><button class="btn btn-info choose-to-make-up" data-student-id="${item[0]}">补课</button></td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="3">更多.....</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan='3' style='text-align: center;'>无学生信息</td></tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../../../../js/jquery-1.11.3.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../../../../plugins/bootstrap/js/bootstrap.min.js"></script>


<script>
    $(function () {
        $(".choose-to-make-up").on("click", function () {
            var tr = $(this).parent().parent();
            var studentId = $(this).data('student-id');
            var uri = "/h5/subMakeUpStudent?courseRecordId=" +
                $("#courseRecordId").val() + "&studentId=" + studentId;

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
        });
    });
</script>


</body>
</html>




