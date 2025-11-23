<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 25. 11. 19.
  Time: 오후 4:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<section class="hero-section overflow-hidden">
    <div class="hero-slider owl-carousel">
        <div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" 
             data-setbg="${pageContext.request.contextPath}/assets/img/slider-bg-1.jpg">
            <div class="container">
                <h2>Tradeem!</h2>
                <p>Unlock Your Next Adventure. Instant Codes. Infinite Play.<br>Shall we go find the TREASURE?</p>
                 <c:choose>
                	<c:when test="${sessionScope.loginState == true}">
                		<a href="${pageContext.request.contextPath}/game?action=gameList" class="site-btn">Trade it!  
                		<img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                	</c:when>
                	<c:otherwise>
                		<a href="${pageContext.request.contextPath}/member?action=loginForm" class="site-btn">With Us!  
                		<img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                	</c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" 
             data-setbg="${pageContext.request.contextPath}/assets/img/slider-bg-2.jpg">
            <div class="container">
                <h2>Tradeem!</h2>
                <p>Unlock Your Next Adventure. Instant Codes. Infinite Play.<br>Shall we go find the TREASURE?</p>
                <c:choose>
                	<c:when test="${sessionScope.loginState == true}">
                		<a href="${pageContext.request.contextPath}/game?action=gameList" class="site-btn">Trade it!  
                		<img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                	</c:when>
                	<c:otherwise>
                		<a href="${pageContext.request.contextPath}/member?action=loginForm" class="site-btn">With Us!  
                		<img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                	</c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>
<section class="intro-section">
    <div class="container">
        <div class="row">
            <c:forEach var="game" items="${randomGames}">
                <div class="col-md-4 thum-trigger" data-gameno="${game.gameNo}">
                    <div class="intro-text-box text-box text-white">
                        <div class="top-meta">
                            <fmt:formatDate value="${game.relDate}" pattern="yyyy.MM.dd"/> / in <a href="">${game.genre}</a>
                        </div>
                        <h3>${game.gameNm}</h3>
                        <p>
                            <c:choose>
                                <c:when test="${fn:length(game.gameContent) > 60}">
                                    ${fn:substring(game.gameContent, 0, 60)}...
                                </c:when>
                                <c:otherwise>
                                    ${game.gameContent}
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/game?action=gameDetail&no=${game.gameNo}" class="read-more" >
                        	Read More <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/>
                        </a>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty randomGames}">
                <div class="col-12 text-white text-center">
                    <p>추천 게임을 불러올 수 없습니다.</p>
                </div>
            </c:if>
        </div>
    </div>
