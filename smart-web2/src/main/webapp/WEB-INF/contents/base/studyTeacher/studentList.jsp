<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="wrap-content">
    <div class="panel no-border">
<%--        <div class="panel-search">
            <form class="form-inline cnoj-entry-submit" id="search-form-user" method="post" role="form"
                  action="studyTeacher/studentList" target="#course-student-list-dialog">
                <input type="hidden" name="id" value="${searchParam.id}"/>

                <div class="form-group p-r-10">
                    <label for="search-input01">学生姓名：</label>
                    <input type="text" class="form-control input-form-sm-control" id="search-input01" name="studentName"
                           placeholder="请输入学生姓名" value="${searchParam.studentName}"/>
                </div>
	            <div class="form-group p-r-10">
		            <label for="status">状态：</label>
		            <select name="status" class="form-control" id="status">
			            <option value="NORMAL" <c:if test="${searchParam.status eq 'NORMAL'}">selected</c:if> >在班</option>
			            <option value="EXIT_COURSE" <c:if test="${searchParam.status eq 'EXIT_COURSE'}">selected</c:if> >已退班</option>
			            <option value="DROP_OUT" <c:if test="${searchParam.status eq 'DROP_OUT'}">selected</c:if> >已退班</option>
			            <option value="ALL" <c:if test="${searchParam.status eq 'ALL'}">selected</c:if> >全部</option>
		            </select>
	            </div>
                <div class="form-group p-l-10">
					  <span class="btn btn-info btn-sm cnoj-search-submit">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
                </div>
            </form>
        </div>--%>

        <cnoj:table smartResp="${smartResp}" headers="姓名,等级,剩余课时,入学时间,操作"
                    isCheckbox="1"
                    isRowSelected="1"
                    page="${pageParam }"
                    currentUri="${currentUri}"
                    customBtns="${customBtns}"
                    refreshBtn="${refreshBtn}"
                    delBtn="${delBtn}"
                    customCells="${customCells }"
        />
    </div>
</div>

<script>
    $(function () {
		$(".bootstrap-dialog-body").attr("id", "course-student-list-dialog");
    });

</script>