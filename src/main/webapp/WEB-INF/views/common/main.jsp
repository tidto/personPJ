<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 25. 11. 19.
  Time: 오후 4:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="hero-section overflow-hidden">
    <div class="hero-slider owl-carousel">
        <div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" 
             data-setbg="${pageContext.request.contextPath}/assets/img/slider-bg-1.jpg">
            <div class="container">
                <h2>Tradeem!</h2>
                <p>Unlock Your Next Adventure. Instant Codes. Infinite Play.<br>Shall we go find the TREASURE?</p>
                <a href="#" class="site-btn">Read More  <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
            </div>
        </div>
        <div class="hero-item set-bg d-flex align-items-center justify-content-center text-center" 
             data-setbg="${pageContext.request.contextPath}/assets/img/slider-bg-2.jpg">
            <div class="container">
                <h2>Tradeem!</h2>
                <p>Unlock Your Next Adventure. Instant Codes. Infinite Play.<br>Shall we go find the TREASURE?</p>
                <a href="#" class="site-btn">Read More  <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
            </div>
        </div>
    </div>
</section>
<section class="intro-section">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="intro-text-box text-box text-white">
                    <div class="top-meta">11.11.18  /  in <a href="">Games</a></div>
                    <h3>The best online game is out now!</h3>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit...</p>
                    <a href="#" class="read-more">Read More  <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="intro-text-box text-box text-white">
                    <div class="top-meta">11.11.18  /  in <a href="">Playstation</a></div>
                    <h3>Top 5 best games in november</h3>
                    <p>Ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod...</p>
                    <a href="#" class="read-more">Read More  <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="intro-text-box text-box text-white">
                    <div class="top-meta">11.11.18  /  in <a href="">Reviews</a></div>
                    <h3>Get this game at a promo price</h3>
                    <p>Sit amet, consectetur adipiscing elit, sed do eiusmod tempor...</p>
                    <a href="#" class="read-more">Read More  <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="blog-section spad">
    <div class="container">
        <div class="row">
            <div class="col-xl-9 col-lg-8 col-md-7">
                <div class="section-title text-white">
                    <h2>Latest News</h2>
                </div>
                <ul class="blog-filter">
                    <li><a href="#">Racing</a></li>
                    <li><a href="#">Shooters</a></li>
                    <li><a href="#">Strategy</a></li>
                    <li><a href="#">Online</a></li>
                </ul>
                
                <div class="blog-item">
                    <div class="blog-thumb">
                        <img src="${pageContext.request.contextPath}/assets/img/blog/1.jpg" alt="">
                    </div>
                    <div class="blog-text text-box text-white">
                        <div class="top-meta">11.11.18  /  in <a href="">Games</a></div>
                        <h3>The best online game is out now!</h3>
                        <p>Lorem ipsum dolor sit amet...</p>
                        <a href="#" class="read-more">Read More  <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                    </div>
                </div>
                <div class="blog-item">
                    <div class="blog-thumb">
                        <img src="${pageContext.request.contextPath}/assets/img/blog/2.jpg" alt="">
                    </div>
                    <div class="blog-text text-box text-white">
                         <div class="top-meta">11.11.18  /  in <a href="">Games</a></div>
                        <h3>The best online game is out now!</h3>
                        <p>Lorem ipsum dolor sit amet...</p>
                        <a href="#" class="read-more">Read More  <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                    </div>
                </div>
                <div class="blog-item">
                    <div class="blog-thumb">
                        <img src="${pageContext.request.contextPath}/assets/img/blog/3.jpg" alt="">
                    </div>
                    <div class="blog-text text-box text-white">
                         <div class="top-meta">11.11.18  /  in <a href="">Games</a></div>
                        <h3>The best online game is out now!</h3>
                        <p>Lorem ipsum dolor sit amet...</p>
                        <a href="#" class="read-more">Read More  <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/></a>
                    </div>
                </div>
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
                                    <div class="tw-meta">11.11.18  /  in <a href="">Games</a></div>
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