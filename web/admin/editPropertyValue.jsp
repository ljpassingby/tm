<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>
<html>
<head>
    <title>编辑产品属性值</title>
    <script>
        $(function () {
            $("input.pvValue").keyup(function () {
                var value = $(this).val();
                var pvid = $(this).attr("pvid");
                var page = "admin_product_updatePropertyValue";
                var parentSpan = $(this).parent("span");
                parentSpan.css("border", "1px solid yellow");
                $.post(
                    page,
                    {"value":value, "pvid":pvid},
                    function (result) {
                        if ("success" == result){
                            parentSpan.css("border", "1px solid green");
                        }else {
                            parentSpan.css("border", "1px solid red");
                        }
                    }
                );
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
            <li class="active">编辑产品属性值</li>
        </ol>
        <div class="editPVDiv">
            <c:forEach items="${propertyValues}" var="pv">
                <div class="eachPV">
                    <span class="pvName">${pv.property.name}</span>
                    <span class="pvValue">
                        <input class="pvValue" type="text" pvid="${pv.id}" value="${pv.value}">
                    </span>
                </div>
            </c:forEach>
            <div style="clear: both;"></div>
        </div>
    </div>

    <%@ include file="../include/admin/adminFooter.jsp"%>
</body>
</html>