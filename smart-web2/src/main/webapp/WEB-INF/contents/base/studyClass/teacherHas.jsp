<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content">
  <div class="panel panel-default m-b-0">
	<div class="panel-heading ui-widget-header">教师【${name }】的班级</div>
	<div class="panel-body p-0 p-t-2 body-bg borer-top">
		<div id="teacher-class-tab" class="cnoj-auto-limit-height">
		    <div class="cnoj-load-url" data-uri="studyTeacher/classList?id=${id }" ></div>
		</div>
	</div>
  </div><!-- panel -->
</div>