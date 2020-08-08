<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/7/20
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>图书页面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/shouye.css" />
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.1.1.min.js"></script>
</head>
<body>
<input type="hidden" style="color: red" value="${info}">
<div>
</div>
<table class="table">
    <thead>
    <th>用户id</th>
    <th>用户名</th>
    <th>体验评分</th>
    <th>用户评价</th>
    <th>读后感</th>
    <th>评价时间</th>
    </thead>
    <tbody>
    <c:forEach items="${dapt}" var="x">
        <tr>
            <td >${x.userid}</td>
            <td >${x.username}</td>
            <td >${x.score}</td>
            <td >${x.evaluation}</td>
            <td >${x.feeling}</td>
            <td >${data}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
