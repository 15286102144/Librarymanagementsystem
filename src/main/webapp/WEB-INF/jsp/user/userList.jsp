<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/3 0003
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://shiro.apache.org/tags"  prefix="shiro"%>
<html>
<head>
    <title>用户的所有信息页面</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <script src="/static/js/jquery-3.5.0.min.js"></script>
    <script src="/static/js/bootstrap.min.js"></script>
</head>
<body onload="load(1)">

    <form method="post">
    用户名：<input type="text" name="username">
    电话号码：<input type="text" name="tel">
             <input style="background-color: #00F7DE" type="button" value="查询" onclick="query()">
    </form>

    <table class="table" border="1">
        <thead>
        <th>用户Id</th>
        <th>用户名</th>
        <th>密码</th>
        <th>性别</th>
        <th>电话号码</th>
        <th>角色</th>
        <th>数量</th>
        <th>操作</th>
        </thead>
        <tbody id="td">

        </tbody>
    </table>


    <div style="text-align: center">
        <a href="javascript:void(0)" onclick="indexPage()" class="btn btn-success btn-sm">首页</a>
        <a href="javascript:void(0)" onclick="prePage()" class="btn btn-success btn-sm">上一页</a>
        <a href="javascript:void(0)" onclick="nextPage()" class="btn btn-success btn-sm">下一页</a>
        <a href="javascript:void(0)" onclick="endPage()" class="btn btn-success btn-sm">尾页</a>
    </div>
    <div class="modal fade" id="one" style="top:200px">
        <div class="modal-dialog">
            <div class="modal-content">
                <!--头部-->
                <div class="modal-header" style="background-color: green; height: 20px;">
                </div>
                <div class="modal-body">
                    <table class="table" border="0">
                        <tr>
                            <td>用户Id</td>
                            <td><input type="text" id="userid"></td>
                        </tr>
                        <tr>
                            <td>姓名</td>
                            <td><input type="text" id="username"></td>
                        </tr>
                        <tr>
                            <td>密码</td>
                            <td><input type="password" id="password"></td>
                        </tr>

                        <tr>
                            <td>性别</td>
                            <td><input type="radio" value="男" name="sex">男
                                <input type="radio" value="女" name="sex">女
                            </td>
                        </tr>

                        <tr>
                            <td>电话号码</td>
                            <td><input type="text" id="tel"></td>
                        </tr>

                        <tr>
                            <td>角色</td>
                            <td><input type="text" id="role"></td>
                        </tr>

                        <tr>
                            <td>数量</td>
                            <td><input type="text" id="total"></td>
                        </tr>

                        <tr>
                            <td><span style="color:red" id="info">222</span></td>
                            <td colspan="2"><button type="button" class="btn btn-success btn-sm" onclick="save()">保存</button></td>

                        </tr>
                    </table>
                </div>

            </div>
        </div>
    </div>

