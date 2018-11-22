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
                    <option value="1" <c:if test="${objBean.sex == 1}">selected</c:if> >男生</option>
                    <option value="2" <c:if test="${objBean.sex == 2}">selected</c:if> >女生</option>
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
            <label for="level" class="col-sm-2 control-label">围棋等级</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control" name="level" data-label-name="围棋等级"
                       id="level" value="${objBean.level}"/>
            </div>
        </div>

<%--        <div class="form-group m-b-10">
            <label for="parentName" class="col-sm-2 control-label">家长</label>
            <div class="col-sm-3 p-l-0">
                <select class="form-control" name="parentType" id="parentType">
                    <option value="">--请选择--</option>
                    <option value="1"  <c:if test="${objBean.parentType == 1}">selected</c:if> >父亲</option>
                    <option value="2" <c:if test="${objBean.parentType == 2}">selected</c:if> >母亲</option>
                </select>
            </div>
            <div class="col-sm-5 p-l-0">
                <input type="text" class="form-control require" name="parentName" data-label-name="家长"
                       id="parentName" value="${objBean.parentName}"/>
            </div>
        </div>--%>

        <div class="form-group m-b-10">
            <label for="parentPhone" class="col-sm-2 control-label">联系方式</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control require" name="parentPhone" data-label-name="联系方式"
                       id="parentPhone" value="${objBean.parentPhone}"/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="totalCourse" class="col-sm-2 control-label">初始课时</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control input-readonly" name="totalCourse" data-label-name="初始课时"
                       id="totalCourse" value="${objBean.totalCourse}" readonly/>
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