<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/7/20
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/shouye.css"/>
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.1.1.min.js"></script>
    <style>
        img{
            width: 90px;
            height: 80px;
        }
    </style>
</head>
<body>
<input type="hidden" style="color: red" value="${info}">
<div>
    <form action="${pageContext.request.contextPath}/brrowBook/selectAllBoorowBooks.do" method="post">
        用户id：<input type="text" name="userid" id="userid" value="">
        图书id：<input type="text" name="bookid" id="bookid" value="">
        <button type="submit" class="btn btn-success btn-sm" style="background-color: aquamarine">查询</button>
    </form>
</div>
<table class="table">
    <thead>
    <th>读者id</th>
    <th>读者姓名</th>
    <th>书籍编号</th>
    <th>书名</th>
    <th>简介</th>
    <th>作者</th>
    <th>出版社</th>
    <th>价格</th>
    <th>借阅时间</th>
    <th>图片</th>
    <th>查看</th>
    <th>状态</th>
    </thead>
    <tbody>
    <c:forEach items="${borrowbookMessage_list.list}" var="borrowbookMessage">
        <tr>
            <td>${borrowbookMessage.user.userid}</td>
            <td>${borrowbookMessage.user.username}</td>
            <td>${borrowbookMessage.book.bookid}</td>
            <td>${borrowbookMessage.book.bookname}</td>
            <td>${borrowbookMessage.book.theme}</td>
            <td>${borrowbookMessage.book.author}</td>
            <td>${borrowbookMessage.book.press}</td>
            <td>${borrowbookMessage.book.price}</td>
            <td><fmt:formatDate value="${borrowbookMessage.date }"
                                pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><div class="xiebaotu_son">
                <img src="${borrowbookMessage.book.picturepath}" class="xiebao_img">
            </div></td>
            <td><a href="${borrowbookMessage.book.bookpath}"></a></td>
            <td>
                <c:if test="${borrowbookMessage.state == 0}"><a
                        href="${pageContext.request.contextPath}/book/updatePage.do?bookid=${x.bookid}"
                        class="btn btn-success btn-sm" style="background-color: green">已还</a></c:if>
                <c:if test="${borrowbookMessage.state == 1}"><a
                        href="${pageContext.request.contextPath}/book/delete.do?bookid=${x.bookid}"
                        class="btn btn-success btn-sm" style="background-color: red">未还</a></c:if>
            </td>

        </tr>
    </c:forEach>
    </tbody>
</table>
<a href="${pageContext.request.contextPath}/brrowBook/selectAllBoorowBooks.do?page=${borrowbookMessage_list.prePage}"
   class="btn btn-success btn-sm" style="background-color: #5bc0de">上一页</a>
<a href="${pageContext.request.contextPath}/brrowBook/selectAllBoorowBooks.do?page=${borrowbookMessage_list.nextPage}"
   class="btn btn-success btn-sm" style="background-color: chartreuse">下一页</a>
<a href="${pageContext.request.contextPath}/brrowBook/selectAllBoorowBooks.do?page=${borrowbookMessage_list.indexPage}"
   class="btn btn-success btn-sm">首页</a>
<a href="${pageContext.request.contextPath}/brrowBook/selectAllBoorowBooks.do?page=${borrowbookMessage_list.endPage}"
   class="btn btn-success btn-sm" style="background-color:blue">尾页</a>
借阅总量：<input type="text" value="${borrowbookMessage_list.alltotals}" style="width: 50px;height:30px">
总页数：<input type="text" value="${borrowbookMessage_list.allPages}" style="width: 50px;height:30px">
</body>
</html>
