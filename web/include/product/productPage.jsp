<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<title>模仿天猫官网 ${product.name}</title>
<div class="categoryPictureInProductPageDiv">
    <img class="categoryPictureInProductPage" src="http://how2j.cn/tmall/img/category/${product.category.id}.jpg">
</div>

<div class="productPageDiv">
    <%@ include file="imgAndInfo.jsp" %>

    <%@ include file="productReview.jsp" %>

    <%@ include file="productDetail.jsp" %>
</div>