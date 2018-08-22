<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<!--下方商品详情-->
<div class="productDetailDiv" style="display: block;">
    <div class="productDetailTopPart">
        <a class="productDetailTopPartSelectedLink selected" href="#nowhere">商品详情</a>
        <a class="productDetailTopReviewLink" href="#nowhere">累计评价 <span class="productDetailTopReviewLinkNumber">${product.reviewCount}</span> </a>
    </div>
    <div class="productParamterPart">
        <div class="productParamter">产品参数：</div>
        <div class="productParamterList">
            <c:forEach items="${propertyValueList}" var="pv">
                <span>${pv.property.name}:  ${fn:substring(pv.value, 0, 10)} </span>
            </c:forEach>
        </div>
        <div style="clear:both"></div>
    </div>
    <div class="productDetailImagesPart">
        <c:forEach items="${product.productDetailImages}" var="pdi">
            <img src="http://how2j.cn/tmall/img/productDetail/${pdi.id}.jpg">
        </c:forEach>
    </div>
</div>