<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<script>
    var deleteOrder = false;
    var deleteOrderid = 0;
    $(function () {
        //切换所有订单、待付款、待发货、待收货、待评价页面
        $("div.orderType a[orderStatus]").click(function () {
            var orderstatus = $(this).attr("orderstatus");
            if("all" == orderstatus){
                $("div.orderListItem table[orderStatus]").show();
            }else{
                $("div.orderListItem table[orderStatus]").hide();
                $("div.orderListItem table[orderstatus="+orderstatus+"]").show();
            }
            $("div.orderType div").removeClass("selectedOrderType");
            $(this).parent("div").addClass("selectedOrderType");
        });
        //点击删除图表弹出删除模态窗口
        $("a.deleteOrderLink").click(function(){
            deleteOrderid = $(this).attr("oid");
            deleteOrder = false;
            $("#deleteConfirmModal").modal("show");
        });
        //点击模态窗口的确认删除按键后，模态窗口消失
        $("button.deleteConfirmButton").click(function(){
            deleteOrder = true;
            $("#deleteConfirmModal").modal('hide');
        });
        //模态窗口消失后触发事件，前提基于deleteOrder被置位true
        $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
           if (deleteOrder){
               var page = "foredeleteOrder";
               $.post(
                   page,
                   {"oid" : deleteOrderid},
                   function (result) {
                       if ("success" == result){
                           $("table.orderListItemTable[oid=" + deleteOrderid + "]").remove();
                       }else
                           location.href = "login.jsp";
                   }
               );
           }
        });
    });
</script>

<div class="boughtDiv">
    <!--订单栏标题-->
    <div class="orderType">
        <!--class="selectedOrderType"表示哪个订单类型被用户选中-->
        <div class="selectedOrderType"><a href="#nowhere" orderstatus="all">所有订单</a></div>
        <div><a href="#nowhere" orderstatus="waitPay">待付款</a></div>
        <div><a href="#nowhere" orderstatus="waitDelivery">待发货</a></div>
        <div><a href="#nowhere" orderstatus="waitConfirm">待收货</a></div>
        <div><a class="noRightborder" href="#nowhere" orderstatus="waitReview">待评价</a></div>
        <!--表示标题处最右边空的部分-->
        <div class="orderTypeLastOne"><a class="noRightborder"> </a></div>
    </div>
    <div style="clear: both;"></div>
    <!--订单内容标题-->
    <div class="orderListTitle">
        <table class="orderListTitleTable">
            <tbody>
            <tr>
                <td>宝贝</td>
                <td width="100px">单价</td>
                <td width="100px">数量</td>
                <td width="120px">实付款</td>
                <td width="100px">交易操作</td>
            </tr>
            </tbody>
        </table>
    </div>
    <!--产品列表部分-->
    <div class="orderListItem">
        <%--遍历对应用户下的所有订单--%>
        <c:forEach items="${orderList}" var="order">
            <table oid="${order.id}"  orderstatus="${order.status}" class="orderListItemTable">
                <tr class="orderListItemFirstTR">
                    <td colspan="2">
                        <b><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b>
                        <span>订单号: ${order.orderCode}</span>
                    </td>
                    <td colspan="2"><img width="13px" src="img/site/orderItemTmall.png">天猫商场</td>
                    <td colspan="1">
                        <a href="#nowhere" class="wangwanglink">
                            <div class="orderItemWangWangGif"></div>
                        </a>
                    </td>
                    <td class="orderItemDeleteTD">
                        <a href="#nowhere" oid="${order.id}" class="deleteOrderLink">
                            <span class="orderListItemDelete glyphicon glyphicon-trash"></span>
                        </a>
                    </td>
                </tr>
                <%--遍历出一个订单里面的所有不同订单项--%>
                <c:forEach items="${order.orderItems}" var="orderItem" varStatus="st">
                    <tr class="orderItemProductInfoPartTR">
                        <td class="orderItemProductInfoPartTD"><img width="80" height="80" src="http://how2j.cn/tmall/img/productSingle_middle/${orderItem.product.firstProductImage.id}.jpg"></td>
                        <td class="orderItemProductInfoPartTD">
                            <div class="orderListItemProductLinkOutDiv">
                                <a href="foreproduct?pid=${orderItem.product.id}">${orderItem.product.name}</a>
                                <div class="orderListItemProductLinkInnerDiv">
                                    <img title="支持信用卡支付" src="img/site/creditcard.png">
                                    <img title="消费者保障服务,承诺7天退货" src="img/site/7day.png">
                                    <img title="消费者保障服务,承诺如实描述" src="img/site/promise.png">
                                </div>
                            </div>
                        </td>
                        <td width="100px" class="orderItemProductInfoPartTD">
                            <div class="orderListItemProductOriginalPrice">
                                <span style="text-decoration: line-through;">￥
                                    <fmt:formatNumber value="${orderItem.product.originalPrice}" type="number" minFractionDigits="2"/>
                                </span>
                            </div>
                            <div class="orderListItemProductPrice">￥
                                <fmt:formatNumber value="${orderItem.product.promotePrice}" type="number" minFractionDigits="2"/>
                            </div>
                        </td>
                        <%--数量栏与实付款栏是行合并栏，只生成一次
                            rowspan大小，即行合并大小为订单项种类数
                        --%>
                        <c:if test="${st.count == 1}">
                            <td width="100px" valign="top" class="orderListItemNumberTD orderItemOrderInfoPartTD" rowspan="${fn:length(order.orderItems)}">
                                <span class="orderListItemNumber">${order.totalNumber}</span>
                            </td>
                            <td width="120px" valign="top" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD" rowspan="${fn:length(order.orderItems)}">
                                <div class="orderListItemProductRealPrice">￥
                                    <fmt:formatNumber value="${order.total}" type="number" minFractionDigits="2"/>
                                </div>
                                <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                            </td>
                            <td width="100px" valign="top" class="orderListItemButtonTD orderItemOrderInfoPartTD" rowspan="${fn:length(order.orderItems)}">
                                <%--不用状态status对应按键形状不一样--%>
                                <%--待评价--%>
                                <c:if test="${'waitReview' == order.status}">
                                    <a href="forereview?oid=${order.id}">
                                        <button class="orderListItemReview">评价</button>
                                    </a>
                                </c:if>
                                    <%--待发货--%>
                                <c:if test="${'waitDelivery' == order.status}">
                                    <span>待发货</span>
                                </c:if>
                                    <%--确认收货--%>
                                <c:if test="${'waitConfirm' == order.status}">
                                    <a href="foreconfirmPay?oid=${order.id}">
                                        <button class="orderListItemConfirm">确认收货</button>
                                    </a>
                                </c:if>
                                    <%--待付款--%>
                                <c:if test="${'waitPay' == order.status}">
                                    <a href="alipay.jsp?oid=${order.id}&total=${order.total}">
                                        <button class="orderListItemConfirm">付款</button>
                                    </a>
                                </c:if>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>
        </c:forEach>
    </div>
</div>