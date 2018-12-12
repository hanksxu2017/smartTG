<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<div class="wrap-content-dialog">
	<form class="form-horizontal" role="form" id="form-edit" action="studyStudent/update">
		<input type="hidden" name="id" value="${objBean.id }"/>
		<div class="form-group m-b-10">
			<label for="name" class="col-sm-2 control-label">姓名</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require"
				       name="name" data-label-name="名称" id="name" value="${objBean.name}"/>
			</div>
		</div>
		<div class="form-group m-b-10">
			<label for="sexSelect" class="col-sm-2 control-label">性别</label>
			<div class="col-sm-9 p-l-0">
				<select class="form-control require" name="sex" id="sexSelect">
					<option value="1"
					        <c:if test="${objBean.sex == 1}">selected</c:if> >男生
					</option>
					<option value="2"
					        <c:if test="${objBean.sex == 2}">selected</c:if> >女生
					</option>
				</select>
			</div>
		</div>
		<div class="form-group m-b-10">
			<label for="birthday" class="col-sm-2 control-label">出生日期</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control cnoj-date require" data-date-format="yyyy-mm-dd" name="birthday"
				       data-label-name="出生日期" id="birthday" value="${objBean.birthday}"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="schoolName" class="col-sm-2 control-label">就读学校</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control" name="schoolName" data-label-name="就读学校"
				       id="schoolName" value="${objBean.schoolName}"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="tIdSelForEditStudent" class="col-sm-2 control-label">围棋等级</label>
			<div class="col-sm-9 p-l-0">
				<select class="form-control" name="level" id="tIdSelForEditStudent">
					<option value="">--请选择--</option>
					<c:forEach items="${levels}" var="level">
						<option value="${level}"  <c:if test="${objBean.level eq level}">selected</c:if> >${level}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="parentPhone" class="col-sm-2 control-label">联系方式</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="parentPhone" data-label-name="联系方式"
				       id="parentPhone" value="${objBean.parentPhone}"/>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="renewAmount" class="col-sm-2 control-label">续费额度</label>
			<div class="col-sm-9 p-l-0">
				<input type="text" class="form-control require" name="renewAmount" data-label-name="初始课时"
				       id="renewAmount" value="${objBean.renewAmount}"/>
			</div>
		</div>
		<div class="form-group m-b-10">
			<label for="isRegisterForAddStudent" class="col-sm-2 control-label">是否注册</label>
			<div class="col-sm-9 p-l-0">
				<select class="form-control require" name="isRegister" id="isRegisterForAddStudent">
					<option value="NO" <c:if test="${objBean.isRegister eq 'NO'}">selected</c:if> >未注册</option>
					<option value="YES" <c:if test="${objBean.isRegister eq 'YES'}">selected</c:if> >已注册</option>
				</select>
			</div>
		</div>

		<div class="form-group m-b-10">
			<label for="input03" class="col-sm-2 control-label">备注</label>
			<div class="col-sm-9 p-l-0">
				<textarea class="form-control" name="description" data-label-name="描述" rows="8" id="input03" cols="60">${objBean.description}</textarea>
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