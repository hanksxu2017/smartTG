<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="ctx" value="${basePath}"/>
<div class="panel">
	<div class="panel-search">
		<form class="form-inline cnoj-entry-submit" method="post" role="form">

			<div class="form-group p-r-10">
				<label for="nameForStatistics">姓名:</label>
				<input type="text" class="form-control input-form-control"
				       id="nameForStatistics" placeholder="姓名" value="${searchParam.name}"/>
			</div>

			<div class="form-group p-r-10">
				<label for="monthForSearchStatistics" class="control-label">月份</label>
				<select class="form-control" id="monthForSearchStatistics" name="month">
					<c:forEach items="${monthList}" var="item">
						<option value="${item.month}"
						        <c:if test="${searchParam.month eq item.month}">selected</c:if>  >${item.monthDesc}</option>
					</c:forEach>
				</select>
			</div>

			<div class="form-group p-l-10">
					  <span class="btn btn-primary btn-sm cnoj-search-submit" id="subSearchStudentHasAbsent">
						<i class="glyphicon glyphicon-search"></i>
						<span>搜索</span>
					  </span>
			</div>
		</form>
	</div>
	<div class="panel-body panel-body-noheader panel-body-noborder">
		<div class="loading-content" style="visibility: visible;">

			<div class="wrap-content">
				<div class="panel panel-info no-border">

					<div class="table-body-scroll table-wrap-limit">
						<table id="studentStatisticsTable" class="table table-striped table-bordered table-condensed"
						       style="width: 80%;">
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>


</div>

<div class="panel-footer panel-footer-page" data-height="34">
	<div class="btn-list">
		<div class="btn-group cnoj-op-btn-list">
			<button type="button" id="refreshCourseTable" class="btn btn-default" disabled="disabled">
				<i class="glyphicon glyphicon-refresh"></i>刷新
			</button>
		</div>
	</div>
	<div class="btn-page">
		<div class="page">
			<ul class="pagination">
				<li class="disabled"><a href="javascript:void(0)" class="pre-page">«</a></li>
				<li class="active"><a class="cnoj-change-page cnoj-change-page-listener"
				                      data-uri="/studyStudent/list?page=1" href="#" data-target="">1</a></li>
				<li class=""><a class="cnoj-change-page cnoj-change-page-listener" data-uri="/studyStudent/list?page=2"
				                href="#" data-target="">2</a></li>
				<li class=""><a class="cnoj-change-page cnoj-change-page-listener" data-uri="/studyStudent/list?page=3"
				                href="#" data-target="">3</a></li>
				<li class=""><a href="#" data-uri="/studyStudent/list?page=2"
				                class="cnoj-change-page next-page cnoj-change-page-listener" data-target="">»</a></li>
				<li>&nbsp;到<input class="form-control btn-sm goto-page-input" name="page" value="">页
					<button data-uri="/studyStudent/list?page="
					        class="btn btn-default btn-sm cnoj-goto-page cnoj-goto-page-listener" data-target="">确定
					</button>
				</li>
			</ul>
		</div>
	</div>

	<div class="page-info"><span>1 - 14</span><span>&nbsp;&nbsp; 共266条(每页显示<select
			class="form-control input-sm cnoj-change-pagesize cnoj-change-pagesize-listener"
			data-uri="/studyStudent/list" data-target=""><option selected="selected" value="20">20</option><option
			value="30">30</option><option value="40">40</option><option value="50">50</option></select></span>条)
	</div>

</div>

