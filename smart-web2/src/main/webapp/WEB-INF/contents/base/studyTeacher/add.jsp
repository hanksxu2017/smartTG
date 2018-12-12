<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<div class="wrap-content-dialog">
	<form class="form-horizontal" role="form" id="form-add" action="studyTeacher/save">
		<div class="form-group m-b-10">
			<label for="input01" class="col-sm-2 control-label">姓名</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="name" data-label-name="名称" id="input01"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="input02" class="col-sm-2 control-label">手机</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="phone" data-label-name="手机" id="input02"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="input03" class="col-sm-2 control-label">身份证</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="idCard" data-label-name="身份证" id="input03"/>
			</div>
		</div>

		<div class="text-center">
			<button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyTeacher/list">
				<i class="glyphicon glyphicon-ok-sign"></i> 确定
			</button>
		</div>
	</form>
</div>
<!-- wrap-content-dialog -->