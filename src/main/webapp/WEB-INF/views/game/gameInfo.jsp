<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 2025. 11. 19.
  Time: AM 9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- Page top section -->
<section class="page-top-section set-bg" data-setbg="${pageContext.request.contextPath}/assets/img/page-top-bg/1.jpg">
    <div class="page-info">
        <h2>Games</h2>
        <div class="site-breadcrumb">
            <a href="${pageContext.request.contextPath}/home.do">Home</a>  /
            <span>Game Detail</span>
        </div>
    </div>
</section>
<!-- Page top end-->

<!-- Games section -->
<section class="games-single-page">
    <div class="container">
        <!-- [1] 상단 게임 타이틀 -->
        <div class="game-single-preview">
        </div>

        <div class="row">
            <!-- [2] 왼쪽 컨텐츠 영역 -->
            <div class="col-xl-9 col-lg-8 col-md-7 game-single-content">
                <div class="gs-meta">
                    <fmt:formatDate value="${game.relDate}" pattern="yyyy.MM.dd"/>  /  in <a href="">${game.genre}</a>
                </div>
                
                <h2 class="gs-title">${game.gameNm}</h2>
                <div class="embed-responsive embed-responsive-16by9" style="margin-bottom: 30px;">
                <c:choose>
                    <c:when test="${not empty game.gameVideo}">
                        <iframe class="embed-responsive-item" 
                                src="${game.gameVideo}" 
                                title="YouTube video player" frameborder="0" 
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
                                allowfullscreen></iframe>
                    </c:when>
                    <c:otherwise>
                        <!-- 영상이 없을 경우 대체 이미지 표시 -->
                        <img src="${pageContext.request.contextPath}/assets/img/games/${game.gameNo}.png" alt="Video Placeholder"
                             style="width:100%; height: 500px; object-fit: cover;">
                    </c:otherwise>
                </c:choose>
            </div>
                <h4>Gameplay & Description</h4>
                
                
                <!-- 줄바꿈 처리를 위해 pre 태그 스타일 적용 또는 JSTL replace 필요하지만 일단 출력 -->
                <p>${game.gameContent}</p>
                
                <div class="geme-social-share pt-5 d-flex">
                    <p>Share:</p>
                    <a href="#"><i class="fa fa-pinterest"></i></a>
                    <a href="#"><i class="fa fa-facebook"></i></a>
                    <a href="#"><i class="fa fa-twitter"></i></a>
                    <a href="#"><i class="fa fa-dribbble"></i></a>
                    <a href="#"><i class="fa fa-behance"></i></a>
                </div>
            </div>
            
            <!-- [3] 오른쪽 사이드바 (이미지 + 가격/구매 로직) -->
            <div class="col-xl-3 col-lg-4 col-md-5 sidebar game-page-sideber">
                <div id="stickySidebar">
                    <div class="widget-item">
                        <div class="rating-widget">
                            <h4 class="widget-title">Game Info</h4>
                            
                            <!-- 게임 이미지 -->
                            <div style="margin-bottom: 20px;">
                                <img src="${pageContext.request.contextPath}/assets/img/games/${game.gameNo}.png" 
                                     alt="${game.gameNm}" style="width: 100%; border-radius: 5px;">
                            </div>

                            <ul>
                                <li>Genre<span>${game.genre}</span></li>
                                
                                <!-- 가격 표시 로직 -->
                                <li>Price
                                    <c:choose>
                                        <%-- 로그인 상태일 때 --%>
                                        <c:when test="${sessionScope.loginState == true}">
                                            <c:set var="myCoin" value="${sessionScope.member.rdCoin}" />
                                            <c:set var="price" value="${game.costCoin}" />
                                            
                                            <c:choose>
                                                <%-- 돈이 충분할 때: 녹색 --%>
                                                <c:when test="${myCoin >= price}">
                                                    <span style="color: #4cd137; font-weight: bold;">${price} RD</span>
                                                </c:when>
                                                <%-- 돈이 부족할 때: 빨간색 + 충전 버튼 --%>
                                                <c:otherwise>
                                                    <span style="color: #ff5555; font-weight: bold;">
                                                        ${price} RD 
                                                        <a href="javascript:openChargeWindow()" title="충전하러 가기" style="margin-left:5px; color: #ffb320;">
                                                            <i class="fa fa-plus-circle"></i>
                                                        </a>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        
                                        <%-- 비로그인 상태 --%>
                                        <c:otherwise>
                                            <span>${game.costCoin} RD</span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>
                            
                            <div class="rating" style="text-align: center; margin-top: 20px;">
							    <c:choose>
							        <%-- [1] 로그인 상태 확인 --%>
							        <c:when test="${sessionScope.loginState == true}">
							            <c:choose>
							                <%-- [1-1] 관리자(admin)일 경우: 수정, 삭제 버튼 --%>
							                <c:when test="${sessionScope.member.memberNm == 'admin'}">
							                    <a href="${pageContext.request.contextPath}/game?action=updateForm&no=${game.gameNo}" class="site-btn btn-warning">
							                        GAME MODIFY
							                    </a>
							                    <a href="javascript:void(0);" onclick="if(confirm('정말 삭제하시겠습니까?')){ location.href='${pageContext.request.contextPath}/game?action=delete&no=${game.gameNo}'; }" class="site-btn btn-danger" style="background-color: #d9534f;">
							                        GAME DELETE
							                    </a>
							                </c:when>
							
							                <%-- [1-2] 일반 유저일 경우: 코인 잔액 확인 로직 시작 --%>
							                <c:otherwise>
							                    <c:choose>
							                        <%-- [1-2-A] 잔액 충분 --%>
							                        <c:when test="${sessionScope.member.rdCoin >= game.costCoin}">
							                            <button class="site-btn" style="width: 100%; margin-bottom: 10px;"
							                            	>BUY NOW</button>
							                            <button class="site-btn" style="width: 100%; background: #4b4b4b;"
							                            	onclick="location.href='${pageContext.request.contextPath}/game?action=addToCart&no=${game.gameNo}'">ADD TO CART</button>
							                        </c:when>
							                        
							                        <%-- [1-2-B] 잔액 부족 --%>
							                        <c:otherwise>
							                            <button class="site-btn" style="width: 100%; margin-bottom: 10px; opacity: 0.5; cursor: not-allowed;" disabled
							                            	onclick="location.href='${pageContext.request.contextPath}/game?action=buy&type=direct&no=${game.gameNo}'">BUY NOW</button>
							                            <button class="site-btn" style="width: 100%; background: #4b4b4b;"
							                            	onclick="location.href='${pageContext.request.contextPath}/game?action=addToCart&no=${game.gameNo}'">ADD TO CART</button>
							                            <div style="margin-top: 10px; font-size: 12px; color: #ff5555;">
							                                * 잔액이 부족합니다.
							                            </div>
							                        </c:otherwise>
							                    </c:choose>
							                    <%-- // 코인 확인 종료 --%>
							                </c:otherwise>
							            </c:choose>
							        </c:when>
							
							        <%-- [2] 비로그인 상태 --%>
							        <c:otherwise>
							            <a href="${pageContext.request.contextPath}/member?action=loginForm" class="site-btn" style="width: 100%;">LOGIN TO BUY</a>
							        </c:otherwise>
							    </c:choose>
							</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Games end-->

<!-- 충전 팝업 스크립트 (재사용) -->
<script>
    function openChargeWindow() {
        var width = 800;
        var height = 600;
        var left = (window.screen.width / 2) - (width / 2);
        var top = (window.screen.height / 2) - (height / 2);
        
        var options = 'width=' + width + ',height=' + height + 
                      ',top=' + top + ',left=' + left + 
                      ',resizable=no, scrollbars=yes' + 
                      ',toolbar=no, menubar=no, location=no, status=no';
        
        window.open(
            '${pageContext.request.contextPath}/member?action=chargeForm', 
            'chargeWindow', 
            options
        );
    }
</script>