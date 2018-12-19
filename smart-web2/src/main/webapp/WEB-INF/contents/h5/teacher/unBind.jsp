<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../../../images/logo.png">

    <title>信息登记</title>

    <!-- 引入 Bootstrap -->
    <link href="../../../../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <style type="text/css">

        html,body{
            margin: 0;
            padding: 0;
            width: auto;
            background:url('../../../../images/bkh5.jpg') no-repeat center top;
            /*background-size: cover;*/
        }

    </style>
</head>

<body>

<div class="container">
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">教师信息绑定</h3>
		</div>
		<div class="panel-body">
			<form class="form-signin" action="subRegister">
				<input type="hidden" name="openid" value="${openid}">
				<label for="phone" class="sr-only">手机号</label>
				<input type="text" id="phone" name="phone" class="form-control" placeholder="手机号" required autofocus>
				<button class="btn btn-lg btn-primary btn-block" type="submit">提交申请</button>
			</form>
		</div>
	</div>
</div>

</body>
</html>
