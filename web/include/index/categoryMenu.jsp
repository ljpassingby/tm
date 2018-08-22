<%--显示左侧的竖状分类导航--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<div class="categoryMenu">
    <c:forEach items="${categoryList}" var="category">
        <div class="eachCategory" cid="${category.id}">
            <span class="glyphicon glyphicon-link"></span>
            <a href="forecategory?cid=${category.id}">${category.name}</a>
        </div>
    </c:forEach>
</div>