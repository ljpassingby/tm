<%--
进行了2次遍历
1. 遍历所有的分类，取出每个分类对象
2. 遍历分类对象的products集合，取出每个产品，然后显示该产品的标题，图片，价格等信息
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<div class="homepageCategoryProducts">
    <c:forEach items="${categoryList}" var="category">
        <div class="eachHomepageCategoryProducts">
            <%--分类名--%>
            <div class="left-mark"></div>
            <span class="categoryTitle">${category.name}</span>
            <br/>
            <%--该分类下的5个产品链接展示--%>
            <c:forEach items="${category.products}" var="product" varStatus="st">
                <c:if test="${st.count <= 5}">
                    <div class="productItem">
                        <a href="foreproduct?pid=${product.id}">
                            <img width="100px" src="http://how2j.cn/tmall/img/productSingle_middle/${product.firstProductImage.id}.jpg">
                        </a>
                        <a href="foreproduct?pid=${product.id}" class="productItemDescLink">
                            <span class="productItemDesc">[热销]${fn:substring(product.name, 0, 20)}</span>
                        </a>
                        <span class="productPrice">
                            <fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/>
                        </span>
                    </div>
                </c:if>
            </c:forEach>
            <div style="clear:both"></div>
        </div>
    </c:forEach>

    <img src="img/site/end.png" class="endpng" id="endpng">
</div>