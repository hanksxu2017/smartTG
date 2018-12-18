<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="wrap-content">
    <div class="panel no-border">
        <div class="panel-search">
              <form class="form-inline cnoj-entry-submit" id="search-form-user" method="post" role="form" action="studyTeacher/courseList" target="#teacher-course-tab">
                  <input type="hidden" name="id" value="${searchParam.id }" />

                  <div class="form-group p-r-10">
				    <label for="weekInfoForSearchCourse">星期:</label>
	                  <select name="weekInfo" class="form-control" id="weekInfoForSearchCourse">
		                  <option value="">--请选择--</option>
		                  <c:forEach items="${weekInfoList}" var="weekInfo">
			                  <option value="${weekInfo.busiValue}" <c:if test="${weekInfo.busiValue eq searchParam.weekInfo}">selected</c:if> >${weekInfo.busiName}</option>
		                  </c:forEach>
	                  </select>
				  </div>
				  <div class="form-group p-l-10">
					  <span class="btn btn-info btn-sm cnoj-search-submit">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
				  </div>
              </form>
          </div>

		<cnoj:table smartResp="${smartResp }"
					headers="名称,星期,时间,教室,学生数,建班日期"
					isCheckbox="1" isRowSelected="1"
					page="${pageParam }"
					currentUri="${currentUri }"
		 addBtn="${addBtn }" editBtn="${editBtn}" delBtn="${delBtn}" customBtns="${customBtns}"
		 />
	</div>
</div>