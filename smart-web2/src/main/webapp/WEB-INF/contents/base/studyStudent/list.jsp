<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="wrap-content">
	<div class="panel panel-default no-border">
	    <div class="panel-search">
              <form class="form-inline cnoj-entry-submit" id="search-form" method="post" role="form" action="studyStudent/list">
                  <div class="form-group p-r-10">
				    <label for="search-input01">姓名:</label>
				    <input type="text" class="form-control input-form-control" id="search-input01" name="name" placeholder="姓名" value="${searchParam.name }"/>
				  </div>
	              <div class="form-group p-r-10">
		              <label for="status">状态：</label>
		              <select name="status" class="form-control" id="status">
			              <option value="NORMAL" <c:if test="${searchParam.status eq 'NORMAL'}">selected</c:if> >正常</option>
			              <option value="TEMP_LEAVE" <c:if test="${searchParam.status eq 'TEMP_LEAVE'}">selected</c:if> >休学</option>
			              <option value="DELETE" <c:if test="${searchParam.status eq 'DELETE'}">selected</c:if> >退学</option>
			              <option value="ALL" <c:if test="${searchParam.status eq 'ALL'}">selected</c:if> >全部</option>
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
        headers="姓名,性别,出生日期,就读学校,联系方式,等级,状态,剩余课时,入学时间"
        headerWidths="10%,5%,15%,15%,10%,10%,5%,10%,20%"
        isCheckbox="1"
        isRowSelected="1"
        currentUri="${currentUri}"
        addBtn="${addBtn}"
        editBtn="${editBtn}"
        delBtn="${delBtn}"
        refreshBtn="${refreshBtn}"
        customBtns="${customBtns}"
        page="${pageParam }"
    />
   </div>
</div>