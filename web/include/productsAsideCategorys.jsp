<%--显示鼠标移到竖状分类导航的分类时，显示该分类下的产品--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>

<script>
    <%--随机设置一个产品为高亮的推荐产品--%>
    $(function(){
        $("div.productsAsideCategorys div.row a").each(function(){
            var v = Math.round(Math.random() *6);
            if(v == 1)
                $(this).css("color","#87CEFA");
        });
    });
</script>

<%--第一层for循环用于循环所有的分类--%>
<c:forEach items="${categoryList}" var="category">
    <div class="productsAsideCategorys" cid="${category.id}">
        <%--第二层for循环，用于循环出每个分类下，按行分好的所有产品productsByRow集合--%>
        <c:forEach items="${category.productsByRow}" var="productList">
            <div class="row show1">
                <%--第三层for循环，用于循环取出每行的每一个产品--%>
                <c:forEach items="${productList}" var="product">
                    <%--判断产品副标题subTitle是否为空--%>
                    <c:if test="${!empty product.subTitle}">
                        <a href="foreproduct?pid=${product.id}">
                            <%--
                            把产品的subTitle信息里的第一个单词取出来作为产品名字显示。
                            每个产品的subTitle如下(以空格隔开多个副标题)：32吋电视机 8核智能 网络 全国联保 送货上门
                            --%>
                            <c:forEach items="${fn:split(product.subTitle, ' ')}" var="title" varStatus="st">
                                <c:if test="${st.index==0}">
                                    ${title}
                                </c:if>
                            </c:forEach>
                        </a>
                    </c:if>
                </c:forEach>
                <%--这是每行产品的下面的分割线--%>
                <div class="seperator"></div>
            </div>
        </c:forEach>
    </div>
</c:forEach>