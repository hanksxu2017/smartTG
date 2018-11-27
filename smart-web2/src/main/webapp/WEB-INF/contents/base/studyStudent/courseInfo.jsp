<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<div class="wrap-content-dialog">
	<cnoj:table smartResp="${smartResp }" headers="名称,星期,时间,教室,教师,状态" isCheckbox="1" isRowSelected="1"
	            page="${pageParam }" currentUri="${currentUri }" refreshBtn="${refreshBtn}"
	/>


</div>
<!-- wrap-content-dialog -->
<script>
    $(function () {
        $(".bootstrap-dialog-body").attr("id", "student-course-list-dialog");


    });

</script>
