<%--编辑category名字与图片的页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<html>
<head>
    <title>编辑产品</title>
</head>
<body>
    <div class="workingArea">
        <%--这个是那个网页点击进度栏--%>
        <ol class="breadcrumb">
            <li><a href="admin_category_list">所有分类</a></li>
            <li><a href="admin_product_list?cid=${c.id}">${c.name}</a></li>
            <li class="active">编辑产品</li>
        </ol>

        <%--这里是编辑内容的窗口--%>
        <div class="panel panel-warning addDiv">
            <div class="panel-heading">编辑产品</div>
            <div class="panel-body">
                <%--编辑一个更新的功能，通过表单提交，因此跳转的是自身的update函数--%>
                <form method="post" action="admin_product_update" id="editForm">
                    <table class="editTable">
                        <tr>
                            <td>产品名称</td>
                            <td><input type="text" class="form-control" id="name" name="name" value="${p.name}"></td>
                        </tr>
                        <tr>
                            <td>产品小标题</td>
                            <td><input type="text" class="form-control" id="subTitle" name="subTitle" value="${p.subTitle}"></td>
                        </tr>
                        <tr>
                            <td>原价格</td>
                            <td><input type="text" class="form-control" id="originalPrice" name="originalPrice" value="${p.originalPrice}"></td>
                        </tr>
                        <tr>
                            <td>优惠价格</td>
                            <td><input type="text" class="form-control" id="promotePrice" name="promotePrice" value="${p.promotePrice}"></td>
                        </tr>
                        <tr>
                            <td>库存</td>
                            <td><input type="text" class="form-control" id="stock" name="stock" value="${p.stock}"></td>
                        </tr>
                        <tr class="submitTR">
                            <td colspan="2" align="center">
                                <input type="hidden" name="cid" value="${c.id}">
                                <input type="hidden" name="id" value="${p.id}">
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
