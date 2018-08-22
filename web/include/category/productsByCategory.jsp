<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<%--这个param是定义好的，等价与request.getParameter--%>
<c:if test="${empty param.categorycount}">
    <c:set var="categorycount" scope="page" value="100"/>
</c:if>

<c:if test="${!empty param.categorycount}">
    <c:set var="categorycount" scope="page" value="${param.categorycount}"/>
</c:if>

<div class="categoryProducts">
    <c:forEach items="${category.products}" var="product" varStatus="st">
        <c:if test="${st.count < categorycount}">
            <div price="${product.promotePrice}" class="productUnit">
                <div class="productUnitFrame">
                    <a href="foreproduct?pid=${product.id}"><img src="http://how2j.cn/tmall/img/productSingle_middle/${product.firstProductImage.id}.jpg" class="productImage"></a>

                    <span class="productPrice">
                    ¥<fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/>
                    </span>
                    <a href="foreproduct?pid=${product.id}" class="productLink">
                            ${fn:substring(product.name, 0, 50)}
                    </a>
                    <a href="foreproduct?pid=${product.id}" class="tmallLink">天猫专卖</a>

                    <div class="show1 productInfo">
                    <span class="monthDeal">
                        月成交 <span class="productDealNumber">${product.saleCount}笔</span>
                    </span>
                        <span class="productReview">
                            评价 <span class="productReviewNumber">${product.reviewCount}</span>
                    </span>
                        <span class="wangwang">
                            <a href="#nowhere" class="wangwanglink"><img src="img/site/wangwang.png"></a>
                    </span>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
    <div style="clear:both"></div>
</div>