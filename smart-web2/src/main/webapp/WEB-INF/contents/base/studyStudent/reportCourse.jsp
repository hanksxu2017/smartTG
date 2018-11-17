<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/class-config.js"></script>
<div class="wrap-content-dialog">
    <form class="form-horizontal" role="form" id="student-class-add" action="studyStudent/subReportCourse">
        <input type="hidden" name="studentId" id="studentId" value="${student.id}"/>
        <input type="hidden" name="teacherName" id="teacherName" />

        <div class="form-group m-b-10">
            <label for="teacherId" class="col-sm-2 control-label">授课教师</label>
            <div class="col-sm-9 p-l-0">
                <select name="teacherId" class="form-control require" id="teacherId">
                    <option value="">--请选择--</option>
                    <c:forEach items="${teachers}" var="teacher">
                        <option value="${teacher.id}" >${teacher.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="weekInfo" class="col-sm-2 control-label">星期</label>
            <div class="col-sm-9 p-l-0">
                <select name="weekInfo" class="form-control require" id="weekInfo">
                    <option value="">--请选择--</option>
                    <option value="1" >星期一</option>
                    <option value="2" >星期二</option>
                    <option value="3" >星期三</option>
                    <option value="4" >星期四</option>
                    <option value="5" >星期五</option>
                    <option value="6" >星期六</option>
                    <option value="7" >星期天</option>
                </select>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="courseId" class="col-sm-2 control-label">班级</label>
            <div class="col-sm-9 p-l-0">
                <select name="courseId" class="form-control require" id="courseId">
                    <!-- 动态加载 -->
                </select>
            </div>
        </div>



        <div class="text-center">
            <button type="button"
                    class="btn btn-sm btn-success cnoj-class-config-submit"
                    data-uri="studyStudent/subReportCourse"
                    data-config-id="${studentId}"
                    data-form-id="student-class-add"
                    data-alert-msg="请正确填写！"
                    data-refresh-uri="studyStudent/classList?id=${studentId}"
                    data-refresh-target="#student-class-tab" > &nbsp;
                <i class="glyphicon glyphicon-ok-sign"></i> 确定 &nbsp;</button>
        </div>
    </form>
</div>
<!-- wrap-content-dialog -->


<script>
    $(function () {

        $("#teacherId").change(function () {
            var text = $(this).find("option:selected").text();
            $("#teacherName").val(text);
        });


    });
</script>