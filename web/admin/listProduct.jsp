<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<html>
<head>
    <title>产品管理</title>
    <script>
        <%--用于判断“新增属性”在提交时是否出现空的情况，调用了adminHeader.jsp中的checkEmpty方法，注意传入的参数是id属性值--%>
        $(function () {
            $("#addForm").submit(function () {
                if(!checkEmpty("name", "产品名称"))
                    return false;
//                if (!checkEmpty("subTitle", "小标题"))
//                    return false;
                if (!checkNumber("orignalPrice", "原价格"))
                    return false;
                if (!checkNumber("promotePrice", "优惠价格"))
                    return false;
                if (!checkInt("stock", "库存"))
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
            <li><a href="admin_product_list?cid=${c.id}">${c.name}</a></li>
            <li class="active">产品管理</li>
        </ol>

        <div class="listDataTableDiv">
            <table class="table table-striped table-bordered table-hover  table-condensed">
                <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>图片</th>
                    <th>产品名称</th>
                    <th>产品小标题</th>
                    <th width="60px">原价格</th>
                    <th width="80px">优惠价格</th>
                    <th width="80px">库存数量</th>
                    <th width="80px">图片管理</th>
                    <th width="90px">设置属性值</th>
                    <%--<th width="80px">评价管理(应该有这么一项，实际演示中没加上，因为mysql没存评价数据)</th>--%>
                    <th width="42px">编辑</th>
                    <th width="42px">删除</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="p">
                        <tr>
                            <td>${p.id}</td>
                            <td><img width="40px" src="img/"></td>
                            <td>${p.name}</td>
                            <td>${p.subTitle}</td>
                            <td>${p.originalPrice}</td>
                            <td>${p.promotePrice}</td>
                            <td>${p.stock}</td>
                            <%--修改产品的图片--%>
                            <td>
                                <a href="admin_productImage_list?pid=${p.id}"><span class="glyphicon glyphicon-picture"></span></a>
                            </td>
                            <%--修改产品的具体属性值--%>
                            <td>
                                <a href="admin_product_editPropertyValue?id=${p.id}"><span class="glyphicon glyphicon-th-list"></span></a>
                            </td>
                            <%--编辑框，跳转的是自己的edit函数--%>
                            <td>
                                <a href="admin_product_edit?id=${p.id}"><span class="glyphicon glyphicon-edit"></span></a>
                            </td>
                                <%--删除框，跳转的是自己的delete函数--%>
                            <td>
                                <a deleteLink="true" href="admin_product_delete?id=${p.id}"><span class="glyphicon glyphicon-trash"></span></a>
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
            <div class="panel-heading">新增产品</div>
            <div class="panel-body">
                <%--加入一个新增的功能，通过表单提交，因此跳转的是自身的add函数--%>
                <form method="post" action="admin_product_add" id="addForm">
                    <table class="addTable">
                        <tr>
                            <td>产品名称</td>
                            <td><input type="text" class="form-control" id="name" name="name"></td>
                        </tr>          <tr>
                            <td>产品小标题</td>
                            <td><input type="text" class="form-control" id="subTitle" name="subTitle"></td>
                        </tr>          <tr>
                            <td>原价格</td>
                            <td><input type="text" class="form-control" id="originalPrice" name="originalPrice"></td>
                        </tr>          <tr>
                            <td>优惠价格</td>
                            <td><input type="text" class="form-control" id="promotePrice" name="promotePrice"></td>
                        </tr>          <tr>
                            <td>库存</td>
                            <td><input type="text" class="form-control" id="stock" name="stock"></td>
                        </tr>
                        <tr class="submitTR">
                            <td colspan="2" align="center">
                                <input type="hidden" name="cid" value="${c.id}">
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
