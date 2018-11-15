<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="form-edit" action="/studyTeacher/update">
		    <input type="hidden" name="id" value="${objBean.id }" />
		    <div class="form-group m-b-10">
			    <label for="input01" class="col-sm-2 control-label">姓名</label>
			    <div class="col-sm-9 p-l-0">
			      <input type="text" class="form-control require" name="name" data-label-name="姓名" id="input01" value="${objBean.name}" />
			    </div>
			</div>

	   <div class="form-group m-b-10">
		   <label for="input02" class="col-sm-2 control-label">手机</label>
		   <div class="col-sm-9 p-l-0">
			   <input type="text" class="form-control require" name="phone" data-label-name="手机" id="input02" value="${objBean.phone}" />
		   </div>
	   </div>

       <div class="form-group m-b-10">
           <label for="input03" class="col-sm-2 control-label">围棋等级</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control require" name="level" data-label-name="围棋等级" id="input03" value="${objBean.level}" />
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="input04" class="col-sm-2 control-label">状态</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control input-readonly" data-label-name="入职时间" id="input04" value="${objBean.status}" readonly/>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="input05" class="col-sm-2 control-label">入职时间</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control input-readonly" data-label-name="入职时间" id="input05" value="${objBean.createTime}" readonly/>
           </div>
       </div>

			<div class="text-center">
			      <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studyTeacher/list">
			      <i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
			</div>
	</form>
</div><!-- wrap-content-dialog -->