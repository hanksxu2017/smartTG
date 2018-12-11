<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<c:set var="ctx" value="${basePath}"/>
<div class="panel">
    <div class="panel-body panel-body-noheader panel-body-noborder">
        <div class="loading-content" style="visibility: visible;">

            <div class="wrap-content">
                <div class="panel panel-info no-border">

                    <div class="table-body-scroll table-wrap-limit">
                        <table id="courseTable" class="table table-striped table-bordered table-condensed"
                               style="width: 80%;text-align:center">
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
<%--            <button type="button" id="generateWeekCourse" class="btn btn-default"  disabled="disabled">
                <i class="glyphicon glyphicon-calendar"></i>生成周课时
            </button>--%>
            <button type="button" id="clearSystemMem" class="btn btn-default"  disabled="disabled">
                <i class="glyphicon glyphicon-adjust"></i>清理缓存
            </button>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(function () {
        var url = "${ctx}/studyCourse/generateCourseTable";
        $.ajax({
            type: "GET",
            url: url,
            success: function (data) {
                if (data.result === '1') {
                    initCourseTable(data.data);
                }
            }
        });

        $("#refreshCourseTable").click(function () {
            reloadTab($(this).data("uri"));
        });
        
        $("#generateWeekCourse").on("click", function () {
            var uri = '/studyCourse/record/generateDailyCourse';
            BootstrapDialogUtil.loadUriDialog('生成周课时',uri, 600,"#fff",false,function(dialog){
                initEvent(dialog.getModal());
            });
        });

        $("#clearSystemMem").on("click", function () {
            $.ajax({
                type: "GET",
                url: '/studyCourse/record/clearSystemMem',
                success: function (data) {
                    if (data.result === '1') {
                        reloadTab($(this).data("uri"));
                    }
                }
            });
        });
    });

    /**
     * 初始化表格
     * @param data
     */
    function initCourseTable(data) {
        // var table = $("<table border='1' class='table table-striped table-bordered table-condensed'>");
        var table = $("#courseTable");

        // table.appendTo($("#tableDiv"));
        var th = createTh(data.th);
        th.appendTo(table);

        for (var index = 0; index < data.trs.length; index++) {
            var tr = createTr(data.trs[index], data.th.classroomList);
            tr.appendTo(table);
        }

        $("#refreshCourseTable").attr('disabled',false);
        $("#generateWeekCourse").attr('disabled',false);
        $("#clearSystemMem").attr('disabled',false);
        // $("#tableDiv").append("</table>");
    }

    function createTh(thData) {
        var thead = $("<thead></thead>");
        var tr = $("<tr class='ui-state-default'></tr>");
        tr.appendTo(thead);

        var blankTh = $("<th width='10%'></th>");
        blankTh.appendTo(tr);

        blankTh = $("<th width='10%'></th>");
        blankTh.appendTo(tr);

        for (var index = 0; index < thData.classroomList.length; index++) {
            var th = $("<th style='text-align:center'>" + thData.classroomList[index].name + "</th>");
            th.appendTo(tr);
        }

        return thead;
    }

    function createTr(trData, classroomList) {
        var tr = $("<tr></tr>");

        // trs.weekInfoEntity 增加当天的课时数量，以便进行行合并
        // trs.courseTimeEntity 增加当天第一节标记，以便确定行合并的起始位置

        // var weekInfo = $("<td>" + trData.weekInfoEntity.weekInfoStr + "</td>");
        var count = parseInt(trData.weekInfoEntity.courseCount);
        if (count > 1) {
            if (trData.courseTimeEntity.first === 'YES') {
                var weekInfo = $("<td rowspan='" + count + "'>" + trData.weekInfoEntity.weekInfoStr + "</td>");
                weekInfo.appendTo(tr);
            }
        } else {
            var weekInfo = $("<td>" + trData.weekInfoEntity.weekInfoStr + "</td>");
            weekInfo.appendTo(tr);
        }

        var courseTime = $("<td>" + trData.courseTimeEntity.courseTime + "</td>");
        courseTime.appendTo(tr);

        for (var colIndex = 0; colIndex < classroomList.length; colIndex++) {
            var td = $("<td></td>");
            for (var tdIndex = 0; tdIndex < trData.tds.length; tdIndex++) {
                if (trData.tds[tdIndex].classroomId === classroomList[colIndex].id) {
                    td = $("<td>" + trData.tds[tdIndex].course.teacherName + "</td>");
                }
            }
            td.appendTo(tr);
        }
        return tr;
    }


</script>