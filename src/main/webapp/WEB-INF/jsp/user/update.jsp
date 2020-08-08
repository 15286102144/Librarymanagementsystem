<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/8/3 0003
  Time: 18:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://shiro.apache.org/tags"  prefix="shiro"%>
<html>
<head>
    <title>用户修改</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="/js/jquery-3.1.1.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
</head>
<body>
<form action="/user/updateUser.do" name="form1" method="post">
    <table width="100%" border="1" align="center" cellpadding="3" cellspacing="1"  style="border-collapse:collapse" bgcolor="#F2FDFF">
        <tr bgcolor="#E7E7E7">
            <td height="30" colspan="2" background="images/table_header.gif">修改用户密码<input type="hidden" name="id" value="${xueshengxinxi.id}" /></td>
        </tr>
       <input name='userid' type='hidden' id='xuehao' value='${user.userid}' onblur='hsgcheck()' class="form-control" />
        <tr ><td width="200">用户名：</td><td><input name='username' type='text' id='mima' value='${user.username}' onblur='checkform()' class="form-control" />&nbsp;*<label id='clabelmima' style='margin-top:16px;' /></td></tr>
        <tr ><td width="200">密码：</td><td><input name='password' type='text' id='xingming' value='' onblur='checkform()' class="form-control" />&nbsp;*<label id='clabelxingming' style='margin-top:16px;' /></td></tr>
        <tr ><td width="200">性别：</td><td><select name='sex' id='xingbie' class="form-control"><option value="${user.sex}">男</option><option value="${user.sex}">女</option></select></td></tr>
        <tr ><td width="200">电话：</td><td><input name='tel' type='text' id='dia' value='${user.tel}' onblur='checkform()' class="form-control" />&nbsp;*<label id='clabea' style='margin-top:16px;' /></td></tr>
        <tr ><td width="200">权限：</td><td><input name='role' type='text' id='quanx' value='${user.role}' onblur='checkform()' class="form-control"  readonly  unselectable="on" />&nbsp;*<label id='clabeldianhua' style='margin-top:16px;' /></td></tr>
      </td><td><input name='total' type='hidden' id='jiguan' value='${user.total}' onblur='' class="form-control" />
        <tr align='center'   height="22">
            <td width="25%" height="45"  align="right">&nbsp;</td>
            <td width="75%"  align="left">
                <input type="submit" name="querenzhuce" id="querenzhuce" value="提交" onClick="return checkform();" class="btn btn-info btn-small" />
            </td>
        </tr>

    </table>
</form>
</body>
</html>
