<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/class-config.js"></script>
<div class="wrap-content-dialog">
    <form class="form-horizontal" role="form" id="student-class-add" action="studyStudent/course/subReportCourse">
        <input type="hidden" name="studentId" id="studentId" value="${studentId}"/>

        <div class="form-group m-b-10">
            <label for="teacherId" class="col-sm-2 control-label">授课教师</label>
            <div class="col-sm-9 p-l-0">
                <select class="form-control require" id="teacherId">
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
                <select class="form-control require" id="weekInfo">
                    <option value="">--请选择--</option>
                </select>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="courseId" class="col-sm-2 control-label">班级</label>
            <div class="col-sm-9 p-l-0">
                <select name="courseId" class="form-control require" id="courseId">
                    <option value="">--请选择--</option>
                    <!-- 动态加载 -->
                </select>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="classroom" class="col-sm-2 control-label">教室</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" data-label-name="教室"
                       id="classroom" readonly/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="courseTime" class="col-sm-2 control-label">上课时间</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" data-label-name="上课时间"
                       id="courseTime" readonly/>
            </div>
        </div>




        <div class="text-center">
            <button type="button"
                    class="btn btn-sm btn-success cnoj-class-config-submit"
                    data-uri="studyStudent/course/subReportCourse"
                    data-config-id="${studentId}"
                    data-form-id="student-class-add"
                    data-alert-msg="请正确填写！"
                    data-refresh-uri="studyStudent/courseList?id=${studentId}"
                    data-refresh-target="#student-course-tab" > &nbsp;
                <i class="glyphicon glyphicon-ok-sign"></i> 确定 &nbsp;</button>
        </div>
    </form>
</div>
<!-- wrap-content-dialog -->


<script>
    $(function () {

        $("#teacherId").change(function () {
            $("#weekInfo").val('');
            $("#courseId").val('');
            $("#courseTime").val('');
            $("#classroom").val('');

            var url = "${ctx}/studyCourse/queryWeeks?teacherId=" + $("#teacherId").val();
            $.ajax({
                type: "GET",
                url: url,
                success: function(data){
                    initWeekInfoSelect(data);
                }
            });

        });

        $("#weekInfo").change(function () {
            var weekInfo = $("#weekInfo").val();
            if(null == weekInfo || '' == weekInfo) {
                $("#courseId").val('');
            } else {
                var teacherId = $("#teacherId").val();
                var url = "${ctx}/studyCourse/queryCourse?weekInfo=" + weekInfo + "&teacherId=" + teacherId;
                // 查询教师在指定星期的班级信息
                $.ajax({
                    type: "GET",
                    url: url,
                    success: function(data){
                        initCourseSelect(data);
                    }
                });
            }
        });

        $("#courseId").change(function () {
            var courseId = $("#courseId").val();
            if(null == courseId || '' == courseId) {
                $("#courseTime").val('');
                $("#classroom").val('');
            } else {
                var url = "${ctx}/studyCourse/queryCourse?courseId=" + courseId;
                $.ajax({
                    type: "GET",
                    url: url,
                    success: function(data){
                        if(null != data && "1" === data.result && data.totalNum > 0) {
                            $.each(data.datas, function(idx, course) {
                                $("#courseTime").val(course.courseTime);
                                $("#classroom").val(course.classroomName);
                            });
                        }
                    }
                });
            }
        });
    });

    function initCourseSelect(data) {
        $("#courseId").empty();
        if(null != data && "1" === data.result && data.totalNum > 0) {
            $("#courseId").append("<option value=''>--请选择--</option>");
            $.each(data.datas, function(idx, course) {
                $("#courseId").append("<option value='" + course.id + "'>" + course.name + "</option>");
            });
        } else {
            $("#courseId").append("<option value=''>--无班级信息--</option>");
        }
    }

    function initWeekInfoSelect(data) {
        $("#weekInfo").empty();
        if(null != data && "1" === data.result && data.totalNum > 0) {
            $("#weekInfo").append("<option value=''>--请选择--</option>");
            $.each(data.datas, function(idx, week) {
                $("#weekInfo").append("<option value='" + week + "'>星期" + getWeekInfoInCN(week) + "</option>");
            });
        } else {
            $("#weekInfo").append("<option value=''>--无星期信息--</option>");
        }
    }


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