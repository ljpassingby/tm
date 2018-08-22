<%--轮播部分，都是静态的页面，没有用到服务端数据--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>
<!--轮播,bootstrap的模板代码-->
<div data-ride="carousel" class="carousel-of-product carousel slide" id="carousel-of-product">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <li data-slide-to="0" data-target="#carousel-of-product" class="active"></li>
        <li data-slide-to="1" data-target="#carousel-of-product" class=""></li>
        <li data-slide-to="2" data-target="#carousel-of-product" class=""></li>
        <li data-slide-to="3" data-target="#carousel-of-product" class=""></li>
    </ol>
    <!-- Wrapper for slides -->
    <div role="listbox" class="carousel-inner">
        <div class="item active">
            <img src="http://how2j.cn/tmall/img/lunbo/1.jpg" class="carousel carouselImage">
        </div>
        <div class="item">
            <img src="http://how2j.cn/tmall/img/lunbo/2.jpg" class="carouselImage">
        </div>
        <div class="item">
            <img src="http://how2j.cn/tmall/img/lunbo/3.jpg" class="carouselImage">
        </div>
        <div class="item">
            <img src="http://how2j.cn/tmall/img/lunbo/4.jpg" class="carouselImage">
        </div>
    </div>
</div>
