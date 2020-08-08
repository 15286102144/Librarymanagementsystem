<%--
  Created by IntelliJ IDEA.
  User: wang
  Date: 2020/8/3
  Time: 12:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>图书信息修改</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.1.1.min.js"></script>
</head>
<body>
<form action="${pageContext.request.contextPath}/book/update.do" method="post">
    <table class="table">
            <td><input type="hidden" name="bookid" value="${list.bookid}"></td>
        <tr>
            <td>书名</td>
            <td><input type="text" name="bookname" value="${list.bookname}"></td>
        </tr>
        <tr>
            <td>主题</td>
            <td><input type="text" name="theme" value="${list.theme}"></td>
        </tr>
        <tr>
            <td>作者</td>
            <td><input type="text" name="author" value="${list.author}"></td>
        </tr>
        <tr>
            <td>出版社</td>
            <td><input type="text" name="press" value="${list.press}"></td>
        </tr>
        <tr>
            <td>总数</td>
            <td><input type="text" name="sum" value="${list.sum}"></td>
        </tr>
        <tr>
            <td>价格</td>
            <td><input type="text" name="price" value="${list.price}"></td>
        </tr>
        <tr>
            <td>图书图片</td>
            <td><img src="${list.picturepath}"></td>
        </tr>
        <tr>
            <td>图书查看</td>
            <td><a href="${list.bookpath}">详情</td>
        </tr>
        <tr>
            <td><span style="color: red">${info}</span></td>
            <td colspan="2">
                <button type="submit">保存</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
