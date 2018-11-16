<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="form-add" action="studyClass/save">
       <input type="hidden" name="teacherName" id="teacherName">
	   <div class="form-group m-b-10">
		   <label for="input02" class="col-sm-2 control-label">名称</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control require" name="name" data-label-name="名称" id="input02" />
		   </div>
	   </div>

		    <div class="form-group m-b-10">
			    <label for="teacherSelect" class="col-sm-2 control-label">授课教师</label>
			    <div class="col-sm-9 p-l-0">
                    <select name="teacherId" class="form-control" id="teacherSelect">
                        <option value="">--请选择教师--</option>
                        <c:forEach items="${teachers}" var="teacher">
                            <option value="${teacher.id}">${teacher.name}</option>
                        </c:forEach>
                    </select>
			    </div>
			</div>

       <div class="form-group m-b-10">
           <label for="input03" class="col-sm-2 control-label">等级</label>
           <div class="col-sm-9 p-l-0">
                <select name="level" class="form-control" id="input03">
                    <option value="primary">入门</option>
                    <option value="medium">中级</option>
                    <option value="senior">高级</option>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="input04" class="col-sm-2 control-label">描述</label>
           <div class="col-sm-9 p-l-0">
               <textarea class="form-control" name="description" data-label-name="描述" rows="8" id="input04" cols="60" />
           </div>
       </div>

			<div class="text-center">
			      <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyClass/list">
			      <i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
			</div>
	</form>
</div><!-- wrap-content-dialog -->

<script>
    $(function () {
        $("#teacherSelect").change(function () {
            var text = $(this).find("option:selected").text();
            $("#teacherName").val(text);
        });

    });
</script>