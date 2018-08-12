<%--置顶导航栏--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" isELIgnored="false" %>
<html>
<head></head>
<body>
    <nav class="top">
        <a href="${contextPath}">
            <span style="color: #C40000;margin: 0px" class="glyphicon glyphicon-home redColor"></span>
            天猫首页
        </a>
        <span>喵，欢迎来天猫</span>

        <%--若有用户登陆，则出现用户个人退出、返回主页的按键--%>
        <c:if test="${!empty user}">
            <a href="login.jsp">${user.name}</a>
            <a href="forelogout">退出</a>
        </c:if>

        <%--若无用户登陆，则出现“请登录”、“免费注册”按键--%>
        <c:if test="${empty user}">
            <a href="login.jsp">请登陆</a>
            <a href="register.jsp">免费注册</a>
        </c:if>

        <span class="pull-right">
            <a href="forebought">我的订单</a>
            <a href="forecart">
                <span style="color: #C40000;margin: 0px" class="glyphicon glyphicon-shopping-cart redColor"></span>
                购物车<strong>${cartTotalItemNumber}</strong>件
            </a>
        </span>
    </nav>
    <div style="clear: both;"></div>
</body>
</html>
