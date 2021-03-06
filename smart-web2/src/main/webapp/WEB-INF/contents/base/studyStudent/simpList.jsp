<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<div class="wrap-content">
	<div class="panel no-border">
        <div class="panel-search borer-bottom">
              <form class="form-inline cnoj-entry-submit" id="search-form-user" method="post" role="form" action="studyStudent/simpList" target="#student-tab">
                  <div class="form-group p-r-10">
				    <label for="search-input02">关键字：</label>
				    <input type="text" class="form-control input-form-sm-control" id="search-input02" name="name" placeholder="请输入姓名" value="${searchParam.name }"/>
				  </div>
				  <div class="form-group p-l-10">
					  <span class="btn btn-info btn-sm cnoj-search-submit">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
				  </div>
              </form>
          </div>

		<cnoj:tableItem smartResp="${smartResp}" headers="姓名,等级,剩余课时,入学时间" isRowSelected="1" currentUri="${currentUri }"
		  selectedEventProp="${selectedEventProp }" page="${pageParam }"
		 />
	</div>
</div>