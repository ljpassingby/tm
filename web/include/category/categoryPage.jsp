<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<title>模仿天猫官网-${category.name}</title>

<div id="category">
    <div class="categoryPageDiv">
        <img src="http://how2j.cn/tmall/img/category/${category.id}.jpg">
        <%@include file="sortBar.jsp"%>
        <%@include file="productsByCategory.jsp"%>
    </div>
</div>