<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>
<html>
<head>
    <title>产品图片管理</title>
    <script>
        <%--用于判断在提交时是否提交了空文件，调用了adminHeader.jsp中的checkEmpty方法，注意传入的参数是id属性值
        若判断为不为空，则返回true--%>
        $(function () {
            $(".addFormSingle").submit(function () {
                if(checkEmpty("filepathSingle","图片文件")){
                    $("#filepathSingle").val("");
                    return true;
                }
                return false;
            });
            $(".addFormDetail").submit(function () {
                if(checkEmpty("filepathDetail","图片文件"))
                    return true;
                return false;
            });
        });
    </script>
</head>
<body>
    <div class="workingArea">
        <%--这个是那个网页点击进度栏--%>
        <ol class="breadcrumb">
            <li><a href="admin_category_list">所有分类</a></li>
            <li><a href="admin_product_list?cid=${product.category.id}">${product.category.name}</a></li>
            <li class="active">${product.name}</li>
            <li class="active">产品图片管理</li>
        </ol>

        <table class="addPictureTable" align="center">
            <tr>
                <%--single图片区--%>
                <td class="addPictureTableTD">
                    <%--加入图片功能区--%>
                    <div class="panel panel-warning addPictureDiv">
                        <div class="panel-heading">新增产品<b class="text-primary"> 单个 </b>图片</div>
                        <div class="panel-body">
                            <form method="post" action="admin_productImage_add" class="addFormSingle" enctype="multipart/form-data">
                                <table class="addTable">
                                    <tr>
                                        <td>请选择本地图片 尺寸400X400 为佳</td>
                                    </tr>
                                    <tr align="center">
                                        <td><input type="file" id="filepathSingle" name="filepath" accept="image/*"></td>
                                    </tr>
                                    <tr class="submitTR">
                                        <td align="center">
                                            <input type="hidden" name="type" value="type_single">
                                            <input type="hidden" name="pid" value="${product.id}">
                                            <button type="submit" class="btn btn-success">提 交</button>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>
                    <%--展示图片功能区--%>
                    <table class="table table-striped table-bordered table-hover table-condensed">
                        <thead>
                            <tr class="success">
                                <th>ID</th>
                                <th>产品单个图片缩略图</th>
                                <th>删除</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${singles}" var="single">
                                <tr>
                                    <td>${single.id}</td>
                                    <td>
                                        <a title="点击查看原图" href="img/productSingle/${single.id}.jpg"><img height="50px" src="img/productSingle/${single.id}.jpg"></a>
                                    </td>
                                    <td>
                                        <a deleteLink="true" href="admin_productImage_delete?id=${single.id}"><span class="glyphicon glyphicon-trash"></span></a>
                                    </td>
                                </tr>
                         </c:forEach>
                        </tbody>
                    </table>
                </td>
                <%--detail图片区--%>
                <td class="addPictureTableTD">
                    <%--加入图片功能区--%>
                    <div class="panel panel-warning addPictureDiv">
                        <div class="panel-heading">新增产品<b class="text-primary"> 详情 </b>图片</div>
                        <div class="panel-body">
                            <form method="post" action="admin_productImage_add" class="addFormDetail" enctype="multipart/form-data">
                                <table class="addTable">
                                    <tr>
                                        <td>请选择本地图片 宽度790 为佳</td>
                                    </tr>
                                    <tr align="center">
                                        <td><input type="file" id="filepathDetail" name="filepath" accept="image/*"></td>
                                    </tr>
                                    <tr class="submitTR">
                                        <td align="center">
                                            <input type="hidden" name="type" value="type_detail">
                                            <input type="hidden" name="pid" value="${product.id}">
                                            <button type="submit" class="btn btn-success">提 交</button>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>
                    <%--展示图片功能区--%>
                    <table class="table table-striped table-bordered table-hover table-condensed">
                        <thead>
                            <tr class="success">
                                <th>ID</th>
                                <th>产品详细图片缩略图</th>
                                <th>删除</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${details}" var="detail">
                                <tr>
                                    <td>${detail.id}</td>
                                    <td>
                                        <a title="点击查看原图" href="img/productDetail/${detail.id}.jpg"><img height="50px" src="img/productDetail/${detail.id}.jpg"></a>
                                    </td>
                                    <td>
                                        <a deleteLink="true" href="admin_productImage_delete?id=${detail.id}"><span class="glyphicon glyphicon-trash"></span></a>
                                    </td>
                                </tr>
                         </c:forEach>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <%@ include file="../include/admin/adminFooter.jsp"%>
</body>
</html>