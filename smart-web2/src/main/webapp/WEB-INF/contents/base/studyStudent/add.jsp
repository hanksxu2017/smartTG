<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<div class="wrap-content-dialog">
    <form class="form-horizontal" role="form" id="form-add" action="studyStudent/save">
        <div class="form-group m-b-10">
            <label for="input01" class="col-sm-2 control-label">姓名</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control require" name="name" data-label-name="名称" id="input01"/>
            </div>
        </div>
        <div class="form-group m-b-10">
            <label for="sexSelect" class="col-sm-2 control-label">性别</label>
            <div class="col-sm-9 p-l-0">
                <select class="form-control require" name="sex" id="sexSelect">
                    <option value="1">男生</option>
                    <option value="2">女生</option>
                </select>
            </div>
        </div>
        <div class="form-group m-b-10">
            <label for="birthday" class="col-sm-2 control-label">出生日期</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control cnoj-date require" data-date-format="yyyy-mm-dd" name="birthday"
                       data-label-name="出生日期" id="birthday"/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="schoolName" class="col-sm-2 control-label">就读学校</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control" name="schoolName" data-label-name="就读学校" id="schoolName"/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="tIdSelForAddStudent" class="col-sm-2 control-label">围棋等级</label>
            <div class="col-sm-9 p-l-0">
                <select class="form-control" name="level" id="tIdSelForAddStudent">
                    <option value="">--请选择--</option>
                    <c:forEach items="${levels}" var="level">
                        <option value="${level}" >${level}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

<%--        <div class="form-group m-b-10">
            <label for="parentName" class="col-sm-2 control-label">家长</label>
            <div class="col-sm-3 p-l-0">
                <select class="form-control" name="parentType" id="parentType">
                    <option value="">--请选择--</option>
                    <option value="1">父亲</option>
                    <option value="2">母亲</option>
                </select>
            </div>
            <div class="col-sm-5 p-l-0">
                <input type="text" class="form-control require" name="parentName" data-label-name="家长" id="parentName"/>
            </div>
        </div>--%>

        <div class="form-group m-b-10">
            <label for="parentPhone" class="col-sm-2 control-label">联系方式</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control require" name="parentPhone" data-label-name="联系方式"
                       id="parentPhone"/>
            </div>
        </div>

        <div class="form-group m-b-10">
            <label for="totalCourse" class="col-sm-2 control-label">初始课时</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control require" name="totalCourse" data-label-name="初始课时"
                       id="totalCourse" value="20"/>
            </div>
        </div>
        <div class="form-group m-b-10">
            <label for="renewAmount" class="col-sm-2 control-label">续费额度</label>
            <div class="col-sm-9 p-l-0">
                <input type="text" class="form-control require" name="renewAmount" data-label-name="初始课时"
                       id="renewAmount" value="1000"/>
            </div>
        </div>
	    <div class="form-group m-b-10">
		    <label for="isRegisterForAddStudent" class="col-sm-2 control-label">是否注册</label>
		    <div class="col-sm-9 p-l-0">
			    <select class="form-control require" name="isRegister" id="isRegisterForAddStudent">
				    <option value="NO">未注册</option>
				    <option value="YES">已注册</option>
			    </select>
		    </div>
	    </div>

	    <div class="form-group m-b-10">
		    <label for="input03" class="col-sm-2 control-label">备注</label>
		    <div class="col-sm-9 p-l-0">
			    <textarea class="form-control require" name="description" data-label-name="描述" rows="8" id="input03" cols="60" ></textarea>
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