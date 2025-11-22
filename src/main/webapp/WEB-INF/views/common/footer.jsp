<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 25. 11. 19.
  Time: 오후 4:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
    <title>Footer</title>
    <meta charset="UTF-8">
    <meta name="description" content="EndGam Gaming Magazine Template">
    <meta name="keywords" content="endGam,gGaming, magazine, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Favicon -->
    <link href="img/favicon.ico" rel="shortcut icon"/>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i,900,900i" rel="stylesheet">


    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/slicknav.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/owl.carousel.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/magnific-popup.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css"/>

    <!-- Main Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>


    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]--></head>
<body>
<!-- Footer section -->
<footer class="footer-section">
    <div class="container">
        <div class="footer-left-pic">
            <img src="${pageContext.request.contextPath}/assest/img/footer-left-pic.png" alt="">
        </div>
        <div class="footer-right-pic">
            <img src="${pageContext.request.contextPath}/assets/img/footer-right-pic.png" alt="">
        </div>
        <a href="#" class="footer-logo">
            <img src="${pageContext.request.contextPath}/assest/img/logo.png" alt="">
        </a>
        <ul class="main-menu footer-menu">
            <li><a href="home.do">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/game?action=gameList">Games</a></li>
            <li>
            	<c:choose>
               		<c:when test="${sessionScope.loginState == true}">
               			<a href="${pageContext.request.contextPath}/game?action=billList">Bill</a>
               		</c:when>
               		<c:otherwise>
               			<a href="${pageContext.request.contextPath}/member?action=loginForm">Bill</a>
               		</c:otherwise>
               	</c:choose>
            </li>
            <li>
				<c:choose>
              		<c:when test="${sessionScope.loginState == true}">
              			<a href="${pageContext.request.contextPath}/game?action=cartList">Cart</a>
              		</c:when>
              		<c:otherwise>
              			<a href="${pageContext.request.contextPath}/game?action=cartList">Cart</a>
              		</c:otherwise>
               	</c:choose>
			</li>
            <li><a href="">Contact</a></li>
        </ul>
        <div class="footer-social d-flex justify-content-center">
            <a href="#"><i class="fa fa-pinterest"></i></a>
            <a href="#"><i class="fa fa-facebook"></i></a>
            <a href="#"><i class="fa fa-twitter"></i></a>
            <a href="#"><i class="fa fa-dribbble"></i></a>
            <a href="#"><i class="fa fa-behance"></i></a>
        </div>
        <div class="copyright"><a href="">tidto</a> 2025 @ All rights reserved</div>
    </div>
</footer>
<!-- Footer section end -->

<!--====== Javascripts & Jquery ======-->
<script src="${pageContext.request.contextPath}/assets/js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.slicknav.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.sticky-sidebar.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.magnific-popup.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

</body>
</html>
