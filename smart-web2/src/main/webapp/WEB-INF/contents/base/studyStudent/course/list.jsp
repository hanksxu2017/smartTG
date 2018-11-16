<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="wrap-content">
	<div class="panel panel-default no-border">
	    <div class="panel-search">
              <form class="form-inline cnoj-entry-submit" id="search-form" method="post" role="form" action="studyStudent/course/list">

                  <div class="form-group p-r-10">
				    <label for="studentName">学生:</label>
				    <input type="text" class="form-control input-form-control" id="studentName" name="studentName" placeholder="学生" value="${searchParam.studentName}"/>
				  </div>

				  <div class="form-group p-r-10">
					  <label for="studentName">班级:</label>
                      <select name="classId" class="form-control" id="classId">
                          <option value="">----</option>
                          <c:forEach items="${classes}" var="c">
                              <option value="${c.id}" <c:if test="${c.id eq searchParam.classId}">selected</c:if> >${c.name}</option>
                          </c:forEach>
                      </select>
				  </div>

				  <div class="form-group p-r-10">
					  <label for="studentName">教师：</label>
                      <select name="teacherId" class="form-control" id="teacherSelect">
                          <option value="">----</option>
                          <c:forEach items="${teachers}" var="teacher">
                              <option value="${teacher.id}" <c:if test="${teacher.id eq searchParam.teacherId}">selected</c:if> >${teacher.name}</option>
                          </c:forEach>
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
        headers="星期,时间,学生姓名,班级,教室,授课教师,状态,授课时间"
        headerWidths="20%,20%,10%,10%,10%,10%,5%,15%"
        isCheckbox="1"
        isRowSelected="1"
        currentUri="${currentUri}"
        addBtn="${addBtn}"
        editBtn="${editBtn}"
        delBtn="${delBtn}"
        refreshBtn="${refreshBtn}"
        page="${pageParam }"
    />
   </div>
</div>