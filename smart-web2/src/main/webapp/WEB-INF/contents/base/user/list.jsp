<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<div class="wrap-content">
	<div class="panel panel-default no-border">
	    <div class="panel-search">
              <form class="form-inline cnoj-entry-submit" id="search-form" method="post" role="form" action="user/list" target="#main-content">
                  <div class="form-group p-r-10">
				    <label for="search-input01">名称：</label>
				    <input type="text" class="form-control input-form-control" id="search-input01" name="name" placeholder="请输入用户名或姓名" value="${searchParam.name }"/>
				  </div>
				  <div class="form-group p-r-10">
				    <label for="search-input02">联系信息：</label>
				    <input type="text" class="form-control input-form-control" id="search-input02" name="info" placeholder="请输入手机号码或邮箱地址" value="${searchParam.info }"/>
				  </div>
				  <div class="form-group p-r-10">
				    <label for="search-select01">状态：</label>
				    <select class="form-control cnoj-select select-form-control" data-uri="dict/item/DATA_STATE.json" name="state" data-default-value="${searchParam.state }"  id="search-select01">
				       <option value="">请选择</option>
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
		<cnoj:table smartResp="${smartResp }" headers="用户名,姓名,状态,创建时间"
		  isCheckbox="1" isRowSelected="1" currentUri="${currentUri }"
		  addBtn="${addBtn }" editBtn="${editBtn }" delBtn="${delBtn }" refreshBtn="${refreshBtn }" 
		  customBtns="${customBtns}" page="${pageParam }" 
		/>
   </div>
</div>