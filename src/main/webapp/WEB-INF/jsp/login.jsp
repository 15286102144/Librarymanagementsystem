<%@ page language="java" contentType="text/html; charset=UTF-8"
          pageEncoding="UTF-8"%>
<%@taglib uri="http://shiro.apache.org/tags"  prefix="shiro"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!doctype html>
<html lang="en">
<head>
    <base href="<%=basePath%>" />
    <meta charset="UTF-8">

    <title>图书管理系统</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="/static/css/font.css">
    <link rel="stylesheet" href="/static/css/xadmin.css">
    <script type="text/javascript"
            src="https://cdn.bootcss.com/jquery/3.5.0/jquery.min.js"></script>
    <script type="text/javascript" src="/static/lib/layui/layui.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="/static/js/xadmin.js"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <script type="text/javascript">
        //如果该页面在iframe中出现，那么会自动调用最外层窗口刷新本链接
        if (window != top) {
            top.location.href = location.href;
        }
    </script>

</head>
<body class="login-bg">

<%--模态框--%>
<div class="modal fade" id="one" style="top:200px">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--头部-->
            <div class="modal-header" style="background-color: green; height: 20px;">
            </div>
            <div class="modal-body">
                <form id="form1">
                <table class="table" border="0">
                    <tr>
                        <td>用户名</td>
                        <td><input type="text" name="username">
                        </td>
                    </tr>
                    <tr>
                        <td>密码</td>
                        <td>
                         <input type="password" name="password">
                        </td>
                    </tr>
                    <tr>
                        <td>邮箱：</td>
                        <td>
                            <input type="email" id="email">
                            <button type="button" onclick="yanzheng()">发送验证</button>
                        </td>
                    </tr>
                    <tr>
                        <td>验证码：</td>
                        <td>
                            <input type="text" name="yanz">
                        </td>
                    </tr>
                    <tr>
                        <td>性别</td>
                        <td>
                           <input type="radio" name="sex" value="男">男
                           <input type="radio" name="sex" value="女">女
                        </td>
                    </tr>
                    <tr>
                        <td>电话</td>
                        <td>
                            <input type="text" name="tel"  >
                            <input type="hidden" name="role" value="user">
                            <input type="hidden" name="total" value="3">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><button type="button" onclick="save()" class="btn btn-success btn-sm">确定注册</button></td>
                    </tr>
                </table>
                </form>
            </div>

        </div>
    </div>
</div>
<%--模态框--%>



<%--<shiro:guest>
	游客身份
</shiro:guest><br>--%>
<div class="login" >
    <div class="message">图书管理-用户登录</div>
    <font  id="error" size="10" class="text-align:center" color="red"></font>
    <div id="darkbannerwrap"></div>
    <form method="post" class="layui-form" id="form0">
        <input  placeholder="用户名" type="text" name="username" id="a1"
                class="layui-input">
        <hr class="hr15">
        <input  placeholder="密码" type="password" name="password" id="a2"
                class="layui-input">
        <hr class="hr15">
        <input lay-submit lay-filter="login" style="width: 100%;"
               type="button" value="登录" onclick="login()" /><br><br>
        <input lay-submit lay-filter="login" style="width: 100%;"
                 type="button"   onclick="regist()" value="注册"/>

        <hr class="hr20">
        <div class="layui-form-item">
            <div class="layui-form-item" pane="">

                <input type="checkbox" lay-filter="filter"  checked="c"  id="memoryuser" lay-skin="primary" title="30天内自动登录" >

            </div>
        </div>
    </form>
</div>

<script>
    //该文档加载事件完成的功能是：退出shiro用户
    $(function () {
        $.ajax({
            type:"post",
            url:"/user/logout.do",
            dataType:"json",
            success:function (info) {
                /*alert(info.personName);
                alert(info.personPassword);*/
                if(info.personName!=""){
                    $("#a1").val(info.username);
                    $("#a2").val(info.password);
                    $("#memoryuser").prop("checked","checked");
                }else{
                    $("#memoryuser").prop("checked",false);
                }

            },
            error:function () {
                layer.msg('ajax请求失败', {icon: 2});
            }
        })
    })
    //进行登录处理
    function login() {
        //得到复选框的值

        var checkState = $("#memoryuser").prop("checked");
        var remember = "NO";
        if(checkState){
            remember = "YES";
        }
        $.ajax({
            type:"post",
            url:"/user/checkLogin.do?remember="+remember,
            dataType:"text",
            data:$("#form0").serialize(),
            success:function (info) {
                if(info=="success"){
                    //layer.msg("登录成功", {icon: 1});
                    window.location.href = "/user/success.do";
                }else{
                    layer.msg('账号或者密码错误！', {icon: 2});
                }
            },
            error:function () {
                layer.msg('ajax请求失败', {icon: 2});
            }
        })
    }

function regist(){

$("#one").modal("show");
}
    function save() {
        $.ajax({
            type:"post",
            url:"/user/regest.do",
            dataType:"text",
            data:$("#form1").serialize(),

            success:function (info) {
                if(info){
                    //layer.msg("登录成功", {icon: 1});
                   alert(info);
                    $("#one").modal("hide");

            }},
            error:function () {
                layer.msg('注册失败', {icon: 2});
            }
        })
    }
    function yanzheng(){
        var emaisl=$("#email").val();
        $.ajax({
            url:"/user/email.do",
            type:"post",
            data:{"email":emaisl},
            dataType:"text",
            success:function(data){
               if(data) alert("发送成功");
               else
                   alert("失败了");
            }
        })
    }
</script>


</body>
</html>
