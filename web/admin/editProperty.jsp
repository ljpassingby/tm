<%--编辑category名字与图片的页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<html>
<head>
    <title>编辑属性</title>
</head>
<body>
    <div class="workingArea">
        <%--这个是那个网页点击进度栏--%>
        <ol class="breadcrumb">
            <li><a href="admin_category_list">所有分类</a></li>
            <li><a href="admin_property_list?cid=${c.id}">${c.name}</a></li>
            <li class="active">编辑属性</li>
        </ol>

        <%--这里是编辑内容的窗口--%>
        <div class="panel panel-warning addDiv">
            <div class="panel-heading">编辑属性</div>
            <div class="panel-body">
                <%--编辑一个更新的功能，通过表单提交，因此跳转的是自身的update函数--%>
                <form method="post" action="admin_property_update" id="editForm">
                    <table class="editTable">
                        <tr>
                            <td>属性名称</td>
                            <td>
                                <input type="text" class="form-control" id="name" name="name" value="${p.name}">
                                <input type="hidden" name="cid" value="${c.id}">
                                <input type="hidden" name="id" value="${p.id}">
                            </td>
                        </tr>
                        <tr class="submitTR">
                            <td colspan="2" align="center">
                                <button type="submit" class="btn btn-success">提 交</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
