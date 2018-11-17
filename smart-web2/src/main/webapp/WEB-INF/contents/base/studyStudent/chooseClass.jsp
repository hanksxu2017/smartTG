<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<div class="wrap-content-dialog">
    <form class="form-horizontal" role="form" id="form-edit" action="studyStudent/submitChooseClass">
        <input type="hidden" name="className" id="className"/>
        <input type="hidden" name="studentId" id="studentId" value="${student.id}"/>
        <input type="hidden" name="teacherId" id="teacherId" />

        <div class="form-group m-b-10">
            <label for="studentName" class="col-sm-2 control-label">姓名</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly"
                       name="studentName" data-label-name="名称" id="studentName" value="${student.name}" readonly/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="classId" class="col-sm-2 control-label">班级</label>
            <div class="col-sm-9 p-l-0">
                <select name="classId" class="form-control require" id="classId">
                    <option value="">--请选择--</option>
                    <c:forEach items="${classes}" var="c">
                        <option value="${c.id}" >${c.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="classId" class="col-sm-2 control-label">授课教师</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" name="teacherName" data-label-name="授课教师"
                       id="teacherName" readonly/>
            </div>
        </div>


        <div class="text-center">
            <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyStudent/list">
                <i class="glyphicon glyphicon-ok-sign"></i> 确定
            </button>
        </div>
    </form>
</div>
<!-- wrap-content-dialog -->


<script>
    $(function () {

        $("#classId").change(function () {
            var text = $(this).find("option:selected").text();
            $("#className").val(text);
        });

        $("#classId").change(function () {
            var text = $(this).find("option:selected").text();
            $("#className").val(text);

            var url = "${ctx}/studyClass/queryClass?id=" + $(this).find("option:selected").val();
            // 查询授课教师
            $.ajax({
                type: "GET",
                url: url,
                success: function(data){
                    $("#teacherName").val(data.teacherName);
                    $("#teacherId").val(data.teacherId);
                }
            });

        });

    });
</script>