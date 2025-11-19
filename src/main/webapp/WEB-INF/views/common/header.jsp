<%--
  Created by IntelliJ IDEA.
  User: alsgh
  Date: 25. 11. 19.
  Time: 오후 4:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Header</title>
    <meta charset="UTF-8">
    <meta name="description" content="EndGam Gaming Magazine Template">
    <meta name="keywords" content="endGam,gGaming, magazine, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Favicon -->
    <link href="img/favicon.ico" rel="shortcut icon"/>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,400i,500,500i,700,700i,900,900i" rel="stylesheet">


    <!-- Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assats/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assats/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assats/css/slicknav.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assats/css/owl.carousel.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assats/css/magnific-popup.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assats/css/animate.css"/>

    <!-- Main Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assats/css/style.css"/>


    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
<!-- Header section -->
<header class="header-section">
    <div class="header-warp">
        <div class="header-social d-flex justify-content-end">
            <p>Follow us:</p>
            <a href="#"><i class="fa fa-pinterest"></i></a>
            <a href="#"><i class="fa fa-facebook"></i></a>
            <a href="#"><i class="fa fa-twitter"></i></a>
            <a href="#"><i class="fa fa-dribbble"></i></a>
            <a href="#"><i class="fa fa-behance"></i></a>
        </div>
        <div class="header-bar-warp d-flex">
            <!-- site logo -->
            <a href="index.html" class="site-logo">
                <img src="./img/logo.png" alt="">
            </a>
            <nav class="top-nav-area w-100">
                <div class="user-panel">
                    <a href="">Login</a> / <a href="">Register</a>
                </div>
                <!-- Menu -->
                <ul class="main-menu primary-menu">
                    <li><a href="index.html">Home</a></li>
                    <li><a href="games.html">Games</a>
                        <ul class="sub-menu">
                            <li><a href="game-single.html">Game Singel</a></li>
                        </ul>
                    </li>
                    <li><a href="review.html">Reviews</a></li>
                    <li><a href="blog.html">News</a></li>
                    <li><a href="contact.html">Contact</a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<!-- Header section end -->


<!--====== Javascripts & Jquery ======-->
<script src="${pageContext.request.contextPath}/assats/js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assats/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assats/js/jquery.slicknav.min.js"></script>
<script src="${pageContext.request.contextPath}/assats/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/assats/js/jquery.sticky-sidebar.min.js"></script>
<script src="${pageContext.request.contextPath}/assats/js/jquery.magnific-popup.min.js"></script>
<script src="${pageContext.request.contextPath}/assats/js/main.js"></script>

</body>
</html>
