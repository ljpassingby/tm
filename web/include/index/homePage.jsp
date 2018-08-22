<%--首页业务页面--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" isELIgnored="false" %>
<html>
<head>
    <title>模仿天猫官网</title>
</head>
<body>
    <div class="homepageDiv">
        <%--
        1. categoryAndcarousel.jsp
            分类和轮播
            1.1 categoryMenu.jsp
                竖状分类菜单
            1.2 productsAsideCategorys.jsp
                竖状分类菜单右侧的推荐产品列表
            1.3 carousel.jsp
                轮播
        2. homepageCategoryProducts.jsp
            主题的17种分类以及每种分类对应的5个产品
        --%>
        <%@ include file="categoryAndcarousel.jsp"%>
        <%@ include file="homepageCategoryProducts.jsp"%>
    </div>
</body>
</html>
