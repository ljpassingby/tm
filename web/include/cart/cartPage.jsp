<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<script>
    //将数字格式转化为钱的格式，如3230394->3,230,394.00
    function formatMoney(num){
        num = num.toString().replace(/\$|\,/g,'');
        if(isNaN(num))
            num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num*100+0.50000000001);
        cents = num%100;
        num = Math.floor(num/100).toString();
        if(cents<10)
            cents = "0" + cents;
        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
            num = num.substring(0,num.length-(4*i+3))+','+
                num.substring(num.length-(4*i+3));
        return (((sign)?'':'-') + num + '.' + cents);
    }

    //判断是否有某个订单项的选择框被打钩，若有，则让两个“结算”按键变色且变为可点，否则结算按键置为不能点击
    //这个selectit属性只有在选择框这个img标签上才有
    function syncCreateOrderButton() {
        var selectAny = false;
        $("img.cartProductItemIfSelected").each(function () {
            if("true" == $(this).attr("selectit")){
                selectAny = true;
            }
        });
        if(selectAny == true){
            $("button.createOrderButton").css("background-color", "#C40000");
            $("button.createOrderButton").removeAttr("disabled");
        }
        else {
            $("button.createOrderButton").css("background-color", "#AAAAAA");
            $("button.createOrderButton").attr("disabled", "disabled");
        }
    }

    //同步“全选”按键，即若所有订单项都被选中，则自动让“全选”按键显示被选中
    function syncSelect() {
        var selectAll = true;
        $("img.cartProductItemIfSelected").each(function () {
            if("false" == $(this).attr("selectit")){
                selectAll = false;
            }
        });
        if(selectAll == true){
            $("img.selectAllItem").attr("src", "img/site/cartSelected.png");
            $("img.selectAllItem").attr("selectit", "true");
        }
        else{
            $("img.selectAllItem").attr("src", "img/site/cartNotSelected.png");
            $("img.selectAllItem").attr("selectit", "false");
        }
    }

    //显示被选中的所有商品的总数，以及它们的总价格，调用了formatMoney
    //获取了每个订单项自己的小计总价与每个订单项对应自身商品的购买数，最后分别求和
    function calcCartSumPriceAndNumber() {
        var sum = 0;
        var totalNumber = 0;
        $("img.cartProductItemIfSelected[selectit='true']").each(function () {
            var oiid = $(this).attr("oiid");
            var price = $("span.cartProductItemSmallSumPrice[oiid="+oiid+"]").text();
            price = price.replace(/,/g, "");
            price = price.replace(/￥/g, "");
            sum += new Number(price);
            var number = $("input.orderItemNumberSetting[oiid="+oiid+"]").val();
            totalNumber += new Number(number);
        });
        $("span.cartSumPrice").html("￥" + formatMoney(sum));    //给底端总价赋值
        $("span.cartTitlePrice").html("￥" + formatMoney(sum));  //给顶端总价赋值
        $("span.cartSumNumber").html(totalNumber);  //给底端的总数赋值
    }

    //统计每个订单项自己的小计价格，并将其同步更新归并入商品总价，调用了formatMoney,calcCartSumPriceAndNumber
    function syncPrice(pid, num, price) {
        var cartProductItemSmallSumPrice = formatMoney(num * price);
        $(".cartProductItemSmallSumPrice[pid="+pid+"]").html("￥" + cartProductItemSmallSumPrice);
        calcCartSumPriceAndNumber();

        var page = "forechangeOrderItem";
        $.post(
            page,
            {"pid":pid, "num":num},
            function (result) {
                if("success" != result)
                    location.href = "login.jsp";
            }
        );
    }
</script>
<!--
事件监听，有4+2种：
1. 选中一种商品
2. 商品全选
3. 鼠标点击增加和减少数量
4. 键盘输入直接修改数量

