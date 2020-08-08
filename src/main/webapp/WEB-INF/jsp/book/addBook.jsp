<%--
  Created by IntelliJ IDEA.
  User: zhaochuan
  Date: 2020/8/3
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
    <script type="text/javascript"
            src="https://cdn.bootcss.com/jquery/3.5.0/jquery.min.js"></script>
    <script href="static/js/bootstrap.js"></script>
    <script href="static/lib/layui/layui.all.js"></script>
    <script href="static/lib/layui/layui.js"></script>
    <link rel="stylesheet" href="/static/lib/layui/css/layui.css">


</head>
<body>
<div class="container">
    <center>
        <form class="layui-form" id="form" enctype="multipart/form-data" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">图书</label>
                <div class="layui-input-block">
                    <input type="text" placeholder="书名" name="bookname" id="bookname" required  lay-verify="required"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">作者</label>
                <div class="layui-input-block">
                    <input type="text"  placeholder="作者" name="author" id="author" required  lay-verify="required"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">出版社</label>
                <div class="layui-input-block">
                    <input type="text" placeholder="出版社" name="press" id="press" required  lay-verify="required"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">价格</label>
                <div class="layui-input-block">
                    <input type="number"placeholder="价格" name="price" id="price" required  lay-verify="required" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">数量</label>
                <div class="layui-input-block">
                    <input type="number" placeholder="数量" name="sum" id="sum" required  lay-verify="required"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">图书简介</label>
                <div class="layui-input-block">
                    <textarea name="theme"  id="theme" placeholder="请输入内容" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-row layui-col-space10"><div class="layui-col-md6">
            图片 <input type="file"  name="imgFile" id="imgFile" multiple="multiple" ></div>
                <div class="layui-col-md6">
            电子档 <input type="file"  name="document" id="document" multiple="multiple" ></div>
            </div>
            <br><br><br><br><br><br>
            <center>
                <input type="button" value="添 加"class="layui-btn" onclick="add()">
                <button type="reset" class="layui-btn layui-btn-normal layui-btn-primary">重 置</button></center>

        </form>
    </center>
</div>

</body>
<script>
    function add() {

        var formData = new FormData($("#form")[0]);
        console.log(formData)
        $.ajax({
            url:"addBook.do",
            data: formData,
            type:"post",
            cache:false,
            contentType: false,  //contentType 主要设置你发送给服务器的格式,文件上传固定格式，设置为false
            processData: false,  //processData默认情况下会将发送的数据序列化以适应默认的内容类型application/x-www-form-urlencoded
            success:function (data) {
                alert(data);
                window.location.reload();
            },
            error:function (data) {
                alert("失败");
            }
        }).done(function (res) {}).fail(function (res) {});

    }


</script>
</html>
