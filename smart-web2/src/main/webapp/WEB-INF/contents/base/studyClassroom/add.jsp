<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="form-add" action="studyClassroom/save">
       <input type="hidden" name="schoolName" id="schoolName">
		    <div class="form-group m-b-10">
			    <label for="idSelForSchoolAdd" class="col-sm-2 control-label">校区</label>
			    <div class="col-sm-9 p-l-0">
                    <select name="schoolId" class="form-control require" id="idSelForSchoolAdd">
						<option value="">--请选择--</option>
                        <c:forEach items="${schools}" var="school">
                            <option value="${school.id}">${school.name}</option>
                        </c:forEach>
                    </select>
			    </div>
			</div>

	   <div class="form-group m-b-10">
		   <label for="input02" class="col-sm-2 control-label">名称</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control require" name="name" data-label-name="名称" id="input02" />
		   </div>
	   </div>

       <div class="form-group m-b-10">
           <label for="input03" class="col-sm-2 control-label">描述</label>
           <div class="col-sm-9 p-l-0">
               <textarea class="form-control require" name="description" data-label-name="描述" rows="8" id="input03" cols="60" ></textarea>
           </div>
       </div>

			<div class="text-center">
			      <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyClassroom/list">
			      <i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
			</div>
	</form>
</div><!-- wrap-content-dialog -->

<script>
    $(function () {
        $("#idSelForSchoolAdd").change(function () {
            var text = $(this).find("option:selected").text()
            $("#schoolName").val(text);
        });

    });
</script>