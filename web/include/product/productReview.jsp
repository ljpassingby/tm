<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<!--下方累计评价内容-->
<div class="productReviewDiv" style="display: block;">
    <div class="productReviewTopPart">
        <a class="productReviewTopPartSelectedLink" href="#nowhere">商品详情</a>
        <a class="selected" href="#nowhere">累计评价 <span class="productReviewTopReviewLinkNumber">${product.reviewCount}</span> </a>
    </div>
    <!--评论内容-->
    <div class="productReviewContentPart">
        <c:forEach items="${reviewList}" var="review">
            <div class="productReviewItem">
                <div class="productReviewItemDesc">
                    <div class="productReviewItemContent">${review.content}</div>
                    <div class="productReviewItemDate">
                        <fmt:formatDate value="${review.createDate}" pattern="yyyy-MM-dd"/>
                    </div>
                </div>
                <div class="productReviewItemUserInfo">
                    ${review.user.anonymousName}<span class="userInfoGrayPart">（匿名）</span>
                </div>
                <div style="clear:both"></div>
            </div>
        </c:forEach>
    </div>
</div>