<script type="text/javascript">

    $(function () {
        var url = "${ctx}/studyStatistics/student/generateStatisticsTable";
        $.ajax({
            type: "GET",
            url: url,
            success: function (data) {
                if (data.result === '1') {
                    initStatisticsStudentTable(data.data);
                }
            }
        });

        $("#refreshCourseTable").click(function () {
            reloadTab($(this).data("uri"));
        });
    });

    /**
     * 初始化表格
     * @param data
     */
    function initStatisticsStudentTable(data) {
        var table = $("#studentStatisticsTable");

        var th = createTh(data);
        th.appendTo(table);

        for (var index = 0; index < data.studentStatisticsList.length; index++) {
            var tr = createTr(data.studentStatisticsList[index], data.maxCourseCount, data.maxCourseDay);
            tr.appendTo(table);
        }

        $("#refreshCourseTable").attr('disabled', false);
    }

    function createTh(data) {
        var tableHeader = $("<thead></thead>");
        // 标题第一行
        var tr = $("<tr class='ui-state-default'></tr>");
        tr.appendTo(tableHeader);

        var nameTh = $("<th rowspan='2' style='text-align:center;width: 10%;'>姓名</th>");
        nameTh.appendTo(tr);

        var descTh = $("<th rowspan='2' style='text-align:center;width: 15%;'>备注</th>");
        descTh.appendTo(tr);

        var courseTh = $("<th colspan='" + data.maxCourseCount + "' style='text-align:center;width: 5%;'>课时</th>");
        courseTh.appendTo(tr);

        var renewRecordTh = $("<th colspan='4' style='text-align:center;width: 20%;'>缴费情况</th>");
        renewRecordTh.appendTo(tr);

        var courseDayTh = $("<th colspan='" + data.maxCourseDay + "' style='text-align:center;width: 50%;'>" + data.monthInTable + "</th>");
        courseDayTh.appendTo(tr);

        // 标题第二行
        var trSecond = $("<tr class='ui-state-default'></tr>");
        trSecond.appendTo(tableHeader);

        for (var index = 1; index <= data.maxCourseCount; index++) {
            createStandardTh(numToCN(index), trSecond);
        }

        createStandardTh('结余', trSecond);
        createStandardTh('应付', trSecond);
        createStandardTh('实付', trSecond);
        createStandardTh('日期', trSecond);

        for (var index = 1; index <= data.maxCourseDay; index++) {
            createStandardTh(index, trSecond);
        }

        return tableHeader;
    }

    function numToCN(index) {
        var arr = ['', '一', '二', '三'];
        return arr[index];
    }

    function createStandardTh(name, tr) {
        var standardTh = $("<th style='text-align:center'>" + name + "</th>");
        standardTh.appendTo(tr);
    }


    function createTr(studentStatistics, maxCourseCount, maxCourseDay) {

        var tr = $("<tr></tr>");

        createStandardTd(studentStatistics.studentName, tr);
        createStandardTd(studentStatistics.description, tr);

        for (var index = 0; index < maxCourseCount; index++) {
            if (index < studentStatistics.courseCount) {
                createStandardTd(studentStatistics.courseArr[index], tr);
            } else {
                createStandardTd('', tr);
            }
        }

        createStandardTd(studentStatistics.studentRenewRecord.remainCourse, tr);
        createStandardTd(studentStatistics.studentRenewRecord.amountPayable, tr);
        createStandardTd(studentStatistics.studentRenewRecord.amountPay, tr);
        createStandardTd(studentStatistics.studentRenewRecord.payDate, tr);

        for (var index2 = 0; index2 < maxCourseDay; index2++) {
            if (index2 < studentStatistics.studentCourseSignStatistics.totalCount) {
                var studentCourseSignRecord = studentStatistics.studentCourseSignStatistics.studentCourseSignRecordList[index2];
                if (typeof(studentCourseSignRecord) !== "undefined") {
                    if (studentCourseSignRecord.signStatus === 'NORMAL') {
                        createNormalTd(studentCourseSignRecord.courseDate, tr);
                    } else if (studentCourseSignRecord.signStatus === 'SIGNED') {
                        createSuccessTd(studentCourseSignRecord.courseDate, tr);
                    } else if (studentCourseSignRecord.signStatus === 'PERSONAL_LEAVE' || studentCourseSignRecord.signStatus === 'PLAY_TRUANT') {
                        createErrorTd(studentCourseSignRecord.courseDate, tr);
                    } else if (studentCourseSignRecord.signStatus === 'X_MAKE_UP') {
                        createInfoTd(studentCourseSignRecord.courseDate, tr);
                    } else {
                        createStandardTd(studentCourseSignRecord.courseDate, tr);
                    }
                } else {
                    createStandardTd('0', tr);
                }
            } else {
                createStandardTd('', tr);
            }
        }


        return tr;
    }

    function createStandardTd(name, tr, bgColor) {
        if (null == name || 'null' === name) {
            name = '';
        }

        var standardTh = $("<td style='text-align:center;background-color: " + bgColor + ";'>" + name + "</td>");
        standardTh.appendTo(tr);
    }

    function createNormalTd(name, tr) {
        if (null == name || 'null' === name) {
            name = '';
        }

        var standardTh = $("<td style='text-align:center;background-color: #7B7B7B;'>" + name + "</td>");
        standardTh.appendTo(tr);
    }

    function createSuccessTd(name, tr) {
        if (null == name || 'null' === name) {
            name = '';
        }

        var standardTh = $("<td style='text-align:center;background-color: #00DB00;'>" + name + "</td>");
        standardTh.appendTo(tr);
    }

    function createErrorTd(name, tr) {
        if (null == name || 'null' === name) {
            name = '';
        }

        var standardTh = $("<td style='text-align:center;background-color: #CE0000;'>" + name + "</td>");
        standardTh.appendTo(tr);
    }

    function createInfoTd(name, tr) {
        if (null == name || 'null' === name) {
            name = '';
        }

        var standardTh = $("<td style='text-align:center;background-color: #00E3E3;'>" + name + "</td>");
        standardTh.appendTo(tr);
    }

</script>