<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="<%=basePath%>"/>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/utils.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-dialog-util.js"></script>--%>
<div class="wrap-content-dialog">

    <form class="form-horizontal" role="form" id="form-uploadStudent" method="post" action="studyStudent/subUploadStudent" enctype="multipart/form-data">

        <div class="form-group m-b-10">
            <label for="uploadFile" class="col-sm-2 control-label">文件导入</label>
            <div class="col-sm-9 p-l-0">
                <input type="file" class="form-control require" name="attachFile" data-label-name="文件导入"
                       id="uploadFile" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
            </div>
        </div>

        <div class="text-center">
            <button type="button" class="btn btn-primary" id="subUploadStudents">
                <i class="glyphicon glyphicon-ok-sign"></i> 确定
            </button>
        </div>
    </form>
</div>
<!-- wrap-content-dialog -->

<script type="text/javascript">

	$(function () {

        $("#subUploadStudents").on("click",function(){
            utils.waitLoading("正在上传学生信息...");
            $.ajax({
                url: "${ctx}/studyStudent/subUploadStudent",
                type: 'POST',
                cache: false,
                data: new FormData($('#form-uploadStudent')[0]),
                processData: false,
                contentType: false,
                dataType:"json",
                success : function(data) {
                    utils.showMsg(data.msg + "！");
                    utils.closeWaitLoading();
                    if(data.result === '1') {
                        loadActivePanel('studyStudent/list');
                        BootstrapDialogUtil.close();
                    }
                }
            });
        });
    });
</script>