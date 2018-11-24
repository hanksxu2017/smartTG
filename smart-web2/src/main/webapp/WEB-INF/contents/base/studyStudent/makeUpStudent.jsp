<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content-dialog">


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

</div><!-- wrap-content-dialog -->
