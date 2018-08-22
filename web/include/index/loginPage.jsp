<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<script>
    $(function () {
//        输入错误提示操作,后端判断输入用户名密码错误时返送给前端错误信息
        <c:if test="${!empty msg}">
            $("span.errorMessage").html("${msg}");
            $("div.loginErrorMessageDiv").show();
        </c:if>

       $("form.loginForm").submit(function () {
           if (0 == $("#name").val().length || 0 == $("#password").val().length){
               $("span.errorMessage").html("请输入账号及密码");
               $("div.loginErrorMessageDiv").show();
               return false;
           }
           return true;
       });
//      输入账号密码时，错误提示框隐藏
       $("form.loginForm input").keyup(function () {
           $("div.loginErrorMessageDiv").hide();
       });

        var left = window.innerWidth/2+162;
        $("div.loginSmallDiv").css("left",left);
    });
</script>

<div id="loginDiv">
    <div class="simpleLogo">
        <img src="img/site/simpleLogo.png">
    </div>
    <img src="img/site/loginBackground.png" class="loginBackgroundImg" id="loginBackgroundImg">
    <form class="loginForm" method="post" action="forelogin">
        <div class="loginSmallDiv" id="loginSmallDiv">
            <%--输入错误提示区域--%>
            <div class="loginErrorMessageDiv">
                <div class="alert alert-danger" >
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                    <span class="errorMessage"></span>
                </div>
            </div>

            <div class="login_acount_text">账户登录</div>
            <div class="loginInput ">
                <span class="loginInputIcon ">
                    <span class=" glyphicon glyphicon-user"></span>
                </span>
                <input type="text" placeholder="手机/会员名/邮箱" name="name" id="name">
            </div>
            <div class="loginInput ">
                <span class="loginInputIcon ">
                    <span class=" glyphicon glyphicon-lock"></span>
                </span>
                <input type="password" placeholder="密码" name="password" id="password">
            </div>
            <div>
                <a href="notImplementLink" class="notImplementLink">忘记登录密码</a>
                <a class="pull-right" href="register.jsp">免费注册</a>
            </div>
            <div style="margin-top:20px">
                <button type="submit" class="btn btn-block redButton">登录</button>
            </div>
        </div>
    </form>
</div>