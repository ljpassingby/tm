<%--编辑category名字与图片的页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<html>
<head>
    <title>编辑分类</title>
</head>
<body>
    <div class="workingArea">
        <%--这个是那个网页点击进度栏--%>
        <ol class="breadcrumb">
            <li><a href="admin_category_list">所有分类</a></li>
            <li class="active">编辑分类</li>
        </ol>

        <%--这里是编辑内容的窗口--%>
        <div class="panel panel-warning addDiv">
            <div class="panel-heading">编辑分类</div>
            <div class="panel-body">
                <%--编辑一个更新category的功能，通过表单提交，因此跳转的是自身的update函数--%>
                <%--enctype属性的意思是告诉服务器表单提交的是通过哪种方式进行编码，multipart/form-data表示提交的数据二进制文件--%>
                <form method="post" action="admin_category_update" id="editForm" enctype="multipart/form-data">
                    <table class="editTable">
                        <tr>
                            <td>分类名称</td>
                            <td>
                                <input type="text" class="form-control" id="name" name="name" value="${c.name}">
                                <input type="hidden" name="id" value="${c.id}">
                            </td>
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
</body>
</html>
