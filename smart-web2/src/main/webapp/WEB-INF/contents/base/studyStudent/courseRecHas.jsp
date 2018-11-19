<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content">
  <div class="panel panel-default m-b-0">
	<div class="panel-heading ui-widget-header">学生列表</div>
	<div class="panel-body p-0 p-t-2 body-bg borer-top">
		<div id="courseRecord-student-tab" class="cnoj-auto-limit-height">
		    <div class="cnoj-load-url" data-uri="studyStudent/studentList?courseRecordId=${courseRecordId}" ></div>
		</div>
	</div>
  </div><!-- panel -->
</div>