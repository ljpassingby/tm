<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<!--修改价格js代码-->
<script>
    $(function () {
        var stock = ${product.stock};
        $("input.productNumberSetting").keyup(function () {
            var num = $(this).val();
            num = parseInt(num);
            if(isNaN(num)){
                num = 1;
            }
            if(num <= 0){
                num = 1;
            }
            if(num > stock){
                num = stock;
            }
            $(this).val(num);
        });

        $("a.increaseNumber").click(function () {
            var num = $("input.productNumberSetting").val();
            num ++;
            if(num > stock){
                num = stock;
            }
            $("input.productNumberSetting").val(num);
        });
        $("a.decreaseNumber").click(function () {
            var num = $("input.productNumberSetting").val();
            num --;
            if(num <= 0){
                num = 1;
            }
            $("input.productNumberSetting").val(num);
        });
//        模态登录，点击购物车时判断
        $(".addCartLink").click(function(){
            var page = "forecheckLogin";
            $.get(
                page,
                function(result){
                    if("success"==result){
                        var pid = ${product.id};
                        var num= $(".productNumberSetting").val();
                        var addCartpage = "foreaddCart";
                        $.get(
                            addCartpage,
                            {"pid":pid,"num":num},
                            function(result){
                                if("success"==result){
                                    $(".addCartButton").html("已加入购物车");
                                    $(".addCartButton").attr("disabled","disabled");
                                    $(".addCartButton").css("background-color","lightgray");
                                    $(".addCartButton").css("border-color","lightgray");
                                    $(".addCartButton").css("color","black");
                                }
                                else{}
                            }
                        );
                    }
                    else{
                        $("#loginModal").modal('show');
                    }
                }
            );
            return false;
        });
//        模态登录，点击购买时判断
        $(".buyLink").click(function(){
            var page = "forecheckLogin";
            $.get(
                page,
                function(result){
                    if("success"==result){
                        var num = $(".productNumberSetting").val();
                        location.href= $(".buyLink").attr("href")+"&num="+num;
                    }
                    else{
                        $("#loginModal").modal('show');
                    }
                }
            );
            return false;
        });
//        模态登录的登录跳转，loginSubmitButton时那个模态登录窗口的登录按键
        $("button.loginSubmitButton").click(function(){
            var name = $("#name").val();
            var password = $("#password").val();

            if(0==name.length||0==password.length){
                $("span.errorMessage").html("请输入账号密码");
                $("div.loginErrorMessageDiv").show();
                return false;
            }

            var page = "foreloginAjax";
            $.get(
                page,
                {"name":name,"password":password},
                function(result){
                    if("success"==result){
                        location.reload();
                    }
                    else{
                        $("span.errorMessage").html("账号密码错误");
                        $("div.loginErrorMessageDiv").show();
                    }
                }
            );
            return true;
        });
    });
</script>

<!--显示缩略图效果-->
<script>
    $(function () {
        var initBigImg = false;
        $("img.smallImage").mouseenter(function () {
            var bigImageURL = $(this).attr("bigImageURL");
            $("img.bigImg").attr("src", bigImageURL);

            $("img.smallImage").each(function () {
                $(this).css("border-color", "white");
            });
            $(this).css("border-color", "black");
        });

        //图片预加载，在浏览器加载该页面时把所有大图都加载完毕，而不是等鼠标移上去后再让大图去找服务器要图
        //load是该选择器在加载新图片时就会自动调用的jquery函数
        $("img.bigimg").load(function () {
            if(initBigImg){
                return;
            }
            $("img.smallImage").each(function () {
                var bigImageURL = $(this).attr("bigImageURL");
                var img = new Image();
                img.src = bigImageURL;
                img.onload = function () {
//                    console.log(bigImageURL)
                    $("img.img4load").append(img);
                };
            });
            initBigImg = true;
        });
    });
</script>

<body>
<!--上方图片与购买-->
<div class="imgAndInfo">
    <!--左边悬浮的展示图片-->
    <div class="imgInimgAndInfo">
        <img width="100px" class="bigImg" src="http://how2j.cn/tmall/img/productSingle/${product.firstProductImage.id}.jpg">
        <div class="smallImageDiv">
            <c:forEach items="${product.productSingleImages}" var="psi">
                <img width="56px" class="smallImage" src="http://how2j.cn/tmall/img/productSingle_small/${psi.id}.jpg" bigImageURL="http://how2j.cn/tmall/img/productSingle/${psi.id}.jpg">
            </c:forEach>
        </div>
    </div>
    <div class="img4load hidden"></div>
    <!--<div style="clear: both;"></div>-->

    <!--右边产品基本信息、选择购买样式-->
    <div class="infoInimgAndInfo">
        <!--产品标题-->
        <div class="productTitle">${product.name}</div>
        <!--产品副标题-->
        <div class="productSubTitle">${product.subTitle}</div>
        <!--聚划算价格div块-->
        <div class="productPrice">
            <div class="juhuasuan">
                <span class="juhuasuanBig">聚划算</span>
                <span>
                    此商品即将参加聚划算，
                    <span class="juhuasuanTime">1天19小时</span>
                    后开始
                </span>
            </div>
            <div class="productPriceDiv">
                <div class="gouwujuanDiv">
                    <img height="16px" src="img/site/gouwujuan.png">
                    <span>全天猫实物商品通用</span>
                </div>
                <div class="originalDiv">
                    <span class="originalPriceDesc">价格</span>
                    <span class="originalPriceYuan">¥</span>
                    <span class="originalPrice">
                        <fmt:formatNumber type="number" value="${product.originalPrice}" minFractionDigits="2"/>
                    </span>
                </div>
                <div class="promotionDiv">
                    <span class="promotionPriceDesc">促销价</span>
                    <span class="promotionPriceYuan">¥</span>
                    <span class="promotionPrice">
                        <fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/>
                    </span>
                </div>
            </div>
        </div>
        <!--销量与评价数目-->
        <div class="productSaleAndReviewNumber">
            <div>销量 <span class="redColor boldWord"> ${product.saleCount}</span></div>
            <div>累计评价 <span class="redColor boldWord"> ${product.reviewCount}</span></div>
        </div>
        <!--购买数量与库存-->
        <div class="productNumber">
            <span>数量</span>
            <span>
                <span class="productNumberSettingSpan">
                    <input type="text" value="1" class="productNumberSetting">
                </span>
                <span class="arrow">
                    <a class="increaseNumber" href="#nowhere">
                        <span class="updown"><img src="img/site/increase.png"></span>
                    </a>
                    <span class="updownMiddle"> </span>
                    <a class="decreaseNumber" href="#nowhere">
                        <span class="updown"><img src="img/site/decrease.png"></span>
                    </a>
                </span>
                件
            </span>
            <span>库存${product.stock}件</span>
        </div>
        <!--服务保障-->
        <div class="serviceCommitment">
            <span class="serviceCommitmentDesc">服务承诺</span>
            <span class="serviceCommitmentLink">
                <a href="#nowhere">正品保证</a>
                <a href="#nowhere">极速退款</a>
                <a href="#nowhere">赠运费险</a>
                <a href="#nowhere">七天无理由退换</a>
            </span>
        </div>
        <!--购买与加入购物车-->
        <div class="buyDiv">
            <a href="forebuyone?pid=${product.id}" class="buyLink">
                <button class="buyButton">立即购买</button>
            </a>
            <a class="addCartLink" href="#nowhere">
                <button class="addCartButton">
                    <span class="glyphicon glyphicon-shopping-cart"></span>加入购物车
                </button>
            </a>
        </div>
    </div>
</div>
<div style="clear: both;"></div>
</body>