<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/class-config.js"></script>
<div class="wrap-content-dialog">
    <form class="form-horizontal" role="form" id="courseRecord-student-sign" action="studyStudent/subSign">
        <input type="hidden" name="courseRecordId" id="courseRecordId" value="${courseRecord.id}"/>
        <input type="hidden" name="studentId" id="studentId" value="${studentId}"/>

	    <div class="form-group m-b-10">
		    <label for="courseName" class="col-sm-2 control-label">课时</label>
		    <div class="col-sm-9 p-l-0">
			    <input type="text" class="form-control input-readonly" data-label-name="课时"
			           id="courseName" value="${courseRecord.courseName}" readonly/>
		    </div>
	    </div>

	    <div class="form-group m-b-10">
		    <label for="courseTime" class="col-sm-2 control-label">授课时间</label>
		    <div class="col-sm-9 p-l-0">
			    <input type="text" class="form-control input-readonly" data-label-name="授课时间"
			           id="courseTime" value="${courseRecord.courseDate} ${courseRecord.courseTime}" readonly/>
		    </div>
	    </div>

	    <div class="form-group m-b-10">
		    <label for="teacherName" class="col-sm-2 control-label">授课教师</label>
		    <div class="col-sm-9 p-l-0">
			    <input type="text" class="form-control input-readonly" data-label-name="授课教师"
			           id="teacherName" value="${courseRecord.teacherName}" readonly/>
		    </div>
	    </div>

        <div class="form-group m-b-10">
            <label for="studentName" class="col-sm-2 control-label">学生</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" data-label-name="学生"
                       id="studentName" value="${studentName}" readonly/>
            </div>
        </div>

<%--	    <div class="form-group m-b-10">
		    <label for="parentName" class="col-sm-2 control-label">学生家长</label>
		    <div class="col-sm-9 p-l-0">
			    <input type="text" class="form-control input-readonly" data-label-name="学生"
			           id="parentName" value="${student.parentName}" readonly/>
		    </div>
	    </div>--%>

        <div class="form-group m-b-10">
	        <label for="status" class="col-sm-2 control-label">点名操作</label>
            <div class="col-sm-9 p-l-0">
                <input type="radio" class="require" data-label-name="签到"
                       id="status" name="status" value="SIGNED" checked="checked">签到</input>
	            <input type="radio" data-label-name="事假"
	                   name="status" value="PERSONAL_LEAVE">事假</input>
	            <input type="radio" data-label-name="旷课"
	                   name="status" value="PLAY_TRUANT">旷课</input>
	            <input type="radio" data-label-name="缺席"
	                   name="status" value="OTHER_ABSENT">缺席</input>
            </div>
        </div>

	    <div class="form-group m-b-10">
		    <label for="input03" class="col-sm-2 control-label">备注</label>
		    <div class="col-sm-9 p-l-0">
			    <textarea class="form-control" name="description" data-label-name="描述" rows="8" id="input03" cols="60" ></textarea>
		    </div>
	    </div>

        <div class="text-center">
            <button type="button"
                    class="btn btn-sm btn-success cnoj-class-config-submit"
                    data-uri="studyStudent/subSign"
                    data-config-id="${courseRecord.id}"
                    data-form-id="courseRecord-student-sign"
                    data-alert-msg="请正确填写！"
                    data-refresh-uri="studyStudent/studentList?courseRecordId=${courseRecord.id}"
                    data-refresh-target="#courseRecord-student-tab" > &nbsp;
                <i class="glyphicon glyphicon-ok-sign"></i> 确定 &nbsp;</button>
        </div>
    </form>
</div>
<!-- wrap-content-dialog -->


<script>
    $(function () {

    });

    function getWeekInfoInCN(week) {
        var weeks = new Array();
        weeks[1] = "一";
        weeks[2] = "二";
        weeks[3] = "三";
        weeks[4] = "四";
        weeks[5] = "五";
        weeks[6] = "六";
        weeks[7] = "天";
        return weeks[week];
    }
</script>