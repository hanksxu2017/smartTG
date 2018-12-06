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
            <label for="tIdSelForStuReportCourse" class="col-sm-2 control-label">授课教师</label>
            <div class="col-sm-9 p-l-0">
                <select class="form-control require" id="tIdSelForStuReportCourse">
                    <option value="">--请选择--</option>
                    <c:forEach items="${teachers}" var="teacher">
                        <option value="${teacher.id}" >${teacher.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="weekSelForStuReportCourse" class="col-sm-2 control-label">星期</label>
            <div class="col-sm-9 p-l-0">
                <select class="form-control require" id="weekSelForStuReportCourse">
                    <option value="">--请选择--</option>
                </select>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="courseSelForStuReportCourse" class="col-sm-2 control-label">班级</label>
            <div class="col-sm-9 p-l-0">
                <select name="courseId" class="form-control require" id="courseSelForStuReportCourse">
                    <option value="">--请选择--</option>
                    <!-- 动态加载 -->
                </select>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="classroomForStuReportCourse" class="col-sm-2 control-label">教室</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" data-label-name="教室"
                       id="classroomForStuReportCourse" readonly/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="courseTimeForStuReportCourse" class="col-sm-2 control-label">上课时间</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" data-label-name="上课时间"
                       id="courseTimeForStuReportCourse" readonly/>
            </div>
        </div>

	    <div class="form-group m-b-10">
		    <label for="signTypeForStuReportCourse" class="col-sm-2 control-label">点名类型</label>
		    <div class="col-sm-9 p-l-0">
			    <select name="signType" class="form-control require" id="signTypeForStuReportCourse">
				    <option value="NORMAL">正常签到</option>
				    <option value="SIGN_AS_HAS">到班签到(带*号类)</option>
			    </select>
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

        $("#tIdSelForStuReportCourse").change(function () {
            $("#weekSelForStuReportCourse").val('');
            $("#courseSelForStuReportCourse").val('');
            $("#courseTimeForStuReportCourse").val('');
            $("#classroomForStuReportCourse").val('');

            var url = "${ctx}/studyCourse/queryWeeks?teacherId=" + $("#tIdSelForStuReportCourse").val();
            $.ajax({
                type: "GET",
                url: url,
                success: function(data){
                    initWeekInfoSelect(data);
                }
            });

        });

        $("#weekSelForStuReportCourse").change(function () {
            var weekInfo = $("#weekSelForStuReportCourse").val();
            if(null == weekInfo || '' === weekInfo) {
                $("#courseSelForStuReportCourse").val('');
            } else {
                var teacherId = $("#tIdSelForStuReportCourse").val();
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

        $("#courseSelForStuReportCourse").change(function () {
            var courseId = $("#courseSelForStuReportCourse").val();
            if(null == courseId || '' == courseId) {
                $("#courseTimeForStuReportCourse").val('');
                $("#classroomForStuReportCourse").val('');
            } else {
                var url = "${ctx}/studyCourse/queryCourse?courseId=" + courseId;
                $.ajax({
                    type: "GET",
                    url: url,
                    success: function(data){
                        if(null != data && "1" === data.result && data.totalNum > 0) {
                            $.each(data.datas, function(idx, course) {
                                $("#courseTimeForStuReportCourse").val(course.courseTime);
                                $("#classroomForStuReportCourse").val(course.classroomName);
                            });
                        }
                    }
                });
            }
        });
    });

    function initCourseSelect(data) {
        $("#courseSelForStuReportCourse").empty();
        if(null != data && "1" === data.result && data.totalNum > 0) {
            $("#courseSelForStuReportCourse").append("<option value=''>--请选择--</option>");
            $.each(data.datas, function(idx, course) {
                $("#courseSelForStuReportCourse").append("<option value='" + course.id + "'>" + course.name + "</option>");
            });
        } else {
            $("#courseSelForStuReportCourse").append("<option value=''>--无班级信息--</option>");
        }
    }

    function initWeekInfoSelect(data) {
        $("#weekSelForStuReportCourse").empty();
        if(null != data && "1" === data.result && data.totalNum > 0) {
            $("#weekSelForStuReportCourse").append("<option value=''>--请选择--</option>");
            $.each(data.datas, function(idx, week) {
                $("#weekSelForStuReportCourse").append("<option value='" + week + "'>星期" + getWeekInfoInCN(week) + "</option>");
            });
        } else {
            $("#weekSelForStuReportCourse").append("<option value=''>--无星期信息--</option>");
        }
    }


    function getWeekInfoInCN(week) {
        var weeks = [];
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