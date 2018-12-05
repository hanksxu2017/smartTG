<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<div class="wrap-content">
	<div class="panel panel-default no-border">
	    <div class="panel-search">
              <form class="form-inline cnoj-entry-submit" id="search-form" method="post" role="form" action="/studyRenewRecord/list">
                  <div class="form-group p-r-10">
				    <label for="search-input01">学生姓名:</label>
				    <input type="text" class="form-control input-form-control" id="search-input01" name="studentName" placeholder="学生姓名" value="${searchParam.studentName}"/>
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

		<cnoj:table smartResp="${smartResp}" headers="学生,金额(单位元),课时数,操作人,时间,备注"
		  isCheckbox="1" isRowSelected="1" currentUri="${currentUri}"
		  refreshBtn="${refreshBtn}"
		  page="${pageParam}"
		/>
   </div>
</div>