5. 提交订单点击
6. 删除订单项
-->
<script>
    var deleteOrderItem = false;
    var deleteOrderItemid = 0;
    $(function () {

        //1.选中某一件商品后的动态变化：该订单项的选中项发生变化、总价栏、总商品数栏发生变化
        $("img.cartProductItemIfSelected").click(function () {
            var selectit = $(this).attr("selectit");
            //当商品本身没被选中时，改为选中商品
            if("false" == selectit){
                $(this).attr("src", "http://how2j.cn/tmall/img/site/cartSelected.png");
                $(this).attr("selectit", "true");
                //选中商品后，修改该订单项所在tr的背景色
                $(this).parents("tr.cartProductItemTR").css("background-color", "#FFF8E1");
            }
            //当商品本身被选中时，改为取消选中商品
            else {
                $(this).attr("src", "http://how2j.cn/tmall/img/site/cartNotSelected.png");
                $(this).attr("selectit", "false");
                $(this).parents("tr.cartProductItemTR").css("background-color", "#fff");
            }
            syncSelect();   //判定全选键是否要点亮与关闭
            syncCreateOrderButton();    //判断“结算”按键是否要点亮或关闭
            calcCartSumPriceAndNumber();    //总价与总数目更新
        });

        //2.有两个全选键，“全选”按键按下时的动态变化：全选键自身变化、所有订单项选择变化、总价栏变化、总商品数变化
        $("img.selectAllItem").click(function () {
            var selectit = $(this).attr("selectit");
            //当全选键本身没被选中时，改为全选商品
            if("false" == selectit){
                //有两个全选键，不能用$(this)获取
                $("img.selectAllItem").attr("src", "img/site/cartSelected.png");
                $("img.selectAllItem").attr("selectit", "true");
                //全选中商品后，所有订单项所在tr的背景色变色，选中项变化，选中属性修改
                $("img.cartProductItemIfSelected").each(function () {
                    $(this).parents("tr.cartProductItemTR").css("background-color", "#FFF8E1");
                    $(this).attr("src", "img/site/cartSelected.png");
                    $(this).attr("selectit", "true");
                });
            }
            else {
                $("img.selectAllItem").attr("src", "img/site/cartNotSelected.png");
                $("img.selectAllItem").attr("selectit", "false");
                $("img.cartProductItemIfSelected").each(function () {
                    $(this).parents("tr.cartProductItemTR").css("background-color", "#fff");
                    $(this).attr("src", "img/site/cartNotSelected.png");
                    $(this).attr("selectit", "false");
                });
            }
            syncCreateOrderButton();    //判断“结算”按键是否要点亮或关闭
            calcCartSumPriceAndNumber();    //总价与总数目更新
        });

        //3.1点击增加数量
        $(".numberPlus").click(function () {
            var pid = $(this).attr("pid");
            var stock = $(".orderItemStock[pid="+pid+"]").text();
            var number = $("input.orderItemNumberSetting[pid="+pid+"]").val();
            var price = $(".orderItemPromotePrice[pid="+pid+"]").text();
            number++;
            if(number > stock){
                number = stock;
            }
            $("input.orderItemNumberSetting[pid="+pid+"]").val(number); //修改产品数量
            syncPrice(pid, number, price);
//            calcCartSumPriceAndNumber();
        });
        //3.2点击减少数量
        $(".numberMinus").click(function () {
            var pid = $(this).attr("pid");
            var stock = $(".orderItemStock[pid="+pid+"]").text();
            var number = $("input.orderItemNumberSetting[pid="+pid+"]").val();
            var price = $(".orderItemPromotePrice[pid="+pid+"]").text();
            number--;
            if(number <= 0){
                number = 1;
            }
            $("input.orderItemNumberSetting[pid="+pid+"]").val(number); //修改产品数量
            syncPrice(pid, number, price);
//            calcCartSumPriceAndNumber();
        });

        //4.键盘输入改变数量
        $("input.orderItemNumberSetting").keyup(function () {
            var pid = $(this).attr("pid");
            var stock = $(".orderItemStock[pid="+pid+"]").text();
            var price = $(".orderItemPromotePrice[pid="+pid+"]").text();

            //判断非字符
            var number = $(this).val();
            number = parseInt(number);
            if(isNaN(number)){
                number = 1;
            }
            if(number <= 0){
                number = 1;
            }
            if(number >= stock){
                number = stock;
            }
//            $(this).attr("value", number);
            syncPrice(pid, number, price);
            calcCartSumPriceAndNumber();
        });

        //5. 提交订单
        $("button.createOrderButton").click(function(){
            var params = "";
            $(".cartProductItemIfSelected").each(function(){
                if("true"==$(this).attr("selectit")){
                    var oiid = $(this).attr("oiid");
                    params += "&oiid="+oiid;
                }
            });
            params = params.substring(1);
            location.href="forebuy?"+params;
        });

        //6. 删除订单项
        //点击删除按键弹出删除确认的模态窗口
        $("a.deleteOrderItem").click(function(){
            deleteOrderItem = false;
            var oiid = $(this).attr("oiid");
            deleteOrderItemid = oiid;
            $("#deleteConfirmModal").modal('show');
        });
        //模态窗口点击确认后响应
        $("button.deleteConfirmButton").click(function(){
            deleteOrderItem = true;
            $("#deleteConfirmModal").modal('hide');
        });
        $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
            if(deleteOrderItem){
                var page="foredeleteOrderItem";
                $.post(
                    page,
                    {"oiid":deleteOrderItemid},
                    function(result){
                        if("success"==result){
                            $("tr.cartProductItemTR[oiid="+deleteOrderItemid+"]").remove();
                        }
                        else{
                            location.href="login.jsp";
                        }
                    }
                );
            }
        })
    });
