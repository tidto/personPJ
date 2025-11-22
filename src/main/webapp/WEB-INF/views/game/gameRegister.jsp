<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 2025. 11. 22.
  Time: AM 1:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<section class="page-top-section set-bg" data-setbg="${pageContext.request.contextPath}/assets/img/page-top-bg/4.jpg">
    <div class="page-info">
        <h2>ADMIN MODE</h2>
        <div class="site-breadcrumb">
            <a href="${pageContext.request.contextPath}/home.do">Home</a>  /
            <span>Game Register</span>
        </div>
    </div>
</section>

<section class="contact-page">
    <div class="container">
        <div class="row">
            <div class="col-lg-7 order-2 order-lg-1">
                
               <form class="contact-form" action="${pageContext.request.contextPath}/game?action=register" method="post" enctype="multipart/form-data">
				    
				    <input type="text" name="gameNm" placeholder="Game Name" required>
				    
				    <select name="genreNo" id="genreSelect" onchange="changeGenre()" class="custom-select" style="margin-bottom: 25px; border: none; background: #f0f0f0; height: 60px; width: 100%; padding-left: 20px; color: #666;">
				        <option value="1">online</option>
				        <option value="2">adventure</option>
				        <option value="3">S.F</option>
				        <option value="4">strategy</option>
				        <option value="5">racing</option>
				        <option value="6">shooter</option>
				    </select>
				    
				    <input type="hidden" name="genre" id="genreText" value="online">
				    
				    <input type="number" name="costCoin" placeholder="Price (Coin)" required>
				    <input type="text" name="gameVideo" placeholder="YouTube Video ID (e.g., uFsGy5x_fyQ)">
				    <textarea name="gameContent" placeholder="Game Description / Content" required style="height: 150px;"></textarea>
				    <div style="margin-bottom: 30px;">
				        <label style="color: #fff; display: block; margin-bottom: 10px;">Main Image (File name will be GameNo automatically)</label>
				        <input type="file" name="gameImg" accept="image/*" required style="padding-top: 15px;">
				    </div>
				
				    <button type="submit" class="site-btn">
				        REGISTER GAME <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/>
				    </button>
				</form>
            </div>
            
            <div class="col-lg-5 order-1 order-lg-2 contact-text text-white">
                <h3>GAME REGISTRATION</h3>
                <p>Register a new game product. The Image file will be automatically renamed to the Game ID.</p>
                <ul>
                    <li>Make sure the content is accurate.</li>
                    <li>Upload 16:9 ratio images for best display.</li>
                </ul>
            </div>
        </div>
    </div>
</section>

<script>
    function changeGenre() {
        var selectBox = document.getElementById("genreSelect");
        var selectedText = selectBox.options[selectBox.selectedIndex].text;
        document.getElementById("genreText").value = selectedText;
    }
</script>
