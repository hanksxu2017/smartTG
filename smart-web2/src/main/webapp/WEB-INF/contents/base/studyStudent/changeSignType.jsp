<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/class-config.js"></script>
<div class="wrap-content-dialog">
    <form class="form-horizontal" role="form" id="student-course-change-sign-type" action="studyStudent/course/subChangeSignType">
        <input type="hidden" name="studentId" id="studentId" value="${student.id}"/>
        <input type="hidden" name="courseId" id="courseId" value="${course.id}"/>

        <div class="form-group m-b-10">
            <label for="studentName" class="col-sm-2 control-label">学生</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" data-label-name="学生" id="studentName" value="${student.name}" readonly>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="courseName" class="col-sm-2 control-label">班级</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" data-label-name="班级" id="courseName" value="${course.name}" readonly>
            </div>
        </div>

	    <div class="form-group m-b-10">
		    <label for="signTypeForStuReportCourse" class="col-sm-2 control-label">点名类型</label>
		    <div class="col-sm-9 p-l-0">
			    <select name="signType" class="form-control require" id="signTypeForStuReportCourse">
				    <option value="NORMAL" <c:if test="${rel.signType eq 'NORMAL'}">selected</c:if> >正常签到</option>
				    <option value="SIGN_AS_HAS" <c:if test="${rel.signType eq 'SIGN_AS_HAS'}">selected</c:if> >到班签到(带*号类)</option>
			    </select>
		    </div>
	    </div>

        <div class="text-center">
            <button type="button"
                    class="btn btn-sm btn-success cnoj-class-config-submit"
                    data-uri="studyStudent/course/subChangeSignType"
                    data-config-id="${student.id}"
                    data-form-id="student-course-change-sign-type"
                    data-modal-body-id="student-change-sign-type-dialog-btDialog"
                    data-alert-msg="请正确填写！"
                    data-refresh-uri="studyStudent/courseInfo?id=${student.id}"
                    data-refresh-target="#student-course-list-dialog" > &nbsp;
                <i class="glyphicon glyphicon-ok-sign"></i> 确定 &nbsp;</button>
        </div>
    </form>
</div>
<!-- wrap-content-dialog -->
