<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>
<html>
<head>
    <title>分类管理</title>
    <script>
        <%--用于判断“新增分类”在提交时是否出现空的情况，调用了adminHeader.jsp中的checkEmpty方法，注意传入的参数是id属性值
        若是空返回false--%>
        $(function () {
            $("#addForm").submit(function () {
                if(!checkEmpty("name", "分类名称"))
                    return false;
                if(!checkEmpty("categoryPic", "分类图片"))
                    return false;
                return true;
            });
        })
    </script>
</head>
<body>
    <div class="workingArea">
        <h1 class="label label-info">分类管理</h1>
        <br>
        <br>

        <div class="listDataTableDiv">
            <table class="table table-striped table-bordered table-hover  table-condensed">
                <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>图片</th>
                    <th>分类名称</th>
                    <th>属性管理</th>
                    <th>产品管理</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${thecs}" var="c">
                        <tr>
                            <td>${c.id}</td>
                            <td><img src="img/category/${c.id}.jpg" height="40px"></td>
                            <td>${c.name}</td>
                            <td>
                                <a href="admin_property_list?cid=${c.id}"><span class="glyphicon glyphicon-th-list"></span></a>
                            </td>
                            <td>
                                <a href="admin_product_list?cid=${c.id}"><span class="glyphicon glyphicon-shopping-cart"></span></a>
                            </td>
                            <%--编辑框，跳转的是自己的edit函数--%>
                            <td>
                                <a href="admin_category_edit?id=${c.id}"><span class="glyphicon glyphicon-edit"></span></a>
                            </td>
                            <%--删除框，跳转的是自己的delete函数--%>
                            <td>
                                <a deleteLink="true" href="admin_category_delete?id=${c.id}"><span class="glyphicon glyphicon-trash"></span></a>
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
            <div class="panel-heading">新增分类</div>
            <div class="panel-body">
                <%--加入一个新增category的功能，通过表单提交，因此跳转的是自身的add函数--%>
                <%--enctype属性的意思是告诉服务器表单提交的是通过哪种方式进行编码，multipart/form-data表示提交的数据二进制文件--%>
                <form method="post" action="admin_category_add" id="addForm" enctype="multipart/form-data">
                    <table class="addTable">
                        <tr>
                            <td>分类名称</td>
                            <td><input type="text" class="form-control" id="name" name="name"></td>
                        </tr>
                        <tr>
                            <td>分类图片</td>
                            <%--这个accept用处是接收image的所有类型，若想指定只有某些可以，可以如image/jpeg等--%>
                            <td><input type="file" id="categoryPic" name="filepath" accept="image/*"></td>
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
