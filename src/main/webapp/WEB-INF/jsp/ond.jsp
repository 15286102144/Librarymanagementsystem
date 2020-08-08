<%--
  Created by IntelliJ IDEA.
  User: 14383
  Date: 2020/8/4
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/static/js/jquery-3.5.0.min.js"></script>
</head>
<body>
<form id="uploadForm" enctype="multipart/form-data">
    <p>指定文件名： <input type="text" name="picturepath" value="" /></p>
    <p>上传文件： <input type="file" name="file" /></p>
    <p>上传文件： <input type="file" name="filee" /></p>
    <input type="button" value="上传" onclick="doUpload()" />
</form>
</body>
</html>
<script>
    function doUpload(){
        $.ajax({
            url: '/book/one.do',
            type: 'POST',
            cache: false,
            data: new FormData($('#uploadForm')[0]),
            processData: false,
            contentType: false
        }).done(function(res) {}).fail(function(res) {});

    }
</script>