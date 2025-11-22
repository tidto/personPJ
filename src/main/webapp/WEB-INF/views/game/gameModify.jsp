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
            <span>Game Modify</span>
        </div>
    </div>
</section>

<section class="contact-page">
    <div class="container">
        <div class="row">
            <div class="col-lg-7 order-2 order-lg-1">
                
                <form class="contact-form" action="${pageContext.request.contextPath}/game?action=update" method="post" enctype="multipart/form-data">
                    
                    <input type="hidden" name="gameNo" value="${game.gameNo}">
                    
                    <input type="hidden" name="genre" id="genreText" value="${game.genre}">

                    <input type="text" name="gameNm" placeholder="Game Name" value="${game.gameNm}" required>
                    
                    <select name="genreNo" id="genreSelect" onchange="changeGenre()" class="custom-select" 
                            style="margin-bottom: 25px; border: none; background: #f0f0f0; height: 60px; width: 100%; padding-left: 20px; color: #666;">
                        <option value="1" <c:if test="${game.genreNo == 1}">selected</c:if>>Online</option>
                        <option value="2" <c:if test="${game.genreNo == 2}">selected</c:if>>Adventure</option>
                        <option value="3" <c:if test="${game.genreNo == 3}">selected</c:if>>SF</option>
                        <option value="4" <c:if test="${game.genreNo == 4}">selected</c:if>>Strategy</option>
                        <option value="5" <c:if test="${game.genreNo == 5}">selected</c:if>>Racing</option>
                        <option value="6" <c:if test="${game.genreNo == 6}">selected</c:if>>Shooter</option>
                    </select>

                    <input type="number" name="costCoin" placeholder="Price (Coin)" value="${game.costCoin}" required>
                    
                    <input type="text" name="gameVideo" placeholder="YouTube Video ID" value="${game.gameVideo}">

                    <textarea name="gameContent" placeholder="Game Description" required style="height: 150px;">${game.gameContent}</textarea>
                    
                    <div style="margin-bottom: 30px;">
                        <label style="color: #fff; display: block; margin-bottom: 10px;">Current Image</label>
                        <img src="${pageContext.request.contextPath}/assets/img/games/${game.gameNo}.png" 
                             alt="Current Image" style="width: 150px; margin-bottom: 15px; border: 2px solid #fff;">
                        
                        <label style="color: #ccc; display: block; margin-bottom: 10px; font-size: 0.9em;">
                            * Upload new file only if you want to change it.
                        </label>
                        <input type="file" name="gameImg" accept="image/*" style="padding-top: 15px;">
                    </div>

                    <button type="submit" class="site-btn">
                        MODIFY COMPLETE <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/>
                    </button>
                    
                    <a href="${pageContext.request.contextPath}/game?action=gameDetail&no=${game.gameNo}" class="site-btn" style="background: #444; margin-left: 10px;">CANCEL</a>
                </form>
            </div>
            
            <div class="col-lg-5 order-1 order-lg-2 contact-text text-white">
                <h3>GAME MODIFICATION</h3>
                <p>Update the game information. If you upload a new image, the previous image will be overwritten.</p>
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

