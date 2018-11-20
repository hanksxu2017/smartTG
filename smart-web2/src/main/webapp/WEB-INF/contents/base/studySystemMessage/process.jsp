<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content">
	<div class="panel panel-default no-border">
		<form class="form-horizontal" role="form" id="form-edit" action="studySystemMessage/subProcess">
			<input type="hidden" name="id" value="${systemMessage.id}">


			<div class="form-group m-b-10">
				<label for="input01" class="col-sm-2 control-label">消息类型</label>
				<div class="col-sm-9 p-l-0">
					<input type="text" class="form-control require" data-label-name="消息类型" id="input01" value="${systemMessage.messageType}"/>
				</div>
			</div>

			<div class="form-group m-b-10">
				<label for="input02" class="col-sm-2 control-label">详细内容</label>
				<div class="col-sm-9 p-l-0">
					<input type="text" class="form-control require" data-label-name="详细内容" id="input02" value="${systemMessage.messageContent}"/>
				</div>
			</div>

			<div class="form-group m-b-10">
				<label for="input03" class="col-sm-2 control-label">紧急等级</label>
				<div class="col-sm-9 p-l-0">
					<textarea class="form-control require" data-label-name="描述" rows="8" id="input03" cols="60">${systemMessage.level}</textarea>
				</div>
			</div>

			<div class="form-group m-b-10">
				<label for="sexSelect" class="col-sm-2 control-label">性别</label>
				<div class="col-sm-9 p-l-0">
					<select class="form-control require" name="sex" id="sexSelect">
						<option value="0">未处理</option>
						<option value="1">已处理</option>
					</select>
				</div>
			</div>

			<div class="text-center">
				<button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studySystemMessage/list">
					<i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
			</div>
		</form>
	</div>
</div>
