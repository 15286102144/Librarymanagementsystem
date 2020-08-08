<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/7/20
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>图书借阅超时页面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/shouye.css" />
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.1.1.min.js"></script>
</head>
<body>
<span style="color: red">${list[0].info}</span>
<table class="table">
    <thead>
    <th>用户名</th>
    <th>图书id</th>
    <th>图书名称</th>
    <th>借书时间</th>
    <th>图书状态</th>
    <th>操作</th>
    </thead>
    <tbody>
      <c:forEach items="${list}" var="x">
        <tr>
            <td >${x.username}</td>
            <td >${x.bookid}</td>
            <td >${x.bookname}</td>
            <td>${x.date}</td>
            <td >未还</td>
            <td >
                <a href="/book/huanshu.do?id=${x.id}&bookid=${x.bookid}" class="btn btn-success btn-sm">还书</a>
                <a href="/book/xujie.do?id=${x.id}" class="btn btn-success btn-sm" style="background-color:blue">续借</a>
            </td>
        </tr>
      </c:forEach>
    </tbody>
</table>
</body>
</html>
