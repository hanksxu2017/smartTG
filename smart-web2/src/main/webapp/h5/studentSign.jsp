<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bootstrap 模板</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link href="../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>


<div class="container">


    <ul class="nav nav-tabs">
        <li class="active"><a href="#">点名</a></li>
        <li><a href="#">课时统计</a></li>
        <li><a href="#">本周课时</a></li>
    </ul>


    <table class="table table-hover">
        <caption>
            <label><span>课时:</span></label>
            <select class="">
                <option value="1">周老师星期二5</option>
                <option value="2">周老师星期三5</option>
                <option value="3">周老师星期四5</option>
            </select>
        </caption>
        <thead>
        <tr>
            <th>学生</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>学生小白</td>
            <td><span class="glyphicon glyphicon-ok text-success"></span></td>
            <td>
                <button class="btn btn-info">撤销</button>
            </td>
        </tr>
        <tr>
            <td>学生小青</td>
            <td></td>
            <td>
                <button class="btn btn-success">签到</button>
                <button class="btn btn-danger" data-toggle="modal" data-target="#myModal">缺席</button>
            </td>
        </tr>
        <tr>
            <td>学生小红</td>
            <td><span class="glyphicon glyphicon-remove text-danger"></span></td>
            <td>
                <button class="btn btn-info">撤销</button>
            </td>
        </tr>
        <tr>
            <td>学生小灰</td>
            <td></td>
            <td>
                <button class="btn btn-success">签到</button>
                <button class="btn btn-danger" data-toggle="modal" data-target="#myModal">缺席</button>
            </td>
        </tr>

        </tbody>
    </table>
    <ul class="pager">
        <li><a href="#">上一页</a></li>
        <li><a href="#">下一页</a></li>
    </ul>

</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    模态框（Modal）标题
                </h4>
            </div>
            <div class="modal-body">
                在这里添加一些文本
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="subUnSigned">
                    提交更改
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="../js/jquery-1.11.3.min.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="../plugins/bootstrap/js/bootstrap.min.js"></script>


<script>
    $(function () {
        $("#subUnSigned").on("click", function () {
            $('#myModal').modal('hide');
        });


    });


</script>


</body>
</html>




