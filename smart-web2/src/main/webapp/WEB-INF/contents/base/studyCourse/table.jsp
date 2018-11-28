<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<c:set var="ctx" value="${basePath}"/>
<div id="tableDiv">


</div>

<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
<script type="text/javascript">

	$(function () {
        var url = "${ctx}/studyCourse/generateCourseTable";
        $.ajax({
            type: "GET",
            url: url,
            success: function(data){
                if(data.result === '1') {
                    initCourseTable(data.data);
                }
            }
        });
    });

    /**
     * 初始化表格
     * @param data
     */
    function initCourseTable(data) {
        var table = $("<table border=\"1\">");
        table.appendTo($("#tableDiv"));
				var th = createTh(data.th);
				th.appendTo(table);

			   for(var index = 0; index < data.trs.length; index++) {
					var tr = createTr(data.trs[index], data.th.classroomList);
					tr.appendTo(table);
				}

        $("#tableDiv").append("</table>");
    }
    
    function createTh(thData) {
        var th = $("<tr></tr>");
        var blankTd = $("<td colspan='" + thData.blankCount + "'></td>");
        blankTd.appendTo(th);
        for (var index = 0; index < thData.classroomList.length; index++) {
            var td = $("<td>" + thData.classroomList[index].name + "</td>");
            td.appendTo(th);
        }
        return th;
    }
    
    function createTr(trData, classroomList) {
        var tr = $("<tr></tr>");

        // trs.weekInfoEntity 增加当天的课时数量，以便进行行合并
	    // trs.courseTimeEntity 增加当天第一节标记，以便确定行合并的起始位置

        // var weekInfo = $("<td>" + trData.weekInfoEntity.weekInfoStr + "</td>");
        if(trData.weekInfoEntity.weekInfoStr === '星期六' && trData.courseTimeEntity.courseTimeIndex === 1) {
            var weekInfo = $("<td rowspan='5'>" + trData.weekInfoEntity.weekInfoStr + "</td>");
            weekInfo.appendTo(tr);
        }


		var courseTime = $("<td>" + trData.courseTimeEntity.courseTime + "</td>");
        courseTime.appendTo(tr);

		for(var colIndex = 0; colIndex < classroomList.length; colIndex++) {
            var td = $("<td></td>");
		    for(var tdIndex = 0; tdIndex < trData.tds.length; tdIndex++) {
				if(trData.tds[tdIndex].classroomId === classroomList[colIndex].id) {
                    td = $("<td>" + trData.tds[tdIndex].course.name + "</td>");
				}
		    }
            td.appendTo(tr);
		}
        return tr;
    }


</script>