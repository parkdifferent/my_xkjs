<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    request.setAttribute("base",request.getContextPath());
%>

<html>
<head>
    <title>管理员登录</title>
</head>

<style>
    *{margin:0px;padding:0px;}
    ul{list-style:none;}
    li{margin-bottom:14px;margin-top:2px;}
    body{background:#015f9b url(${base}/resources/style/system/manage/blue/images/bg-1.jpg) no-repeat top center;}
    .main{width:467px;height:414px;margin:30px auto;background:url(${base}/resources/style/system/manage/blue/images/login.jpg) no-repeat;margin-top:140px;}
    .Logo_ul{margin-top:40px;margin-left:257px;}
    .input{border:0px;width:133px;background:none;font-size:14px;letter-spacing:2px;}
    .copyright{line-height:25px;color:#fff;margin-top:20px;text-align:right;padding-right:20px;}
    .js{color:#999;text-align:center;line-height:30px;margin-top:40px;}
    a:visited,a:link{color:#999;}
    a:hover{color:red;}
</style>

<script>


    //var closestr=0;
    function SetFocus() {
        if(document.Login.UserName.value == '')
            document.Login.UserName.focus();
        else
            document.Login.UserName.select();
    }
    function CheckForm() {
        if(document.Login.UserName.value == '') {
            alert('请输入用户名！');
            document.Login.UserName.focus();
            return false;
        }
        if(document.Login.password.value == '') {
            alert('请输入密码！');
            document.Login.password.focus();
            return false;
        }

        if(document.Login.vcode.value == '') {
            alert('请输入验证码！');
            document.Login.vcode.focus();
            return false;
        }
    }
</script>

<body>


<div class="main">
    <form name='Login' action='Admin_Login.php' method='post'>
        <input type='hidden' name='Action' value='Login'>
        <div style="text-align:right;padding-top:35px;padding-right:20px;"><img src="${base}/resources/style/system/manage/blue/images/2014.png" /></div>

        <ul class="Logo_ul">
            <li style="margin-top:2px;"><input name='UserName' type='text' id='UserName' class="input"  onFocus='this.select();'> </li>
            <li style="margin-bottom:10px;"><input name='password'  type='password' maxLength='20' class="input"  onFocus='this.select();'></li>
            <li style="margin-top:-5px;"> <input name='vcode'  type='text' maxLength='4' style='width:60px;' class="input" onFocus='this.select();' value=''><img src="${base}/system/verifyCode.do" border="0" style="margin-left:15px; margin-top:5px;cursor:pointer; padding:0px 5px 5px 5px;background:#eee;" onClick="this.src='${base}/system/verifyCode.do?t='+Math.random()" title="看不清楚换一个" /></li></ul>

        <div style="padding-top:0px;padding-right:70px;text-align:right;"><input type='image' name='Submit' src='${base}/resources/style/system/manage/blue/images/btn1.png' style="width:73px;height:29px;"/> &nbsp;  &nbsp;
            <input type='image' name='Submit' src='${base}/resources/style/system/manage/blue/images/btn2.png' style="width:60px;height:25px;/*width:73px;height:29px;*/"/>

        </div>

        <div class="copyright">版权所有：<a href='http://www.fsgjjj.com' target="_blank" style="color:#fff;">分部政工网</a></div>

    </form>
    <div class="js">技术支持：<a href='http://www.xvkee.com' target="_blank">讯克网络</a> &nbsp;&nbsp; 系统版本 讯克V4.0</div>
</div>



</body>
</html>
