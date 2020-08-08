<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: 14383
  Date: 2020/8/3
  Time: 16:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css">
    <script src="/static/layui/layui.all.js"></script>
    <script src="/static/js/jquery-3.5.0.min.js"></script>
</head>
<body>
<table class="layui-table">
    <colgroup>
        <col width="150">
        <col width="200">
        <col>
    </colgroup>
    <thead>
    <tr>
        <th>书名</th>
        <th>作者</th>
        <th>出版社</th>
        <th>图片</th>
        <th>评价</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
<c:forEach items="${borrowbookList}" var="lis">
    <tr>
   <td >${lis.book.bookname}</td>
   <td>${lis.book.author}</td>
   <td>${lis.book.press}</td>
  <td>     <img src="${lis.book.picturepath}" alt="..." class="img-rounded"/></td>
   <td>${lis.appraisal}</td>

        <td ><button type="button"

                     onclick="deleted(${lis.id})">删除</button></td>

    </tr>
</c:forEach>
    </tbody>
</table>

</body>
</html>
<script>
            function  deleted (id){
                var url="";
                <shiro:hasRole name="user">
                url="/user/regest.do";
                </shiro:hasRole>
                <shiro:hasRole name="user">
                url="/brrowBook/deleteById.do"
                </shiro:hasRole>
               var falge =confirm("确定删除评价吗");
               if(falge) {
                   $.ajax({
                       type: "post",
                       url: url,
                       dataType: "text",
                       data: {"id": id, "appraisal": ""},
                       success: function (info) {
                           if (info) {
                               //layer.msg("登录成功", {icon: 1});
                               alert("删除成功");
                           } else {
                               layer.msg('删除失败！', {icon: 2});
                           }
                           window.location.reload();
                       },
                       error: function () {
                           layer.msg('注册失败', {icon: 2});
                       }
                   })
               }
    }


</script>
