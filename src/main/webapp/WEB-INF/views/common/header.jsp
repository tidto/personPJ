<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 25. 11. 19.
  Time: 오후 4:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
            <a href="home.do" class="site-logo">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="">
            </a>
            <nav class="top-nav-area w-100">
                <div class="user-panel">
                   <c:choose>
                        <%-- 로그인 상태일 때 (sessionScope.loginState가 true) --%>
                        <c:when test="${sessionScope.loginState == true}">
                            <span style="color:white; margin-right:10px; font-weight:bold;">
                                ${sessionScope.member.memberNm}님
                            </span>
                            <span style="color:#ffb320; margin-right:15px;">
                            	<a href="javascript:openChargeWindow()" style="color:#00ff00; margin-right:10px;">&#129689; ${sessionScope.member.rdCoin} RD</a>
                                
                            </span>
                            <a href="${pageContext.request.contextPath}/member?action=logout">Logout</a>
                        </c:when>
                        
                        <%-- 비로그인 상태일 때 --%>
                        <c:otherwise>
                            <%-- HomeController가 아닌 MemberController의 action을 타도록 경로 설정 --%>
                            <a href="${pageContext.request.contextPath}/member?action=loginForm">Login</a> / 
                            <a href="${pageContext.request.contextPath}/member?action=joinForm">Register</a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- Menu -->
                <%-- 로그인에 따라 기능 활성화 --%>
                <ul class="main-menu primary-menu">
                    <li><a href="home.do">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/game?action=gameList">Games</a>
                        <ul class="sub-menu">
                            <li><a href="${pageContext.request.contextPath}/game?action=gameList">Game List</a></li>
                        </ul>
                    </li>
                    <li>
                    	<c:choose>
                    		<c:when test="${sessionScope.loginState == true}">
                    			<a href="${pageContext.request.contextPath}/game?action=billList">Bill</a>
		                    	<ul class="sub-menu">
		                            <li><a href="${pageContext.request.contextPath}/game?action=billList">My Bills</a></li>
		                        </ul>
                    		</c:when>
                    		<c:otherwise>
                    			<a href="${pageContext.request.contextPath}/member?action=loginForm">Bill</a>
		                    	<ul class="sub-menu">
		                            <li><a href="${pageContext.request.contextPath}/member?action=loginForm">My Bills</a></li>
		                        </ul>
                    		</c:otherwise>
                    	</c:choose>
                    </li>
                    <li>
                    	<c:choose>
                    		<c:when test="${sessionScope.loginState == true}">
                    			<a href="${pageContext.request.contextPath}/game?action=cartList">Cart</a>
		                    	<ul class="sub-menu">
		                            <li><a href="${pageContext.request.contextPath}/game?action=cartList">in Cart</a></li>
		                        </ul>
                    		</c:when>
                    		<c:otherwise>
                    			<a href="${pageContext.request.contextPath}/member?action=loginForm">Cart</a>
		                    	<ul class="sub-menu">
		                            <li><a href="${pageContext.request.contextPath}/member?action=loginForm">in Cart</a></li>
		                        </ul>
                    		</c:otherwise>
                    	</c:choose>
                    </li>
                    <li><a href="contact.html">Contact</a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<!-- Header section end -->


<!--====== Javascripts & Jquery ======-->
<script src="${pageContext.request.contextPath}/assets/js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.slicknav.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.sticky-sidebar.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.magnific-popup.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<script>
    function openChargeWindow() {
        var width = 400;
        var height = 550;
        var left = (window.screen.width / 2) - (width / 2);
        var top = (window.screen.height / 2) - (height / 2);
        
        window.open(
            '${pageContext.request.contextPath}/member?action=chargeForm', 
            'chargeWindow', 
            'width=' + width + ',height=' + height + ',top=' + top + ',left=' + left
        );
    }
</script>
</body>
</html>
