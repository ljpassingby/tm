<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="utf-8" isELIgnored="false" %>

<script>
    $(function () {
//        用于按价格范围筛选当前页面的产品
        $("input.sortBarPrice").keyup(function () {
            var price = $(this).val();
            if(price.length == 0){
                $("div.productUnit").show();
                return;
            }
            price = parseInt(price);
            if(isNaN(price) || price <= 0){
                price = 1;
            }
            $(this).val(price);

            var begin = $("input.beginPrice").val();
            var end = $("input.endPrice").val();
            if(!isNaN(begin) && !isNaN(end)){
                begin = Number(begin);
                end = Number(end);
                $("div.productUnit").hide();
                $("div.productUnit").each(function () {
                    var num = $(this).attr("price");
                    if(num >= begin && num <= end){
                        $(this).show();
                    }
                });
            }
        });
    });
</script>

<div class="categorySortBar">
    <table class="categorySortBarTable categorySortTable">
        <tbody>
        <tr>
            <td <c:if test="${'all' == param.sort || empty param.sort}">class="grayColumn"</c:if>>
                <a href="?cid=${category.id}&sort=all">综合<span class="glyphicon glyphicon-arrow-down"></span></a>
            </td>
            <td <c:if test="${'review' == param.sort}">class="grayColumn"</c:if>>
                <a href="?cid=${category.id}&sort=review">人气<span class="glyphicon glyphicon-arrow-down"></span></a>
            </td>
            <td <c:if test="${'data' == param.sort}">class="grayColumn"</c:if>>
                <a href="?cid=${category.id}&sort=date">新品<span class="glyphicon glyphicon-arrow-down"></span></a>
            </td>
            <td <c:if test="${'saleCount' == param.sort}">class="grayColumn"</c:if>>
                <a href="?cid=${category.id}&sort=saleCount">销量<span class="glyphicon glyphicon-arrow-down"></span></a>
            </td>
            <td <c:if test="${'price' == param.sort}">class="grayColumn"</c:if>>
                <a href="?cid=${category.id}&sort=price">价格<span class="glyphicon glyphicon-resize-vertical"></span></a>
            </td>
        </tr>
        </tbody>
    </table>
    <table class="categorySortBarTable">
        <tbody>
        <tr>
            <td><input type="text" placeholder="请输入" class="sortBarPrice beginPrice"></td>
            <td class="grayColumn priceMiddleColumn">-</td>
            <td><input type="text" placeholder="请输入" class="sortBarPrice endPrice"></td>
        </tr>
        </tbody>
    </table>
</div>