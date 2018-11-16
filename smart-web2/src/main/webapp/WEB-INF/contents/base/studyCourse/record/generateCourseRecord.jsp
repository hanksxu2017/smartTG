<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="ctx" value="${basePath}"/>
<div class="wrap-content-dialog">
    <form class="form-horizontal" role="form" id="form-edit" action="studyCourse/record/generate">

        <div class="form-group m-b-10">
            <label for="startDate" class="col-sm-2 control-label">开始日期</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" name="startDate" data-label-name="开始日期"
                       id="startDate" value="${startDate}" readonly/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="endDate" class="col-sm-2 control-label">结束日期</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" name="endDate" data-label-name="结束日期"
                       id="endDate" value="${endDate}" readonly/>
            </div>
        </div>


        <div class="text-center">
            <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyCourse/record/list">
                <i class="glyphicon glyphicon-ok-sign"></i> 确定
            </button>
        </div>
    </form>
</div>
<!-- wrap-content-dialog -->

<script>
    $(function () {


    });
</script>