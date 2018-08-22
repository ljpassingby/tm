<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<div id="searchResult">
<div class="searchResultDiv">
    <div class="searchProducts">
        <c:forEach items="${productList}" var="product" varStatus="st">
            <div price="${product.promotePrice}" class="productUnit">
                <div class="productUnitFrame">
                    <a href="foreproduct?pid=${product.id}"><img src="http://how2j.cn/tmall/img/productSingle_middle/${product.firstProductImage.id}.jpg" class="productImage"></a>

                    <span class="productPrice">¥
                        <fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/>
                    </span>
                    <a href="foreproduct?pid=${product.id}" class="productLink">
                            ${fn:substring(product.name, 0, 50)}
                    </a>
                    <a href="foreproduct?pid=${product.id}" class="tmallLink">天猫专卖</a>

                    <div class="show1 productInfo">
                        <span class="monthDeal">月成交
                            <span class="productDealNumber">${product.saleCount}笔</span>
                        </span>
                        <span class="productReview">评价
                            <span class="productReviewNumber">${product.reviewCount}</span>
                        </span>
                        <span class="wangwang">
                            <a href="#nowhere" class="wangwanglink"><img src="img/site/wangwang.png"></a>
                        </span>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty productList}">
            <div class="noMatch">没有满足条件的产品</div>
        </c:if>
        <div style="clear:both"></div>
    </div>
</div>
</div>