</section>
<section class="blog-section spad">
    <div class="container">
        <div class="row">
            <div class="col-xl-9 col-lg-8 col-md-7">
                <div class="section-title text-white">
                    <h2>Latest Games</h2>
                </div>

                <c:forEach var="game" items="${latestGames}" varStatus="status">
                    <div class="blog-item">
                        <div class="blog-thumb" style="width: 250px; length: 250px;">
                            <img src="${pageContext.request.contextPath}/assets/img/games/${game.gameNo}.png" alt="">
                        </div>
                        <div class="blog-text text-box text-white">
                            <div class="top-meta">
                                <fmt:formatDate value="${game.relDate}" pattern="yyyy.MM.dd"/> / in <a href="">${game.genre}</a>
                            </div>
                            <h3>${game.gameNm}</h3>
                            <p>
                                <c:choose>
                                    <c:when test="${fn:length(game.gameContent) > 100}">
                                        ${fn:substring(game.gameContent, 0, 100)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${game.gameContent}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a href="${pageContext.request.contextPath}/game?action=gameDetail&no=${game.gameNo}" class="read-more">Read More <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                        </div>
                    </div>
                </c:forEach>
                 <c:if test="${empty latestGames}">
                    <div class="text-white">최신 게임 정보가 없습니다.</div>
                 </c:if>
            </div>

            <div class="col-xl-3 col-lg-4 col-md-5 sidebar">
                <div id="stickySidebar">
                    <div class="widget-item">
                        <h4 class="widget-title">Trending</h4>
                        <div class="trending-widget">
                            <div class="tw-item">
                                <div class="tw-thumb">
                                    <img src="${pageContext.request.contextPath}/assets/img/blog-widget/1.jpg" alt="#">
                                </div>
                                <div class="tw-text">
                                    <div class="tw-meta">11.11.18 / in <a href="">Games</a></div>
                                    <h5>The best online game is out now!</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="intro-video-section set-bg d-flex align-items-end " 
         data-setbg="${pageContext.request.contextPath}/assets/img/promo-bg.jpg">
    <a href="https://www.youtube.com/watch?v=uFsGy5x_fyQ" class="video-play-btn video-popup">
        <img src="${pageContext.request.contextPath}/assets/img/icons/solid-right-arrow.png" alt="#">
    </a>
    <div class="container">
        <div class="video-text">
            <h2>Promo video of the game</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</p>
        </div>
    </div>
</section>
<section class="featured-section">
    <div class="featured-bg set-bg" data-setbg="${pageContext.request.contextPath}/assets/img/featured-bg.jpg"></div>
    <div class="featured-box">
        <div class="text-box">
            <div class="top-meta">11.11.18  /  in <a href="">Games</a></div>
            <h3>The game you’ve been waiting for is out now</h3>
            <p>Lorem ipsum dolor sit amet...</p>
            <a href="#" class="read-more">Read More  <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
        </div>
    </div>
</section>
<section class="newsletter-section">
    <div class="container">
        <h2>Subscribe to our newsletter</h2>
        <form class="newsletter-form">
            <input type="text" placeholder="ENTER YOUR E-MAIL">
            <button class="site-btn">subscribe  <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></button>
        </form>
    </div>
</section>
<style>
    #preview-box {
        position: absolute;
        display: none;    
        z-index: 9999;     
        border: 2px solid #fff;
        box-shadow: 0 0 10px rgba(0,0,0,0.5);
        background: #000;
        width: 150px;      
        pointer-events: none; 
    }
    #preview-box img {
        width: 100%;
        height: auto;
        display: block;
    }
</style>
	<div id="preview-box">
		<img src="" alt="Game Preview">
	</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 1. 필요한 요소들 선택
        const triggers = document.querySelectorAll('.thum-trigger');
        const previewBox = document.getElementById('preview-box');
        const previewImg = previewBox.querySelector('img');
        
        // 컨텍스트 경로 (JSP 변수를 JS 변수로 저장)
        const contextPath = "${pageContext.request.contextPath}";

        // 2. 모든 트리거(Read More 버튼)에 이벤트 연결
        triggers.forEach(trigger => {
            
            // 마우스 들어올 때 (보여주기)
            trigger.addEventListener('mouseenter', function() {
                const gameNo = this.getAttribute('data-gameno'); // 저장해둔 번호 가져오기
                
                // 이미지 경로 설정 (assets/img/games/번호.png)
                previewImg.src = contextPath + "/assets/img/games/" + gameNo + ".png";
                
                previewBox.style.display = 'block'; // 박스 보이기
            });

            // 마우스 움직일 때 (따라다니기)
            trigger.addEventListener('mousemove', function(e) {
                // 마우스 커서보다 조금 오른쪽 아래에 위치시킴 (15px, 15px)
                // pageX, pageY는 문서 전체 기준 좌표
                previewBox.style.left = (e.pageX + 15) + 'px';
                previewBox.style.top = (e.pageY + 15) + 'px';
            });

            // 마우스 나갈 때 (숨기기)
            trigger.addEventListener('mouseleave', function() {
                previewBox.style.display = 'none';
                previewImg.src = ""; // 이미지 초기화 (깜빡임 방지)
            });
        });
    });
</script>