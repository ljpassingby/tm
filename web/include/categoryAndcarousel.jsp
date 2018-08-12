<%--
利用ForeServlet传递过来的数据，天猫国际几个字旁边显示4个分类超链。
另外包含了其他3个页面：
categoryMenu.jsp
productsAsideCategorys.jsp
carousel.jsp
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>
<html>
<head>
    <!--猫耳朵交互-->
    <script>
        $(function(){
            $("div.rightMenu span").mouseenter(function(){
                var left = $(this).position().left;
                var top = $(this).position().top;
                var width = $(this).css("width");
                var destLeft = parseInt(left) + parseInt(width) / 2;
                $("img#catear").css("left",destLeft);
                $("img#catear").css("top",top - 20);   /*这个20指的是猫耳朵的高度*/
                $("img#catear").fadeIn(500);
            });
            $("div.rightMenu span").mouseleave(function(){
                $("img#catear").hide();
            });
//            这段用于让整个页面向内靠齐
            var left = $("div#carousel-of-product").offset().left;
            $("div.categoryMenu").css("left",left-20);
            $("div.categoryWithCarousel div.head").css("margin-left",left);
            $("div.productsAsideCategorys").css("left",left-20);
        });
    </script>

    <!--分类栏隐藏与显示交互-->
    <script>
        function showProductsAsideCategorys(cid){
            //本来是hover才会有下面两句的样式，现在是直接赋值
            $("div.eachCategory[cid="+cid+"]").css("background-color","white");
            $("div.eachCategory[cid="+cid+"] a").css("color","#87CEFA");
            $("div.productsAsideCategorys[cid="+cid+"]").show();
        }

        function hideProductsAsideCategorys(cid){
            //鼠标移除后，将样式赋值为鼠标不移动上去的样子
            $("div.eachCategory[cid="+cid+"]").css("background-color","#e2e2e3");
            $("div.eachCategory[cid="+cid+"] a").css("color","#000");
            $("div.productsAsideCategorys[cid="+cid+"]").hide();
        }

        $(function(){
            $("div.eachCategory").mouseenter(function(){
                var cid = $(this).attr("cid");
                showProductsAsideCategorys(cid);
            });
            $("div.eachCategory").mouseleave(function(){
                var cid = $(this).attr("cid");
                hideProductsAsideCategorys(cid);
            });
            $("div.productsAsideCategorys").mouseenter(function(){
                var cid = $(this).attr("cid");
                showProductsAsideCategorys(cid);
            });
            $("div.productsAsideCategorys").mouseleave(function(){
                var cid = $(this).attr("cid");
                hideProductsAsideCategorys(cid);
            });
        });
    </script>
</head>
<body>
    <%--猫耳朵--%>
    <img class="catear" id="catear" src="img/site/catear.png" />

    <div class="categoryWithCarousel">
        <div class="headbar show1">

            <div class="head">
                <span style="margin-left: 10px;" class="glyphicon glyphicon-th-list"></span>
                <span style="margin-left: 10px;">商品分类</span>
            </div>
            <div class="rightMenu">
                <%--“天猫超市”超链接--%>
                <span><a href="#nowhere"><img src="img/site/chaoshi.png"></a></span>
                <%--“天猫国际”超链接--%>
                <span><a href="#nowhere"><img src="img/site/guoji.png"></a></span>

                <c:forEach items="${categoryList}" var="category" varStatus="st">
                    <c:if test="${st.count >= 2 and st.count <= 5}">
                        <span>
                            <a href="forecategory?cid=${category.id}">${category.name}</a>
                        </span>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <%--显示左侧的竖状分类导航--%>
        <div style="position: relative">
            <%@ include file="categoryMenu.jsp" %>
        </div>

        <%--显示鼠标移到竖状分类导航的分类时，显示该分类下的产品--%>
        <div style="position: relative;left: 0;top: 0;">
            <%@ include file="productsAsideCategorys.jsp" %>
        </div>

        <%--引入轮播效果页面,position是fixed,绝对占用位置--%>
        <%@ include file="carousel.jsp" %>
        <%--为轮播背景填色,这个填色div是absolute的位置,起到将轮播页面占据的背景填色--%>
        <div class="carouselBackgroundDiv"></div>
    </div>
</body>
</html>
