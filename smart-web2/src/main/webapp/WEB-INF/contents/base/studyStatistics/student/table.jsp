<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="ctx" value="${basePath}"/>

<div class="panel">
    <div class="panel-body panel-body-noheader panel-body-noborder">
        <div class="loading-content"></div>
        <div class="wrap-content">
            <div class="panel-search">
                <form class="form-inline cnoj-entry-submit" id="search-form" method="post" role="form"
                      action="studyStatistics/student/list">
                    <div class="form-group p-r-10">
                        <label for="studentNameForSearchStatistics">姓名:</label>
                        <input type="text" class="form-control input-form-control" id="studentNameForSearchStatistics"
                               name="name"
                               placeholder="姓名" value="${searchParam.name }"/>
                    </div>
                    <div class="form-group p-r-10">
                        <label for="monthSelForSearchStatistics" class="control-label">月份</label>
                        <select class="form-control" id="monthSelForSearchStatistics" name="month">
                            <c:forEach items="${monthList}" var="item">
                                <option value="${item.month}"
                                        <c:if test="${searchParam.month eq item.month}">selected</c:if>  >${item.monthDesc}</option>
                            </c:forEach>
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
            <div class="panel panel-default no-border">
                <div class="cnoj-table-wrap table-body-scroll table-wrap-limit cnoj-table-wrap-listener"
                     data-subtract-height="0">
                    <!-- table here -->
                    <table id="studentStatisticsTable" class="table table-striped table-bordered table-condensed"
                           style="width: 80%;">
                    </table>

                </div>
                <div class="panel-footer panel-footer-page">
                    <!-- btn -->
                    <div class="btn-list">
                        <div class="btn-group cnoj-op-btn-list">
                            <button type="button" id="refreshStudentStatisticsTable" class="btn btn-default"
                                    disabled="disabled">
                                <i class="glyphicon glyphicon-refresh"></i>刷新
                            </button>
                        </div>
                    </div>
                    <div class="btn-page">
	                    <input type="hidden" id="curPage">
                        <div class="page">
                            <ul class="pagination" id="turnPage">
                            </ul>
                        </div>
                    </div>

                    <div class="page-info">
                        <span id="pageSpan"></span>&nbsp;&nbsp;
                        <span id="totalNumSpan"></span>
                        <span>(每页显示
                            <select class="form-control input-sm cnoj-change-pagesize" id="pageSizeSelectForStudentStatistics">
                                <option selected="selected" value="20">20</option>
                                <option value="30">30</option>
                                <option value="40">40</option>
                                <option value="50">50</option>
                            </select>
                        </span>条)
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(function () {
        var initParams = 'name=' + $("#studentNameForSearchStatistics").val();
        loadStatisticsData(initParams);

        $("#refreshStudentStatisticsTable").click(function () {
            reloadTab($(this).data("uri"));
        });
        
        $("#pageSizeSelectForStudentStatistics").change(function () {
            var params = 'pageSize=' + $(this).val() + '&page=1';
            loadStatisticsData(params);
        });

        $("#pageSelectForStudentStatistics").change(function () {
            var params = 'pageSize=' + $("#pageSizeSelectForStudentStatistics").val() + '&page=' + $(this).val();
            loadStatisticsData(params);
        });
    });
    
    function loadStatisticsData(params) {
        // 禁止所有按钮操作
        disabledAllButton();

        var url = "${ctx}/studyStatistics/student/generateStatisticsTable";
        if(null != params && '' !== params) {
            url += '?' + params;
        }
        $.ajax({
            type: "GET",
            url: url,
            success: function (data) {
                if (data.result === '1') {
                    initStatisticsStudentTable(data.data);
                    //
                    loadPageInfo(data);
                }
            }
        });
    }

    function disabledAllButton() {
        $(".cnoj-search-submit").attr('disabled',true);
        $("#refreshStudentStatisticsTable").attr('disabled',true);
        $("#turnPage").find('li').attr('disabled',true);
        $("#pageSizeSelectForStudentStatistics").attr('disabled',true);
    }

    function enableAllButton() {
        $(".cnoj-search-submit").attr('disabled',false);
        $("#refreshStudentStatisticsTable").attr('disabled',false);
        $("#turnPage").find('li').attr('disabled',false);
        $("#pageSizeSelectForStudentStatistics").attr('disabled',false);
    }

    /**
     * 初始化表格
     * @param data
     */
    function initStatisticsStudentTable(data) {
        // 清空表格
        $("#studentStatisticsTable").empty("");

        var table = $("#studentStatisticsTable");

        var th = createTh(data);
        th.appendTo(table);

        for (var index = 0; index < data.studentStatisticsList.length; index++) {
            var tr = createTr(data.studentStatisticsList[index], data.maxCourseCount, data.maxCourseDay);
            tr.appendTo(table);
        }

        enableAllButton();
    }

    function createTh(data) {
        var tableHeader = $("<thead></thead>");
        // 标题第一行
        var tr = $("<tr class='ui-state-default'></tr>");
        tr.appendTo(tableHeader);

        var nameTh = $("<th rowspan='2' style='text-align:center;width: 10%;'>姓名</th>");
        nameTh.appendTo(tr);

        var descTh = $("<th rowspan='2' style='text-align:center;width: 10%;'>备注</th>");
        descTh.appendTo(tr);

        var courseTh = $("<th colspan='" + data.maxCourseCount + "' style='text-align:center;width: 10%;'>课时</th>");
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
                        if(studentCourseSignRecord.signType === 'MAKE_UP') {
                            createInfoTd(studentCourseSignRecord.courseDate, tr);
                        } else {
                            createSuccessTd(studentCourseSignRecord.courseDate, tr);
                        }
                    } else if (studentCourseSignRecord.signStatus === 'PERSONAL_LEAVE' || studentCourseSignRecord.signStatus === 'PLAY_TRUANT') {
                        createErrorTd(studentCourseSignRecord.courseDate, tr);
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

    function loadPageInfo(data) {
        $("#pageSpan").text(data.size + " - " + data.totalPage);
        $("#totalNumSpan").text('共' + data.totalNum + '条');
        $("#pageSizeSelect").val(data.perPageSize);
        $("#curPageNum").text(data.size);

        $("#pageSelectForStudentStatistics").empty();
        for(var index = 1; index <= data.totalPage; index++) {
            $("#pageSelectForStudentStatistics").append("<option value='" + index + "'>" + index + "</option>");
        }
        $("#pageSelectForStudentStatistics").val(data.size);

        createPagination(data);

        /*var lis = $("#turnPage").find('li');
        if(1 == data.size) {
            // 第一页
            $(lis).eq(0).addClass('disabled');
            if(data.totalPage > data.size){
                $(lis).eq(2).removeClass('disabled');
                $(lis).eq(2).addClass('active');
            } else {
                $(lis).eq(2).removeClass('active');
                $(lis).eq(2).addClass('disabled');
            }
        } else if(data.size > 1){
            $(lis).eq(0).removeClass('disabled');
            $(lis).eq(0).addClass('active');

            if(data.totalPage > data.size) {
                // 开启下一页
                $(lis).eq(2).removeClass('disabled');
                $(lis).eq(2).addClass('active');
            } else {
                // 关闭下一页
                $(lis).eq(2).removeClass('active');
                $(lis).eq(2).addClass('disabled');
            }
        }*/
    }
    
    function createPagination(data) {
        $("#curPage").val(data.size);
        var paginationUl = $("#turnPage");
        paginationUl.empty();

        // 前一页
        var previousPage = null;
        if(data.size == 1) {
            previousPage = $("<li class='disabled'><a href='javascript:void(0)' onclick='turnPage(-1)'>&laquo;</a></li>");
        } else {
            previousPage = $("<li ><a href='javascript:void(0)' onclick='turnPage(-1)'>&laquo;</a></li>");
        }
	    previousPage.appendTo(paginationUl);

        // 中间数字页
	    if(data.totalPage >= 1 && data.totalPage <= 5) {
            createPageNum(1, data.totalPage, data.size, paginationUl);
	    } else {
            if(data.size >= 1 && data.size <= 5) {
                createPageNum(1, 5, data.size, paginationUl);
            } else {
                createPageNum((data.size - 1), (data.size + 1), data.size, paginationUl);
            }
	    }


		// 后一页
        var nextPage = null;
		if(data.size == data.totalPage) {
			nextPage = $("<li class='disabled'><a href='javascript:void(0)' onclick='turnPage(1)'>&raquo;</a></li>");
		} else {
		    nextPage = $("<li><a href='javascript:void(0)' onclick='turnPage(1)'>&raquo;</a></li>");
		}
        nextPage.appendTo(paginationUl);

    }
    
    function createPageNum(min, max, pageNum, paginationUl) {
	    for(var index = min; index <= max; index++) {
            var li = null;
            if(index == pageNum) {
                li = $("<li class='active'><a href='javascript:void(0)' onclick='forwardPage(" + index + ")'>" + index + "</a></li>");
	        } else {
                li = $("<li><a href='javascript:void(0)' onclick='forwardPage(" + index + ")'>" + index + "</a></li>");
	        }
	        li.appendTo(paginationUl);
	    }
    }
    
    function turnPage(offset) {
        var curPageNum = $("#curPage").val();
        var targetPage = parseInt(curPageNum) + offset;
        var params = 'pageSize=' + $("#pageSizeSelectForStudentStatistics").val() + '&page=' + targetPage;
        loadStatisticsData(params);
    }
    
    function forwardPage(pageNum) {
        var params = 'pageSize=' + $("#pageSizeSelectForStudentStatistics").val() + '&page=' + pageNum;
        loadStatisticsData(params);
    }

</script>