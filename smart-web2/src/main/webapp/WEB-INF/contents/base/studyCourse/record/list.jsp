<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<div class="wrap-content">
	<div class="panel panel-default no-border">
<%--	    <div class="panel-search">
              <form class="form-inline cnoj-entry-submit" id="search-form" method="post" role="form" action="version/list">
                  <div class="form-group p-r-10">
				    <label for="search-input01">版本号：</label>
				    <input type="text" class="form-control input-form-control" id="search-input01" name="version" placeholder="版本号" value="${searchParam.version }"/>
				  </div>
				  <div class="form-group p-l-10">
					  <span class="btn btn-primary btn-sm cnoj-search-submit">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
				  </div>
              </form>
          </div>--%>
		<!-- table -->

    <!-- table -->
    <cnoj:table
        smartResp="${smartResp }"
        headers="日期,授课时间,班级,教室,授课教师,学生-应到,学生-实到,学生-事假,学生-缺席,状态,创建时间,备注"
        headerWidths="5%,5%,10%,10%,5%,5%,5%,5%,5%,10%,15%,20%"
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