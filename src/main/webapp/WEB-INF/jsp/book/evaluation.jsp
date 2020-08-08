<%--
  Created by IntelliJ IDEA.
  User: wang
  Date: 2020/8/4
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/static/layui/css/layui.css"  media="all">
    <script src="/static/js/jquery-3.5.0.min.js"></script>
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
</head>
<body>
体验评分：<div id="test5" ></div><br>
评价：<br>
<textarea  class="form-control"id="a1" rows="3" style="width: 400px" placeholder="最多不超过300字"></textarea><br>
读后感：<br>
<textarea  class="form-control"id="a2" rows="3" style="width: 400px" placeholder="最多不超过300字"></textarea><br>

<button onclick="aaa()">提交</button>

<script src="/static/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['rate'], function(){
        var rate = layui.rate;
        //自定义文本
        rate.render({
            elem: '#test5'
            ,value: 3
            ,text: true
            ,setText: function(value){ //自定义文本的回调
                var arrs = {
                    '1': '极差'
                    ,'2': '差'
                    ,'3': '中等'
                    ,'4': '好'
                    ,'5': '极好'
                };
                this.span.text(arrs[value] || ( value + "星"));
            }
        })
    });
    function aaa() {
    var score=$("span[class=layui-inline]").text()
    var evaluation=$("#a1").val()
    var feeling=$("#a2").val()
        var data=new Date();
     $.ajax({
         url:"/book/evaluation.ajax",
         data:{"score":score,"evaluation":evaluation,"feeling":feeling,"data":data},
         dataType:"text",
         success:function (data) {
           alert(data);
           window.location.reload();
         }
     })
    }
</script>

</body>
</html>