</script>

<body>
    <div class="cartDiv">
        <!--结算栏上栏-->
        <div class="cartTitle pull-right">
            <span>已选商品  (不含运费)</span>
            <span class="cartTitlePrice">￥0.00</span>
            <button class="createOrderButton" style="background-color: rgb(170, 170, 170);" disabled="disabled">结 算</button>
        </div>
        <div style="clear: both;"></div>
        <!--订单项-->
        <div class="cartProductList">
            <table class="cartProductTable">
                <thead>
                    <tr>
                    <th class="selectAndImage">
                        <img src="img/site/cartNotSelected.png" class="selectAllItem" selectit="false">
                        全选
                    </th>
                    <th>商品信息</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th width="120px">金额</th>
                    <th class="operation">操作</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderItemList}" var="orderItem">
                        <tr class="cartProductItemTR" oiid="${orderItem.id}">
                            <!--选择框与图片-->
                            <td>
                                <!--只有选择框有这个selectit属性，用于标记是否选择，非常重要-->
                                <img src="img/site/cartNotSelected.png" class="cartProductItemIfSelected" oiid="${orderItem.id}" selectit="false">
                                <a href="#nowhere" style="display:none"><img src="img/site/cartSelected.png"></a>
                                <img width="40px" src="http://how2j.cn/tmall/img/productSingle_middle/${orderItem.product.firstProductImage.id}.jpg" class="cartProductImg">
                            </td>
                            <!--商品信息-->
                            <td>
                                <div class="cartProductLinkOutDiv">
                                    <a href="foreproduct?pid=${orderItem.product.id}" class="cartProductLink">
                                        ${orderItem.product.name}
                                    </a>
                                    <div class="cartProductLinkInnerDiv">
                                        <img title="支持信用卡支付" src="img/site/creditcard.png">
                                        <img title="消费者保障服务,承诺7天退货" src="img/site/7day.png">
                                        <img title="消费者保障服务,承诺如实描述" src="img/site/promise.png">
                                    </div>
                                </div>
                            </td>
                            <!--单价-->
                            <td>
                                <span class="cartProductItemOringalPrice">￥
                                    <fmt:formatNumber type="number" value="${orderItem.product.originalPrice}" minFractionDigits="2"/>
                                </span>
                                <span class="cartProductItemPromotionPrice">￥
                                    <fmt:formatNumber  type="number" value="${orderItem.product.promotePrice}" minFractionDigits="2"/>
                                </span>
                            </td>
                            <!--该订单项对应商品选择的数量-->
                            <td>
                                <div class="cartProductChangeNumberDiv">
                                    <!--下面两个span用于标记这个商品当前最大的单价与最高可购买数量，这两个span是隐藏的hidden-->
                                    <span pid="${orderItem.product.id}" class="hidden orderItemStock">${orderItem.product.stock}</span>
                                    <span pid="${orderItem.product.id}" class="hidden orderItemPromotePrice">${orderItem.product.promotePrice}</span>
                                    <a href="#nowhere" class="numberMinus" pid="${orderItem.product.id}">-</a>
                                    <input type="text" value="${orderItem.number}" autocomplete="off" class="orderItemNumberSetting" oiid="${orderItem.id}" pid="${orderItem.product.id}">
                                    <a href="#nowhere" class="numberPlus" pid="${orderItem.product.id}" stock="${orderItem.product.stock}">+</a>
                                </div>
                            </td>
                            <!--该订单项总金额-->
                            <td>
                                <span pid="${orderItem.product.id}" oiid="${orderItem.id}" class="cartProductItemSmallSumPrice">￥
                                    <fmt:formatNumber type="number" value="${orderItem.number * orderItem.product.promotePrice}"/>
                                </span>
                            </td>
                            <!--操作-删除-->
                            <td>
                                <a href="#nowhere" oiid="${orderItem.id}" class="deleteOrderItem">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <!--所有商品总金额结算栏下栏-->
        <div class="cartFoot">
            <img src="img/site/cartNotSelected.png" class="selectAllItem" selectit="false">
            <span>全选</span>
            <div class="pull-right">
                <span>已选商品 <span class="cartSumNumber">0</span> 件</span>
                <span>合计 (不含运费): </span>
                <span class="cartSumPrice">￥0.00</span>
                <button class="createOrderButton" style="background-color: rgb(170, 170, 170);" disabled="disabled">结 算</button>
            </div>
        </div>
    </div>
</body>