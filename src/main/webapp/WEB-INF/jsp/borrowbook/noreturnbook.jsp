<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/4
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <script src="/static/js/jquery-3.5.0.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
</head>
<body onload="load(1)">
<div style="float:left;height: 40px;">
    书名：<input name="shuming" type="text" value="${search.bookname}">&nbsp;&nbsp;作者：<input type="text" name="zuozhe" value="${search.author}">&nbsp;&nbsp;出版社：<input
        name="chubanshe" value="${search.press}" type="text">&nbsp;&nbsp;
    <button onclick="check()">search</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <button onclick="ruturnallbook()">批量删除</button>
</div>
<table class="table table-hover">
    <thead>
    <tr>
        <th style="text-align: center"><input type="checkbox" name="allcheck" id="all" onclick="checkedall()">全选</th>
        <th style="text-align: center">书名</th>
        <th style="text-align: center">作者</th>
        <th style="text-align: center">出版社</th>
        <th style="text-align: center">价格</th>
        <th style="text-align: center">借书时间</th>
        <th style="text-align: center">操作</th>
    </tr>
    </thead>
    <tbody id="tbody">

    </tbody>
</table>

<center>
    <li>
        <a href="javascript:void(0)" onclick="firstpage()">首页</a>
        <a href="javascript:void(0)" onclick="prepage()">上一页</a>
        第<span id="span"></span>页
        <a href="javascript:void(0)" onclick="nextpage()">下一页</a>
        <a href="javascript:void(0)" onclick="endpage()">尾页</a>
    </li>
</center>
<input type="hidden" id="hhh" value="${userinfo.userid}">
</body>
<script>
    var fpage;
    var epage;
    var ppage;
    var npage;
    var tpage;
    var userid = $("#hhh").val();


    function firstpage() {
        load(fpage);
    }

    //上一页
    function prepage() {
        load(ppage);
    }

    function nextpage() {
        load(npage);
    }

    function endpage() {
        load(epage);
    }

    function load(thispage) {

        var bookname=$("input[name='shuming']").val();
        var author=$("input[name='zuozhe']").val();
        var press=$("input[name='chubanshe']").val();

        $.ajax({
            url: "/brrowBook/noreturnbook.ajax?bookname="+bookname+"&author="+author+"&press="+press,
            type: "post",
            data: {"page": thispage, "userid": userid},
            dataType: "json",
            success: function (data) {
                console.log(data.list)
                ppage = data.prepage;
                npage = data.nextpage;
                fpage = data.firstpage;
                epage = data.endpage;
                tpage = data.thispage;
                var html = "";
                for (var i = 0; i < data.list.length; i++) {

                    html += "<tr>" +
                        "<td align='center'><input name='allid' type='checkbox' value='" + data.list[i].id + "'/></td>" +
                        "<td align='center'>" + data.list[i].book.bookname + "</td>" +
                        "<td align='center'>" + data.list[i].book.author + "</td>" +
                        "<td align='center'>" + data.list[i].book.press + "</td>" +
                        "<td align='center'>" + data.list[i].book.price + "</td>" +
                        "<td align='center'>" + data.list[i].date + "</td>" +
                        "<td align='center'><button type='button' onclick='returnbook(this)'>点我删除</button></td>" +
                        "</tr>"
                }
                $("#tbody").html(html);
                $("#span").html(tpage);

            }

        })
    }


    function returnbook(obj) {

        var info = confirm("确定删除?");
        if (info) {
            var id = $(obj).parent().parent().find("input").eq(0).val();
            console.log(id);
            $.ajax({
                url: "/brrowBook/delete.ajax?bookid=" + id,
                type: "post",
                dataType: "text",
                success: function (data) {

                    if (data > 0) {
                        load(tpage);
                    }
                }
            })

        }
    }

    function checkedall() {
        $("input[name='allid']").prop("checked", $("#all").prop("checked"));
    }

    function ruturnallbook() {
        var info = confirm("确定删除选中?");
        if (info) {
            var ids = "";
            $("input[name='allid']:checked").each(function () {
                ids += $(this).val() + ",";
            })

            $.ajax({
                url: "/brrowBook/deleteAllBook.ajax",
                type: "get",
                data: {"id": ids},
                dataType: "json",
                success: function (data) {
                    if (data > 0) {
                        $("#all").prop("checked", false);
                        load(1);
                    }

                }
            })

        }

    }

    function check() {
        load(1)
    }
</script>
</html>

