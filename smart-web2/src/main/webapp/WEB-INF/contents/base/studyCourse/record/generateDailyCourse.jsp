<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content-dialog">
	<form class="form-horizontal" role="form" id="form-add" action="/studyCourse/record/generate">
		<div class="form-group m-b-10">
			<label for="startDate" class="col-sm-2 control-label">开始时间</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="startDate" data-label-name="名称" id="startDate"
			        value = "${startDate}"/>
			</div>
		</div>
		<div class="form-group m-b-10">
			<label for="endDate" class="col-sm-2 control-label">结束时间</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="endDate" data-label-name="名称" id="endDate"
				       value = "${endDate}"/>
			</div>
		</div>

		<div class="text-center">
			<button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyCourse/list">
			<i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
		</div>
	</form>
</div><!-- wrap-content-dialog -->