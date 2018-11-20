<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="wrap-content-dialog">
   <form class="form-horizontal" role="form" id="form-edit" action="studySystemMessage/update">
       <input type="hidden" name="id" value="${systemMessage.id}">

       <div class="form-group m-b-10">
           <label for="messageType" class="col-sm-2 control-label">消息类型</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control input-readonly" data-label-name="消息类型"
                      id="messageType" value="${systemMessage.messageType}" readonly/>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="messageContent" class="col-sm-2 control-label">消息内容</label>
           <div class="col-sm-9 p-l-0">
               <input type="text" class="form-control input-readonly" data-label-name="消息类型"
                      id="messageContent" value="${systemMessage.messageContent}" readonly/>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="isProcess" class="col-sm-2 control-label">操作</label>
           <div class="col-sm-9 p-l-0">
               <select name="isProcess" class="form-control require" id="isProcess">
                   <option value="NO" <c:if test="${systemMessage.isProcess eq 'NO'}">selected</c:if> >未处理</option>
                   <option value="YES" <c:if test="${systemMessage.isProcess eq 'YES'}">selected</c:if> >已处理完成</option>
               </select>
           </div>
       </div>

       <div class="form-group m-b-10">
           <label for="input03" class="col-sm-2 control-label">处理意见</label>
           <div class="col-sm-9 p-l-0">
               <textarea class="form-control require" name="description" data-label-name="处理意见" rows="8" id="input03" cols="60">${systemMessage.processDesc}</textarea>
           </div>
       </div>

       <div class="text-center">
           <button type="button" class="btn btn-primary cnoj-data-submit" data-refresh-uri="studySystemMessage/list">
               <i class="glyphicon glyphicon-ok-sign"></i> 确定</button>
       </div>
	</form>
</div><!-- wrap-content-dialog -->
