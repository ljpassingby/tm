<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<html>
<head>
    <title>属性管理</title>
    <script>
        <%--用于判断“新增属性”在提交时是否出现空的情况，调用了adminHeader.jsp中的checkEmpty方法，注意传入的参数是id属性值--%>
        $(function () {
            $("#addForm").submit(function () {
                if(!checkEmpty("name", "属性名称"))
                    return false;
                return true;
            });
        })
    </script>
</head>
<body>
    <div class="workingArea">
        <%--这个是那个网页点击进度栏--%>
        <ol class="breadcrumb">
            <li><a href="admin_category_list">所有分类</a></li>
            <li><a href="admin_property_list?cid=${c.id}">${c.name}</a></li>
            <li class="active">属性管理</li>
        </ol>

        <div class="listDataTableDiv">
            <table class="table table-striped table-bordered table-hover  table-condensed">
                <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>属性名称</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${theps}" var="p">
                        <tr>
                            <td>${p.id}</td>
                            <td>${p.name}</td>
                            <%--编辑框，跳转的是自己的edit函数--%>
                            <td>
                                <a href="admin_property_edit?id=${p.id}"><span class="glyphicon glyphicon-edit"></span></a>
                            </td>
                                <%--删除框，跳转的是自己的delete函数--%>
                            <td>
                                <a deleteLink="true" href="admin_property_delete?id=${p.id}"><span class="glyphicon glyphicon-trash"></span></a>
                            </td>
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

        <div class="panel panel-warning addDiv">
            <div class="panel-heading">新增属性</div>
            <div class="panel-body">
                <%--加入一个新增的功能，通过表单提交，因此跳转的是自身的add函数--%>
                <form method="post" action="admin_property_add" id="addForm">
                    <table class="addTable">
                        <tr>
                            <td>属性名称</td>
                            <td>
                                <input type="text" class="form-control" id="name" name="name">
                                <input type="hidden" name="cid" value="${c.id}">
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

    <%--把公共页脚包含进来--%>
    <%@ include file="../include/admin/adminFooter.jsp"%>
</body>
</html>
