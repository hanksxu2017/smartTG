<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="<%=basePath%>"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/class-config.js"></script>
<div class="wrap-content-dialog">
    <form class="form-horizontal" role="form" id="courseRecord-student-allSign" action="studyStudent/subAllSign">
        <input type="hidden" name="courseRecordId" value="${courseRecord.id }"/>
        <div class="form-group m-b-10">
            <label for="name" class="col-sm-2 control-label">班级</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly"
                       data-label-name="名称" id="name" value="${courseRecord.courseName}" readonly/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="teacherName" class="col-sm-2 control-label">授课教师</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly"
                       data-label-name="名称" id="teacherName" value="${courseRecord.teacherName}" readonly/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="courseDate" class="col-sm-2 control-label">授课日期</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly"
                       data-label-name="名称" id="courseDate" value="${courseRecord.courseDate}" readonly/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="courseTime" class="col-sm-2 control-label">授课时间</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly"
                       data-label-name="名称" id="courseTime" value="${courseRecord.courseTime}" readonly/>
            </div>
        </div>

        <div class="text-center">
            <button type="button"
                    <c:if test="${null != disableSign and disableSign eq 'yes'}">disabled</c:if>
                    class="btn btn-sm btn-success cnoj-class-config-submit"
                    data-uri="studyStudent/subAllSign"
                    data-config-id="${courseRecord.id }"
                    data-form-id="courseRecord-student-allSign"
                    data-alert-msg="请稍候再试！"
                    data-refresh-uri="studyStudent/studentList?courseRecordId=${courseRecord.id }"
                    data-refresh-target="#courseRecord-student-tab" > &nbsp;
                <i class="glyphicon glyphicon-ok-sign"></i> 学员全部签到 &nbsp;</button>
        </div>

    </form>
</div>
<!-- wrap-content-dialog -->