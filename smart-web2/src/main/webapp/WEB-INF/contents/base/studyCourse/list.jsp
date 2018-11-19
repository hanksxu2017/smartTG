<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="wrap-content">
	<div class="panel panel-default no-border">
		<div class="panel-search">
			<form class="form-inline cnoj-entry-submit" id="search-form" method="post" role="form" action="studyCourse/list">

				<div class="form-group p-r-10">
					<label for="teacherId">教师：</label>
					<select name="teacherId" class="form-control" id="teacherId">
						<option value="">--请选择--</option>
						<c:forEach items="${teachers}" var="teacher">
							<option value="${teacher.id}" <c:if test="${searchParam.teacherId eq teacher.id}">selected</c:if> >${teacher.name}</option>
						</c:forEach>
					</select>
				</div>

				<div class="form-group p-r-10">
					<label for="teacherId">星期</label>
						<select name="weekInfo" class="form-control" id="weekInfo">
							<option value="">--请选择--</option>
							<option value="1" <c:if test="${searchParam.weekInfo eq '1'}">selected</c:if> >星期一</option>
							<option value="2" <c:if test="${searchParam.weekInfo eq '2'}">selected</c:if> >星期二</option>
							<option value="3" <c:if test="${searchParam.weekInfo eq '3'}">selected</c:if> >星期三</option>
							<option value="4" <c:if test="${searchParam.weekInfo eq '4'}">selected</c:if> >星期四</option>
							<option value="5" <c:if test="${searchParam.weekInfo eq '5'}">selected</c:if> >星期五</option>
							<option value="6" <c:if test="${searchParam.weekInfo eq '6'}">selected</c:if> >星期六</option>
							<option value="7" <c:if test="${searchParam.weekInfo eq '7'}">selected</c:if> >星期天</option>
						</select>
				</div>

				<div class="form-group p-l-10">
					<span class="btn btn-primary btn-sm cnoj-search-submit">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
				 </div>
              </form>
          </div>
		<!-- table -->

    <!-- table -->
    <cnoj:table
        smartResp="${smartResp }"
        headers="星期,时间,名称,教室,教师"
        isCheckbox="1"
        isRowSelected="1"
        currentUri="${currentUri}"
        refreshBtn="${refreshBtn}"
        customBtns="${customBtns}"
        page="${pageParam }"
    />
   </div>
</div>