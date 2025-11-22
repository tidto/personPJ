<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 2025. 11. 19.
  Time: AM 9:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Page Preloder -->
<!-- Header section -->

<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="${pageContext.request.contextPath}/assets/img/page-top-bg/4.jpg">
    <div class="page-info">
        <h2>WELCOME</h2>
        <div class="site-breadcrumb">
            <a href="${pageContext.request.contextPath}/home.do">Home</a>  /
            <span>Log-in</span>
        </div>
    </div>
</section>
<!-- Page top end-->


<!-- Contact page -->
<section class="contact-page">
    <div class="container">
<%--        <div class="map"><iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d14376.077865872314!2d-73.879277264103!3d40.757667781624285!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sbd!4v1546528920522" style="border:0" allowfullscreen></iframe></div>--%>
        
        <%-- 혹은 화면에 텍스트로 보여주고 싶다면 아래 주석을 푸세요 --%>
        <%-- 
        <c:if test="${not empty msg}">
            <div class="alert alert-danger" style="margin-bottom: 20px;">
                <strong>Error!</strong> ${msg}
            </div>
        </c:if> 
        --%>
    <!-- login form -->
    <div class="row">
            <div class="col-lg-7 order-2 order-lg-1">
            
            	<%-- login form --%>            	
                <form class="contact-form" action="${pageContext.request.contextPath}/member" method="post">
                    <input type="text"      name="id"  		placeholder="Your ID">
                    <input type="password"  name="password" placeholder="Your PASSWORD">
<%--                    <input type="text" placeholder="Subject">--%>
<%--                    <textarea placeholder="Message"></textarea>--%>
					<input type="hidden" 	name="action" 	value="login">
                    <button type="submit" 	class="site-btn">LOG-IN<img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></button>
                    <a href="${pageContext.request.contextPath}/member?action=joinForm" class="site-btn">
					    SIGN-IN
					    <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="arrow"/>
					</a>
                </form>
            </div>
            <div class="col-lg-5 order-1 order-lg-2 contact-text text-white">
                <h3 id="loginMsg">LOG-IN</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.....</p>
<%--                <div class="cont-info">--%>
<%--                    <div class="ci-icon"><img src="img/icons/location.png" alt=""></div>--%>
<%--                    <div class="ci-text">Main Str, no 23, New York</div>--%>
<%--                </div>--%>
<%--                <div class="cont-info">--%>
<%--                    <div class="ci-icon"><img src="img/icons/phone.png" alt=""></div>--%>
<%--                    <div class="ci-text">+546 990221 123</div>--%>
<%--                </div>--%>
<%--                <div class="cont-info">--%>
<%--                    <div class="ci-icon"><img src="img/icons/mail.png" alt=""></div>--%>
<%--                    <div class="ci-text">hosting@contact.com</div>--%>
<%--                </div>--%>
            </div>
        </div>
    </div>
</section>
<!-- Contact page end-->
<script>
    window.onload = function() {
        var msg = "${msg}";
        
        // 2. msg가 비어있지 않다면 (로그인 실패 시)
        if(msg !== "") {

        	document.querySelector('input[name="id"]').focus();
        	
            var titleElement = document.getElementById("loginMsg");
            
            // 원래 텍스트 저장 ("LOG-IN")
            var originalText = titleElement.innerText;
            
            //  
            titleElement.innerText = msg;
            titleElement.style.color = "#ff7f50 "; 
            titleElement.style.transition = "0.3s"; 
            
            // 2초만 표기
            setTimeout(function() {
                titleElement.innerText = originalText;
                titleElement.style.color = ""; 
            }, 2000);
        }
    };
</script>        
