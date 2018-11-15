<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="form-edit" action="/studySchool/update">
		    <input type="hidden" name="id" value="${objBean.id }" />
		    <div class="form-group m-b-10">
			    <label for="input01" class="col-sm-2 control-label">名称</label>
			    <div class="col-sm-9 p-l-0">
			      <input type="text" class="form-control require" name="name" data-label-name="名称" id="input01" value="${objBean.name}" />
			    </div>
			</div>

			<div class="form-group m-b-10">
			    <label for="input10" class="col-sm-2 control-label">地址</label>
			    <div class="col-sm-9 p-l-0">
			       <textarea class="form-control require" name="address" rows="8" id="input10" cols="60">${objBean.address}</textarea>
			    </div>
			</div>

			<div class="text-center">
			      <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studySchool/list">
			      <i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
			</div>
	</form>
</div><!-- wrap-content-dialog -->