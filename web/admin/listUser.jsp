<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<html>
<head>
    <title>用户管理</title>
</head>
<body>
    <div class="workingArea">
        <h1 class="label label-info">用户管理</h1>
        <br>
        <br>

        <div class="listDataTableDiv">
            <table class="table table-striped table-bordered table-hover table-condensed">
                <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>用户名称</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="user">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.name}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <%--include包含一个分页的公共jsp页面--%>
        <%--这个pageDiv的类别用与居中--%>
        <div class="pageDiv">
            <%@ include file="../include/admin/adminPage.jsp"%>
        </div>
    </div>

    <%--把公共页脚包含进来--%>
    <%@ include file="../include/admin/adminFooter.jsp"%>
</body>
</html>