</body>
</html>
<script>
    //待载入页面的URL地址
    //data：待发送key/value参数
    //success：载入成功时回调函数
    //data封装了服务器返回的数据
    // status：状态
    var indexPage;
    var prePage;
    var nPage;
    var endPage;

    //首页
    function indexPage() {
        console.log("inPage="+inPage)
        load(inPage)
    }
    //上一页
    function prePage() {
        console.log("pPage="+pPage)
        load(pPage)
    }
    //下一页
    function nextPage() {
        console.log("nPage="+nPage)
        load(nPage)
    }
    //尾页
    function endPage() {
        console.log("ePage="+ePage)
        load(ePage)
    }
    function load(p) {
        //发送ajaxj请求，ajax默认get请求
        console.log($("input[name='username']").val());
        console.log($("input[name='tel']").val());
        $.ajax({
            url:"/user/queryAllUser.do",//请求地址
            type:"post",//请求方式
            data:{"page":p,"username":$("input[name='username']").val(),"tel":$("input[name='tel']").val()},
            dataType:"json",//返回的数据类型 :对象:json,字符串和数字:text
            success:function (data) { //响应成功需要执行的函数
                console.log(data.list);
                inPage=data.indexPage;
                pPage=data.prePage;
                nPage=data.nextPage;
                ePage=data.endPage;
                var html="";
                for(var i=0;i<data.list.length;i++){
                    html+="<tr>" +
                        "<td>"+data.list[i].userid+"</td>" +
                        "<td>"+data.list[i].username+"</td>" +
                        "<td>"+data.list[i].password+"</td>" +
                        "<td>"+data.list[i].sex+"</td>" +
                        "<td>"+data.list[i].tel+"</td>" +
                        "<td>"+data.list[i].role+"</td>" +
                        "<td>"+data.list[i].total+"</td>"+
                        "<td><button style='background-color:yellow' type='button' onclick='updatePage(this)' >修改</button>" +
                        "<button style='background-color:red' type='button' onclick='deletePage(this)'>删除</button></td>" +

                        "</tr>"
                }
                //把拼接的html变量信息显示在id=tb的标签上
                $("#td").html(html)

            },
            error:function(data){
                //响应失败需要的做的事情
            }
        })

    }
    //打开修改的模态框
    function updatePage(obj) {
        //获取选中行的数据
        var userid =$(obj).parent().parent().find("td").eq(0).text();
        var username =$(obj).parent().parent().find("td").eq(1).text();
        var password =$(obj).parent().parent().find("td").eq(2).text();
        var sex =$(obj).parent().parent().find("td").eq(3).text();
        var tel =$(obj).parent().parent().find("td").eq(4).text();
        var role =$(obj).parent().parent().find("td").eq(5).text();
        var total =$(obj).parent().parent().find("td").eq(6).text();
        //显示模态框
        $("#one").modal("show");

        ///把选中行的数据显示在模态框中
        $("#userid").val(userid);
        $("#username").val(username);
        $("#password").val(password);
        //根据值来判断哪个单选框被选中
        $("input[value='"+sex+"']").prop("checked",true)
        $("#tel").val(tel);
        $("#role").val(role);
        $("#total").val(total);
    }

    //保存
    function save() {
        //获取文本框中的值
        var userid = $("#userid").val()
        var username = $("#username").val()
        var password = $("#password").val()
        var sex = $("input[name='sex']:checked").val()
        var tel = $("#tel").val()
        var role = $("#role").val()
        var total = $("#total").val()
        console.log("userid=" + userid)
        console.log("username=" + username)
        console.log("password=" + password)
        console.log("sex=" + sex)
        console.log("tel=" + tel)
        console.log("role=" + role)
        console.log("total"+total)

        var params;
        params = {
            "userid":userid,
            "username":username,
            "password":password,
            "sex":sex,
            "tel":tel,
            "role":role,
            "total":total},
            console.log(params);
        //发送ajax请求
        $.ajax({
            url:"/user/updateAjax.do",
            type:"post",
            data:params, //构架js对象

            dataType:"json",
            success:function (data) {
                console.log(data)
                //隐藏模态框
                $("#one").modal("hide");
                //刷新
                load(1);
                console.log(data.info)
                // if(data==1){
                //     $("#info").text("修改成功");
                //     //刷新
                //     load();
                //     //关闭模态框
                //     $("#one").modal("hide");
                // }else{
                //     $("#info").text("修改失败");
                // }
            }
        })
    }

    //按条件查询
    function query() {
        load(1);
    }


    //删除
    function  deletePage(obj) {
        var userid =$(obj).parent().parent().find("td").eq(0).text();
        $.ajax({
            url:"/user/delete.do",
            type:"post",
            data:{"userid":userid},
            datatype:"json",
            success:function (data) {
                alert(data.info)
                load(1)
            },
            error:function(data) {
                //响应失败需要的做的事情
                alert(data)
            }
        })
    }

</script>
