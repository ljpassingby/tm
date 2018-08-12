<%--功能jsp页面，没有任何显示，用于定义一些函数和定义一些导包对象--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.css" rel="stylesheet">
    <%--后台样式--%>
    <link href="css/back/style.css" rel="stylesheet">

    <script type="text/javascript">
        <%--用于判断输入是否为空，若是空返回false--%>
        function checkEmpty(id, name) {
            var value = $("#"+id).val();
            if (value.length == 0){
                alert(name + "不能为空");
                $("#" + id)[0].focus();
                return false;
            }
            return true;
        }
//        判断输入是否为数字
        function checkNumber(id, name) {
            var value = $("#" + id).val();
            if (value.length == 0){
                alert(name + "不能为空");
                $("#" + id)[0].focus();
                return false;
            }
            if (isNaN(value)){
                alert(name + "必须是数字");
                $("#" + id).focus();
                return false;
            }
            return true;
        }
//        判断输入是否为整数
        function checkInt(id, name) {
            var value = $("#" + id).val();
            if (value.length == 0){
                alert(name + "不能为空");
                $("#" + id)[0].focus();
                return false;
            }
            if (parseInt(value) != value){
                alert(name + "必须是整数");
                $("#" + id).focus();
                return false;
            }
            return true;
        }
    </script>
    <script>
        //对于删除超链接做判断确认
        $(function () {
            $("a").click(function () {
                //这个deleteLink是删除标签<a>的一个自定义属性名
                var deleteLink = $(this).attr("deleteLink");
                console.log(deleteLink);
                if ("true" == deleteLink){
                    var confirmDelete = confirm("确认要删除吗？");
                    if (confirmDelete)
                        return true;
                    return false;
                }
            });
        })
    </script>
</head>
<body>
</body>
</html>
