<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/class-config.js"></script>--%>
<div class="wrap-content">
	<input type="hidden" name="courseRecordId" id="courseRecordIdForSearchStudentHasAbsent" value="${courseRecordId}">
	<div class="panel no-border">
		<div class="panel-search">
			<form class="form-inline cnoj-entry-submit" method="post" role="form">
				<div class="form-group p-r-10">
					<label for="nameForSearchStudentHasAbsent">姓名:</label>
					<input type="text" class="form-control input-form-control"
                           id="nameForSearchStudentHasAbsent" placeholder="姓名" value="${searchParam.name}"/>
				</div>
				<div class="form-group p-l-10">
					  <span class="btn btn-primary btn-sm cnoj-search-submit" id="subSearchStudentHasAbsent">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
				</div>
			</form>
		</div>
	   <!-- table -->
	   <cnoj:table
			   smartResp="${smartResp}"
			   headers="姓名, 等级, 缺课数"
			   isCheckbox="1"
			   isRowSelected="1"

			   customBtns="${customBtns}"
			   page="${pageParam }"
	   />
	</div>
</div><!-- wrap-content-dialog -->
<script>
    $(function () {
        $(".bootstrap-dialog-body").attr("id", "student-absent-course-list-dialog");

        // 给分页按钮增加参数
        var pageSelect = $("#student-absent-course-list-dialog").find('select').eq(0);
        $(pageSelect).data('uri', '/studyStudent/makeUpStudent?courseRecordId=${courseRecordId}');

        $("#chooseStudentToMakeUp").on("click", function () {
            var value = $(this).attr("selected-value");
            if(utils.isNotEmpty(value)) {
                var uri = "/studyStudent/subMakeUpStudent?courseRecordId=" + $("#courseRecordIdForSearchStudentHasAbsent").val() + "&studentIds=" + value;
                var refreshUri = $(this).data('uri');
                var target = '#has-student-list';
                // 提交补课信息
                $.post(uri,function(data){
                    var output = data;
                    utils.showMsg(output.msg+"！");
                    if(output.result != '1') {
                        return;
                    }
                    BootstrapDialogUtil.close();
                    if(utils.isNotEmpty(refreshUri)) {
                        if(utils.isNotEmpty(target)) {
                            loadUri(target, refreshUri, true);
                        } else {
                            loadActivePanel(refreshUri);
                        }
                    }

                });
            } else {
                BootstrapDialogUtil.warningAlert("请选择要补课的学生!");
            }
        });

        $("#subSearchStudentHasAbsent").on("click", function () {
            var uri = "${ctx}/studyStudent/makeUpStudent?courseRecordId=" + $("#courseRecordIdForSearchStudentHasAbsent").val() +
                "&name=" + $("#nameForSearchStudentHasAbsent").val();
            loadUri("#student-absent-course-list-dialog", uri);
        });
    });
</script>