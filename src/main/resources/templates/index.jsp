<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html SYSTEM "http://www.thymeleaf.org/dtd/xhtml1-strict-thymeleaf-4.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org">
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'index.jsp' starting page</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
</head>

<body>

This is my JSP page. <br>
<p th:text="ok">Welcome to our grocery store!</p>

<div th:fragment="copyright">
    © 2019 xxx
</div>

Velocity:<p>$message</p>
FreeMarker:<p>${message}</p>
<!--Thymeleaf:<p th:text="${message}">hello you!</p>-->
<a href=https://www.jianshu.com/p/3931b3b6e7b6>Thymeleaf23232</a>
</body>
</html>