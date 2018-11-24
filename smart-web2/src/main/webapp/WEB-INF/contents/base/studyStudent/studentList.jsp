<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="cnoj" uri="/cnoj-tags" %>
<div class="wrap-content">
    <div class="panel no-border">
        <div class="panel-search">
            <form class="form-inline cnoj-entry-submit" id="search-form-user" method="post" role="form"
                  action="studyStudent/studentList" target="#courseRecord-student-tab">
                <input type="hidden" name="courseRecordId" value="${searchParam.courseRecordId}"/>

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

        <cnoj:table smartResp="${smartResp}" headers="姓名,等级,剩余课时,状态,入学时间"
                    headerWidths="30%,10%,20%,10%,30%"
                    isCheckbox="1"
                    isRowSelected="1"
                    page="${pageParam }"
                    currentUri="${currentUri}"
                    customBtns="${customBtns}"
                    refreshBtn="${refreshBtn}"
                    delBtn="${delBtn}"
        />
    </div>
</div>