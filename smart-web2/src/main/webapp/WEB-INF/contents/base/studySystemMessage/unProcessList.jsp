<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content">
    <div id="my-todo-index">
	    <div class="container-fluid list-content">
	      <div class="row">
	       <div class="line-loading m-t-10">正在加载数据...</div>
	      </div>
	  </div>
</div>
</div>
<script type="text/javascript">
   setTimeout("loadTodoJs()", 200);
   function loadTodoJs() {
	   loadingTodoData();
   }
   
   function loadingTodoData() {
	   var $listContent = $("#my-todo-index .list-content");
	   if($listContent.find(".line-loading").length == 0) 
		   $listContent.html("<div class=\"row\"><div class=\"line-loading m-t-10\">正在加载数据...</div></div>");
       $.post('studySystemMessage/unProcessList',function(output){
          var contents = '';
          if(output.result == '1') {
              var datas = output.datas;
              var a = '';
              for(var i=0;i<datas.length;i++) {
                  a = "<a href='#' class='handle-task' data-title='处理系统消息' data-uri='studySystemMessage/process?id=" + datas[i].id + "'><span>" + datas[i].messageContent + "</span></a>";

                  contents +="<div class='row list-row'><div class='col-sm-10 list-col p-l-5 p-r-0'>" + a + "</div>"+
                  "<div class='col-sm-2 list-col p-l-5 p-r-5 text-right'>"+utils.handleShortTime(datas[i].createTime)+"</div>"+
                  "</div>";
              }
          } else {
              contents = "<div class='row'><div class='p-t-20 text-center'>没有待处理的系统消息</div></div>";
          }
          $("#my-todo-index .list-content").html(contents);
          contents = null;
          handleTaskListener();
       });
   }
   
   function handleTaskListener() {
	   $("#my-todo-index .handle-task").click(function(event) {
		   var uri = $(this).data("uri");
	       var title = $(this).data("title");
	       if (!utils.isEmpty(uri)) {
	           // TODO 打开弹出窗口
				openFlowTab(title, uri);
				// openProp(title, uri);
			}
			return false;
		});
   }

   /**
    * 提交表单后刷新首页上的待办任务（提交表单后会调用该方法）
    */
   function submitFormRefershIndexTodo() {
	   setTimeout(function() {
		   loadingTodoData();
	   }, 200);
   }
</script>