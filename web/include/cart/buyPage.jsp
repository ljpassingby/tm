<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<div class="buyPageDiv">
    <form action="forecreateOrder" method="post">
        <!--头部和收货地址-->
        <div class="buyFlow">
            <img src="img/site/simpleLogo.png" class="pull-left">
            <img src="img/site/buyflow.png" class="pull-right">
            <div style="clear:both"></div>
        </div>
        <div class="address">
            <div class="addressTip">输入收货地址</div>
            <div>
                <table class="addressTable">
                    <tbody><tr>
                        <td class="firstColumn">详细地址<span class="redStar">*</span></td>
                        <td><textarea placeholder="建议您如实填写详细收货地址，例如接到名称，门牌好吗，楼层和房间号等信息" name="address"></textarea></td>
                    </tr>
                    <tr>
                        <td>邮政编码</td>
                        <td><input type="text" placeholder="如果您不清楚邮递区号，请填写000000" name="post"></td>
                    </tr>
                    <tr>
                        <td>收货人姓名<span class="redStar">*</span></td>
                        <td><input type="text" placeholder="长度不超过25个字符" name="receiver"></td>
                    </tr>
                    <tr>
                        <td>手机号码 <span class="redStar">*</span></td>
                        <td><input type="text" placeholder="请输入11位手机号码" name="mobile"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!--确认订单信息-->
        <div class="productList">
            <div class="productListTip">确认订单信息</div>
            <table class="productListTable">
                <thead>
                <tr>
                    <th class="productListTableFirstColumn" colspan="2">
                        <img src="img/site/tmallbuy.png" class="tmallbuy">
                        <a href="#nowhere" class="marketLink">店铺：天猫店铺</a>
                        <a href="#nowhere" class="wangwanglink"> <span class="wangwangGif"></span> </a>
                    </th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>配送方式</th>
                </tr>
                <tr class="rowborder">
                    <td colspan="2"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </thead>
                <tbody class="productListTableTbody">
                    <c:forEach items="${orderItemList}" var="orderItem" varStatus="st">
                        <tr class="orderItemTR">
                            <td class="orderItemFirstTD"><img width="20px"  src="http://how2j.cn/tmall/img/productSingle_middle/${orderItem.product.firstProductImage.id}.jpg" class="orderItemImg"></td>
                            <td class="orderItemProductInfo">
                                <a class="orderItemProductLink" href="foreproduct?pid=${orderItem.product.id}">${orderItem.product.name}</a>
                                <img title="支持信用卡支付" src="img/site/creditcard.png">
                                <img title="消费者保障服务,承诺7天退货" src="img/site/7day.png">
                                <img title="消费者保障服务,承诺如实描述" src="img/site/promise.png">
                            </td>
                            <td>
                                <span class="orderItemProductPrice">￥
                                    <fmt:formatNumber type="number" value="${orderItem.product.promotePrice}" minFractionDigits="2"/>
                                </span>
                            </td>
                            <td>
                                <span class="orderItemProductNumber">${orderItem.number}</span>
                            </td>
                            <td>
                                <span class="orderItemUnitSum">￥
                                    <fmt:formatNumber type="number" value="${orderItem.product.promotePrice * orderItem.number}" minFractionDigits="2"/>
                                </span>
                            </td>
                            <%--只在第一行tr中才会有这个，它现在是做了五行合并rowspan--%>
                            <c:if test="${st.count == 1}">
                                <td class="orderItemLastTD" rowspan="5">
                                    <label class="orderItemDeliveryLabel">
                                        <input type="radio" checked="checked" value="">
                                        普通配送
                                    </label>
                                    <select class="orderItemDeliverySelect">
                                        <option>快递 免邮费</option>
                                    </select>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="orderItemSumDiv">
                <div class="pull-left">
                    <span class="leaveMessageText">给卖家留言:</span>
                    <!--一个卖家留言的图片，点击后会被隐藏，且后面那个真正的textarea标签会显示出来-->
                    <span>
                        <img src="img/site/leaveMessage.png" class="leaveMessageImg">
                    </span>
                    <span class="leaveMessageTextareaSpan" style="display: none;">
                        <textarea class="leaveMessageTextarea" name="userMessage"></textarea>
                        <div>
                            <span>还可以输入200个字符</span>
                        </div>
                    </span>
                </div>
                <span class="pull-right">店铺合计(含运费): ￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/></span>
            </div>
        </div>
        <%--确认付款--%>
        <div class="orderItemTotalSumDiv">
            <div class="pull-right">
                <span>实付款：</span>
                <span class="orderItemTotalSumSpan">￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/></span>
            </div>
        </div>
        <div class="submitOrderDiv">
            <button class="submitOrderButton" type="submit">提交订单</button>
        </div>
    </form>
</div>