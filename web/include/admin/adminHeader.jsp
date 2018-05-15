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
    <link href="css/back/style.css" rel="stylesheet">

    <script type="text/javascript">
        function checkEmpty(id, name) {
            var value = $("#"+id).val();
            if (value.length == 0){
                alert(name + "不能为空");
                $("#" + id)[0].focus();
                return false;
            }
            return true;
        }
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
                var deleteLink = $(this).attr("deleteLink");
                console.log(deleteLink);
                if ("true" == deleteLink){
                    var confirmDelete = confirm("确认要删除")
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
