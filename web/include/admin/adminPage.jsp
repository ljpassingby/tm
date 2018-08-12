<%--这是分页的jsp，用与include嵌入--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8" isELIgnored="false" %>
<html>
<head>
    <script>
        <%--这个函数功能用于让class置为disabled的标签下的a标签变得不可点
            在该页面的具体表现为，当前页的页码不可点；在第一页时，上一页与最前页不可点；在最后一页时，下一页与最后一页不可点
        --%>
        $(function () {
            $("ul.pagination li.disabled a").click(function () {
                return false;
            });
        })
    </script>
</head>
<body>
    <nav>
        <ul class="pagination">
            <li <c:if test="${!page.hasPrevious}">class="disabled"</c:if>>
                <a href="?page.start=0${page.param}" aria-label="Previous">
                    <span aria-hidden="true">«</span>
                </a>
            </li>
            <li <c:if test="${!page.hasPrevious}">class="disabled"</c:if>>
                <a href="?page.start=${page.start - page.count}${page.param}" aria-label="Previous">
                    <span aria-hidden="true">‹</span>
                </a>
            </li>
            <%--循环产生每页的序号--%>
            <%--status.index从0开始，status.count从1开始--%>
            <c:forEach begin="0" end="${page.totalPage - 1}" varStatus="status">
                <%--这里的c:if功能用于当页数过多，比如100个时，这100个页数不会都出现，而只会一次性出现几个，
                    比如当前点到第10页时，那么当前页面能显示的页码为789    10      11 12 13
                    具体左边显示几个，右边显示几个只需调节20与-10即可，或者调节page.count，只要是page.count的倍数即可
                --%>
                <c:if test="${status.count * page.count - page.start <=20 && status.count * page.count - page.start >= -10}">
                    <%--这里的c:if判断用于让当前页的页码不可点击,只有其他页的页码才能被点击--%>
                    <li <c:if test="${status.index * page.count == page.start}">class="disabled" </c:if>
                    >
                            <%--这里这个current样式是自定义的，用于让a标签加粗变黑--%>
                            <%--这里加上c:if判断用于只让当前页的页码变黑，其他页码为默认色--%>
                        <a href="?page.start=${status.index * page.count}${page.param}"
                           <c:if test="${status.index * page.count == page.start}">class="current"</c:if>
                        >
                                ${status.index + 1}
                        </a>
                    </li>
                </c:if>
            </c:forEach>

            <li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
                <a href="?page.start=${page.start + page.count}${page.param}" aria-label="Next">
                    <span aria-hidden="true">›</span>
                </a>
            </li>
            <li <c:if test="${!page.hasNext}">class="disabled"</c:if>>
                <a href="?page.start=${page.last}${page.param}" aria-label="Next">
                    <span aria-hidden="true">»</span>
                </a>
            </li>
        </ul>
    </nav>
</body>
</html>
