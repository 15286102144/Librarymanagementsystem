<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/7/20
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://shiro.apache.org/tags"  prefix="shiro"%>
<html>
<head>
    <title>图书页面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <script src="/static/js/jquery-3.5.0.min.js"></script>
    <style>
        input{
            width: 100px;
        }
        .xiebaotu_son {
            width: 90px;
            height: 80px;
            /* background-color: bisque; */
            margin: 3px auto;
            overflow: hidden;
            position: relative;
        }

        .xiebao_img {
            width: 90px;
            height: 80px;
        }
    </style>
</head>

<body>
<input type="hidden" style="color: red" value="${info}">
<div>

    <form action="${pageContext.request.contextPath}/book/Library.do" method="post">
        图书id：<input type="text" name="bookid" id="bookid" value="${bookid}">
        图书名称：<input type="text" name="bookname" id="bookname" value="${bookname}">
        作者：<input type="text" name="author" id="author" value="${author}">
        出版社：<input type="text" name="press" id="press" value="${press}">
        价格：<input type="text" name="price" id="price" value="${price}">
        <button type="submit" class="btn btn-success btn-sm" style="background-color: aquamarine">查询</button>
    </form>
</div>
<shiro:hasRole name="manager">
<input type="button" value="批量删除" onclick="dell()" class="btn btn-success btn-sm" style="background-color:red">
<a href="${pageContext.request.contextPath}/book/addpage.do" class="btn btn-success btn-sm" style="background-color:coral">添加图书</a>
</shiro:hasRole>
<table class="table">
    <thead>
    <th><input type="checkbox" name="all" onclick="allselect()">全选</th>
    <th>编号</th>
    <th>书名</th>
    <th>简介</th>
    <th>作者</th>
    <th>出版社</th>
    <th>库存数量</th>
    <th>价格</th>
    <th>图片</th>
    <th>查看</th>
    <th>操作</th>
    </thead>
    <tbody>
    <c:forEach items="${data.list}" var="x">
        <tr >
            <td ><input type='checkbox' name='allId' value='"+${x.bookid}+"'></td>
            <td >${x.bookid}</td>
            <td >${x.bookname}</td>
            <td >${x.theme}</td>
            <td >${x.author}</td>
            <td >${x.press}</td>
            <td >${x.sum}</td>
            <td >${x.price}</td>
            <td>
              <%--  <img src="${pageContext.request.contextPath}/static/images/${x.bookname}.png" class="xiebao_img">--%>
                <img src="${pageContext.request.contextPath}${x.picturepath}" class="xiebao_img">
<%--                <div class="xiebaodong"><h5>${x.bookname}</h5></div>--%>
            </div></td>
            <td >
              <%--  <a href="${pageContext.request.contextPath}${x.bookpath}" class="btn btn-success btn-sm">查看详情</a>
              --%>  <a href="${x.bookpath}" class="btn btn-success btn-sm">查看详情</a>
            </td>
            <td >
                <shiro:hasRole name="manager">
                <a href="${pageContext.request.contextPath}/book/updatePage.do?bookid=${x.bookid}" class="btn btn-success btn-sm">修改</a>
                <a href="${pageContext.request.contextPath}/book/delete.do?bookid=${x.bookid}" class="btn btn-success btn-sm" style="background-color: red">删除</a>
                </shiro:hasRole>
                <shiro:hasRole name="user">
                <a href="javascript:void(0)" onclick="addborrow(this)" class="btn btn-success btn-sm" style="background-color:blue">借阅</a></shiro:hasRole>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<a href="${pageContext.request.contextPath}/book/Library.do?page=${data.prePage}&bookname=${bookname}&author=${author}&press=${press}&price=${price}&bookid=${bookid}"
   class="btn btn-success btn-sm" style="background-color: #5bc0de">上一页</a>
<a href="${pageContext.request.contextPath}/book/Library.do?page=${data.nextPage}&bookname=${bookname}&author=${author}&press=${press}&price=${price}&bookid=${bookid}"
   class="btn btn-success btn-sm" style="background-color: chartreuse">下一页</a>
<a href="${pageContext.request.contextPath}/book/Library.do?page=${data.indexPage}&bookname=${bookname}&author=${author}&press=${press}&price=${price}&bookid=${bookid}"
   class="btn btn-success btn-sm">首页</a>
<a href="${pageContext.request.contextPath}/book/Library.do?page=${data.endPage}&bookname=${bookname}&author=${author}&press=${press}&price=${price}&bookid=${bookid}"
   class="btn btn-success btn-sm" style="background-color:blue">尾页</a>
图书数量：<input type="text" value="${data.count}" style="width: 50px;height:30px">
总页数：<input type="text" value="${data.pages}" style="width: 50px;height:30px">
</body>
</html>
<script>
    function addborrow(p) {
        var id = $(p).parent().parent().find("td").eq(1).text();
        var bookid=id;

        var pe={
            "bookid":id,
            "date":new Date(),
            "state":1,
            "appraisal":null
        };
        $.ajax({
            url: "${pageContext.request.contextPath}/book/borrow.ajax",
            type: "get",
            data: pe,
            dataType:"text",
            success: function (data){
                alert(data);

                window.location.reload();
            }
        });
    }
    //全选
    function allselect(){
        $("input[name='allId']").prop("checked",$("input[name='all']").prop("checked"));
    }
    //批量删除
    function dell() {
        //确认框
        var rr = confirm("你确定要删除吗?");
        //点击确定返回的true
        if(rr){
            var allId="";
            $("input[name='allId']:checked").each(function(){
                allId += $(this).val()+",";
            })
            //发送ajax请求
            $.ajax({
                url:"${pageContext.request.contextPath}/book/delAjax.ajax",
                type:"get",
                data:{"id":allId},
                dataType:"text",
                success:function (data) {
                        alert(data);
                        window.location.reload();
                }
            })
        }
    }
</script>