<%--置顶导航栏--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" isELIgnored="false" %>
<html>
<head></head>
<body>
    <div>
        <a href="${contextPath}">
            <img class="logo" src="img/site/logo.gif" id="logo">
        </a>
        <form action="foresearch" method="post">
            <div class="searchDiv">
                <input type="text" placeholder="时尚男鞋  太阳镜" name="keyword" value="${param.keyword}" />
                <button type="submit" class="searchButton">搜索</button>
                <div class="searchBelow">
                    <%--迭代生成4个推荐产品分类，至于哪4个，由下面的st.count决定--%>
                    <%--最终效果如  平衡车|扫地机器人|原汁机|冰箱  --%>
                    <c:forEach items="${categoryList}" var="category" varStatus="st">
                        <c:if test="${st.count >= 5 and st.count <= 8}">
                            <span>
                                <a href="forecategory?cid=${category.id}">
                                    ${category.name}
                                </a>
                                <%--目的是让第四个产品的右边不出现|--%>
                                <c:if test="${st.count != 8}">
                                    <span>|</span>
                                </c:if>
                            </span>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
