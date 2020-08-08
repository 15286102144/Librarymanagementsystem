<%--
  Created by IntelliJ IDEA.
  User: 14383
  Date: 2020/8/3
  Time: 12:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
    <script src="/static/js/jquery-3.5.0.min.js"></script>
    <style>
        img{
            height: 50%;
            width: 30%;
        }
    </style>
</head>
<body>
<center>
<form>
    <div class="form-group">
        <label style="font-size: 20px" >书名</label>
        <select id="id" onchange="sve()">
            <option >--请选择书籍--</option>
            <c:forEach items="${borrowbookList}" var="boo">
            <option value="${boo.id}"  >${boo.book.bookname}</option>
            </c:forEach>
        </select>

    </div>
    <div class="form-group" id="change">
        <label   ><a  href="javascript:void(0);"  onclick="xiangx()" >查看详细信息</a></label>
        <div id="vee" style="display: none">
        <img  id="img"><br>
       作者名： <span id="author"></span><br>
       出版社： <span id="press"></span><br>
       价格： <span id="price"></span><br>
       简介： <span id="theme"></span><br>
        </div>
      </div>
    <div class="form-group">
        <label for="exampleInputFile">评价：</label>
        <textarea class="form-control"id="exampleInputFile" rows="3" style="width: 400px" placeholder="最多不超过300字"></textarea>

        <p class="help-block">Example block-level help text here.</p>
    </div>

    <button type="button" onclick="apprice()" class="btn btn-default">Submit</button>
    <button type="reset"   class="btn btn-default">Reset</button>
</form>
</center>
</body>
</html>
<script>
function xiangx(){
    console.log("dddd")
    $("#vee").toggle();
}
   function sve(){

       var se=  $("#id").val();
       <c:forEach items="${borrowbookList}" var="sr">
       if ("${sr.id}"==se)
       {
           $("#author").text("${sr.book.author}");
           $("#press").text("${sr.book.press}");
           $("#price").text("${sr.book.price}");
           $("#theme").text("${sr.book.theme}");
          $("#img").attr("src","${sr.book.picturepath}");
       }

       </c:forEach>
   }
    function apprice(){
   var id=  $("#id").val()
    var appraisal=$("#exampleInputFile").val();


       if(confirm("确定对本书进行评价吗？")){
        $.ajax({
            type:"post",
            url:"/brrowBook/appraisal.do",
            dataType:"text",
            data:{"id":id,"appraisal":appraisal},
            success:function (info) {
                /*alert(info.personName);
                alert(info.personPassword);*/
                alert("评价成功");
                window.location.reload();

            },
            error:function () {
                layer.msg('ajax请求失败', {icon: 2});
            }
        })
    }}

</script>
