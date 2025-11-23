<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 2025. 11. 19.
  Time: AM 09:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="page-top-section set-bg" data-setbg="${pageContext.request.contextPath}/assets/img/page-top-bg/1.jpg">
    <div class="page-info">
        <h2>Games</h2>
        <div class="site-breadcrumb">
            <a href="${pageContext.request.contextPath}/home.do">Home</a>  /
            <span>Games</span>
        </div>
    </div>
</section>

<section class="games-section">
    <div class="container">
        <div class="row">
            
            <div class="col-xl-7 col-lg-8 col-md-7">
                <div class="row">
                    <c:choose>
                        <%-- 데이터가 없을 때 --%>
                        <c:when test="${empty gameList}">
                            <div class="col-12">
                                <h4 style="color: white; text-align: center; padding: 50px;">
                                    등록된 게임이 없습니다.
                                </h4>
                            </div>
                        </c:when>
                        
                        <%-- 게임 데이터 반복 출력 (c:forEach) --%>
                        <c:otherwise>
                            <c:forEach var="game" items="${gameList}">
                                <div class="col-lg-4 col-md-6">
                                    <div class="game-item">
                                        <%-- 이미지: 게임번호.png --%>
                                        <img src="${pageContext.request.contextPath}/assets/img/games/${game.gameNo}.png" 
                                             alt="${game.gameNm}"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/img/games/default.png'">                                      
                                        
                                        <h5>${game.gameNm}</h5>
                                        
                                        <div style="color:#ffb320; font-size:14px; margin-bottom:10px;">
                                            ${game.genre} | ${game.costCoin} RD
                                        </div>
                                        
                                        <%-- 상세페이지 링크 --%>
                                        <a href="${pageContext.request.contextPath}/game?action=gameDetail&no=${game.gameNo}" class="read-more">
                                            Read More <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="site-pagination">
                    <c:if test="${curPage > 1}">
                        <a href="${pageContext.request.contextPath}/game?action=gameList&page=${curPage - 1}&genre=${selectedGenre}">&lt;</a>
                    </c:if>

                    <%-- 페이지 번호 --%>
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:choose>
                            <c:when test="${i == curPage}">
                                <a href="#" class="active">${i}.</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/game?action=gameList&page=${i}&genre=${selectedGenre}">${i}.</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <%-- > 버튼: 현재 페이지가 전체 페이지보다 작을 때만 표시 --%>
                    <c:if test="${curPage < totalPage}">
                        <a href="${pageContext.request.contextPath}/game?action=gameList&page=${curPage + 1}&genre=${selectedGenre}">&gt;</a>
                    </c:if>
                </div>
            </div>
            
            <%-- admin 권한일 때만 등록 버튼 표시 --%>
	        <c:if test="${sessionScope.member.memberNm == 'admin'}">
	            <div class="col-xl-3 col-lg-4 col-md-5 sidebar">
				    <div id="stickySidebar">
				            <div class="widget-item">
				                <a href="${pageContext.request.contextPath}/game?action=registerForm" class="site-btn" style="width: 100%; text-align: center;">
				                    + NEW GAME REGISTER</a>
				            </div>
				        <div class="widget-item">
				            <h4 class="widget-title">Trending</h4>
			            </div>
				    </div>
				</div>
	        </c:if>
            
            <div class="col-xl-3 col-lg-4 col-md-5 sidebar game-page-sideber">
                <div id="stickySidebar">
                    <div class="widget-item">
                        <div class="categories-widget">
                            <h4 class="widget-title">Genre</h4>
                            <ul>
                                <%-- genre=0 (전체보기) --%>
                                <li><a href="${pageContext.request.contextPath}/game?action=gameList">All Games</a></li>
                                
                                <%-- 장르별 번호 매핑 (1~6) --%>
                                <li><a href="${pageContext.request.contextPath}/game?action=gameList&genre=1">Online</a></li>
                                <li><a href="${pageContext.request.contextPath}/game?action=gameList&genre=2">Adventure</a></li>
                                <li><a href="${pageContext.request.contextPath}/game?action=gameList&genre=3">S.F.</a></li>
                                <li><a href="${pageContext.request.contextPath}/game?action=gameList&genre=4">Strategy</a></li>
                                <li><a href="${pageContext.request.contextPath}/game?action=gameList&genre=5">Racing</a></li>
                                <li><a href="${pageContext.request.contextPath}/game?action=gameList&genre=6">Shooter</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</section>