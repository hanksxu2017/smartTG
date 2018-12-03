<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/utils.js"></script>
<div class="wrap-content">
	<div class="panel no-border" id="studentListOfCourseRecord">
		<div class="panel-search">
			<form class="form-inline cnoj-entry-submit" id="search-form-user" method="post" role="form"
			      action="studyStudent/studentList" target="#courseRecord-student-tab">
				<input type="hidden" id="courseRecordIdForSingleSign"
                       name="courseRecordId" value="${searchParam.courseRecordId}"/>

				<div class="form-group p-r-10">
					<label for="search-input02">学生姓名：</label>
					<input type="text" class="form-control input-form-sm-control" id="search-input02" name="studentName"
					       placeholder="请输入学生姓名" value="${searchParam.studentName}"/>
				</div>
				<div class="form-group p-l-10">
					  <span class="btn btn-info btn-sm cnoj-search-submit">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
				</div>
			</form>
		</div>

		<cnoj:table smartResp="${smartResp}" headers="姓名,等级,剩余课时,状态, 操作"
		            isCheckbox="1"
		            isRowSelected="1"
		            page="${pageParam }"
		            currentUri="${currentUri}"
		            customBtns="${customBtns}"
		            refreshBtn="${refreshBtn}"
		            delBtn="${delBtn}"
		            customCells="${customCells }"
		/>
	</div>
</div>

<script>
    $(function () {
        var table = $('#studentListOfCourseRecord').find('table');
        if (null != table) {
            var trList = table.find('tr');
            for (var i = 1; i < trList.length; i++) {
                updateTrSignInfo(trList.eq(i));

/*                var tdArr = trList.eq(i).find('td');
                studentId = tdArr.eq(0).find('input').val();//收入类别
	            status = tdArr.eq(4).html().trim();
                curBtn = tdArr.eq(5).find('.opr-btn');
                curOpr = tdArr.eq(5).find('.opr-span');

                if(status === '缺课') {
                    curBtn.addClass('btn-danger');
                    curOpr.text('缺课');
	            } else if(status === '请假') {
                    $(curBtn).addClass('btn-warning');
                    $(curOpr).text('请假');
	            } else if(status === '已签到') {
                    $(curBtn).addClass('btn-success');
                    $(curOpr).text('已签到');
	            }*/

            }
        }

        $(".student-single-sign").on("click", function () {

            var studentId = $(this).data('id');
            var signType = $(this).data('type');
            var courseRecordId = $("#courseRecordIdForSingleSign").val();

            var curTr = $(this).parents('tr');

            $.ajax({
                type: "POST",
                dataType: 'json',
                async:false,
                data:{studentId:studentId, signType:signType, courseRecordId:courseRecordId},
                url: "${ctx}/studyStudent/subStudentSingleSign",
                success: function(data){
                    if(data.result === '1') {
                        afterSingleSign(curTr, signType, data.data.remainCourse);
                    } else {
                        utils.showMsg(data.msg);
                    }
                }
            });

        });
    });
    
    function afterSingleSign(tr, signType, remainCourse) {
        var status = '';
        if('signed' === signType) {
            status = '已签到';
        } else if('personal_leave' === signType) {
            status = '请假';
        } else if('play_truant' === signType) {
            status = '缺课';
        }
        if(null != status && '' != status) {
            tr.find('td').eq(3).html(remainCourse);
            tr.find('td').eq(4).html(status);
            updateTrSignInfo(tr, status);
        }
    }

    function updateTrSignInfo(tr, status) {
        var tdArr = tr.find('td');
        if(null == status || '' === status) {
            status = tdArr.eq(4).html();
        }
        var curBtn = tdArr.eq(5).find('.opr-btn');
        var curOpr = tdArr.eq(5).find('.opr-span');

        if(status === '缺课') {
            curBtn.removeClass('btn-warning btn-success');
            curBtn.addClass('btn-danger');
            curOpr.text('缺课');
        } else if(status === '请假') {
            curBtn.removeClass('btn-danger btn-success');
            curBtn.addClass('btn-warning');
            curOpr.text('请假');
        } else if(status === '已签到') {
            curBtn.removeClass('btn-danger btn-warning');
            curBtn.addClass('btn-success');
            curOpr.text('已签到');
        }
    }


</script>
