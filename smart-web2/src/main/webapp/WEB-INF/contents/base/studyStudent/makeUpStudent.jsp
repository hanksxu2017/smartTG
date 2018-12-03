<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content">
	<div class="panel no-border">

	   <!-- table -->
	   <cnoj:table
			   smartResp="${smartResp }"
			   headers="姓名, 等级, 缺课数"
			   isCheckbox="1"
			   isRowSelected="1"

			   refreshBtn="${refreshBtn}"
			   customBtns="${customBtns}"
			   page="${pageParam }"
	   />
	</div>
</div><!-- wrap-content-dialog -->
<script>
    $(function () {
        $(".bootstrap-dialog-body").attr("id", "student-absent-course-list-dialog");
    });

</script>