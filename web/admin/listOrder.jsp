<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" import="java.util.*" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<html>
<head>
    <title>订单管理</title>
    <script>
        $(function () {
            $("button.orderPageCheckOrderItems").click(function () {
                var oid = $(this).attr("oid");
                $("tr.orderPageOrderItemTR[oid=" + oid + "]").toggle();
            });
        });
    </script>
</head>
<body>
    <div class="workingArea">
        <h1 class="label label-info">订单管理</h1>
        <br>
        <br>

        <div class="listDataTableDiv">
            <table class="table table-striped table-bordered table-hover table-condensed">
                <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>状态</th>
                    <th>金额</th>
                    <th width="100px">商品数量</th>
                    <th width="100px">买家名称</th>
                    <th>创建时间</th>
                    <th>支付时间</th>
                    <th>发货时间</th>
                    <th>确认收货时间</th>
                    <th width="120px">操作</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orders}" var="order">
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.statusDesc}</td>
                            <td>￥<fmt:formatNumber type="number" value="${order.total}"/></td>
                            <td align="center">${order.totalNumber}</td>
                            <td align="center">${order.receiver}</td>
                            <td><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${order.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${order.deliveryDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${order.confirmDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>
                                <button oid="${order.id}" class="orderPageCheckOrderItems btn btn-primary btn-xs">查看详情</button>
                                <c:if test="${order.status == 'waitDelivery'}">
                                    <a href="admin_order_delivery?id=${order.id}">
                                        <button class="btn btn-primary btn-xs">发货</button>
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                        <%--隐藏的订单相关信息，通过点击“查看详情”按钮使其出现或消失--%>
                         <tr class="orderPageOrderItemTR" oid=${order.id}>
                            <td colspan="10" align="center">
                                <div class="orderPageOrderItem">
                                    <table width="800px" align="center">
                                        <c:forEach items="${order.orderItems}" var="orderitem">
                                            <tr>
                                                <td align="left" width="40px" height="40px">
                                                    <img src="img/producSingle/${orderitem.product.firstProductImage.id}.jpg">
                                                </td>
                                                <td>
                                                    <a href="foreProduct?pid=${orderitem.product.id}">
                                                        <span>${orderitem.product.name}</span>
                                                    </a>
                                                </td>
                                                <td align="right">
                                                    <span class="text-muted">${orderitem.number}个</span>
                                                </td>
                                                <td align="right">
                                                    <span class="text-muted">单价：￥${orderitem.product.promotePrice}</span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </td>
                         </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <%--include包含一个分页的公共jsp页面--%>
        <%--这个pageDiv的类别用与居中--%>
        <div class="pageDiv">
            <%@ include file="../include/admin/adminPage.jsp"%>
        </div>
    </div>

    <%--把公共页脚包含进来--%>
    <%@ include file="../include/admin/adminFooter.jsp"%>
</body>
</html>
