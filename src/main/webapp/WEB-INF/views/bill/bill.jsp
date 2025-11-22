<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 2025. 11. 23.
  Time: AM 2:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
    /* 배경 투명화 */
    .bill-section { background: transparent !important; }
    
    /* 영수증 카드 디자인 */
    .bill-card {
        background: rgba(0, 0, 0, 0.6); /* 반투명 검정 */
        border: 1px solid #452c8a;      /* 테마 보라색 테두리 */
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        transition: 0.3s;
    }
    .bill-card:hover {
        background: rgba(0, 0, 0, 0.8);
        border-color: #e74c3c; /* 호버 시 빨간색 강조 */
    }

    /* 게임 이미지 */
    .bill-img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 5px;
        border: 2px solid #555;
        margin-right: 25px;
    }

    /* 정보 영역 */
    .bill-info { flex-grow: 1; }
    .bill-info h4 { color: #fff; margin-bottom: 5px; }
    .bill-date { color: #aaa; font-size: 13px; margin-bottom: 10px; }

    /* 리딤코드 영역 (비밀 효과) */
    .code-wrapper {
        background: #111;
        padding: 10px 15px;
        border-radius: 5px;
        display: inline-flex;
        align-items: center;
        border: 1px dashed #444;
    }
    
    .secret-code {
        color: #2ecc71; /* 코드 색상 (녹색) */
        font-family: 'Courier New', Courier, monospace;
        font-weight: bold;
        font-size: 16px;
        letter-spacing: 2px;
        margin-right: 15px;
        
        /* [핵심] 블러 효과로 가리기 */
        filter: blur(5px);
        -webkit-filter: blur(5px);
        transition: 0.3s;
        cursor: pointer;
        user-select: none; /* 드래그 방지 */
    }

    /* 마우스를 올렸을 때 보이게 함 */
    .code-wrapper:hover .secret-code {
        filter: blur(0);
        -webkit-filter: blur(0);
    }
    
    /* 복사 버튼 */
    .copy-btn {
        background: #333;
        border: 1px solid #555;
        color: #fff;
        font-size: 12px;
        padding: 2px 8px;
        border-radius: 3px;
        cursor: pointer;
    }
    .copy-btn:hover { background: #fff; color: #000; }

    /* 가격 */
    .bill-price {
        font-size: 20px;
        font-weight: bold;
        color: #e74c3c;
        min-width: 100px;
        text-align: right;
    }
</style>

<section class="page-top-section set-bg" data-setbg="${pageContext.request.contextPath}/assets/img/page-top-bg/2.jpg">
    <div class="page-info">
        <h2>Bill & Inventory</h2>
        <div class="site-breadcrumb">
            <a href="${pageContext.request.contextPath}/home.do">Home</a>  /
            <span>My Games</span>
        </div>
    </div>
</section>

<section class="games-section spad text-white">
    <div class="container">
        
        <div class="mb-5 text-center">
            <h3>Purchase History</h3>
            <p style="color: #ccc;">Hover over the hidden box to reveal your Redeem Code.</p>
        </div>

        <div class="row">
            <div class="col-lg-10 offset-lg-1">
                
                <c:forEach var="bill" items="${billList}">
                    <div class="bill-card">
                        <img src="${pageContext.request.contextPath}/assets/img/games/${bill.gameNo}.png" 
                             alt="${bill.gameNm}" class="bill-img"
                             onerror="this.src='${pageContext.request.contextPath}/assets/img/games/default.png'">
                        
                        <div class="bill-info">
                            <h4>${bill.gameNm}</h4>
                            <div class="bill-date">
                                Date: <fmt:formatDate value="${bill.purchaseDate}" pattern="yyyy-MM-dd HH:mm:ss"/> 
                                | Order ID: #${bill.gameNo}
                            </div>
                            
                            <div class="code-wrapper" title="Hover to reveal code">
                                <span class="text-muted mr-2" style="font-size: 12px;">CODE:</span>
                                
                                <span class="secret-code" id="code_${bill.redeemCode}">${bill.redeemCode}</span>
                                
                                <button type="button" class="copy-btn" onclick="copyToClipboard('${bill.redeemCode}')">COPY</button>
                            </div>
                        </div>
                        
                        <div class="bill-price">
                            -${bill.costCoin} C
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty billList}">
                    <div class="text-center" style="padding: 50px; background: rgba(0,0,0,0.5); border-radius: 10px;">
                        <h4>No purchase history found.</h4>
                        <a href="${pageContext.request.contextPath}/game?action=gameList" class="site-btn mt-3" style= "color: #000;">GO TO SHOP</a>
                    </div>
                </c:if>

            </div>
        </div>
    </div>
</section>

<script>
    function copyToClipboard(text) {
        // 최신 브라우저 API 사용
        if (navigator.clipboard) {
            navigator.clipboard.writeText(text).then(() => {
                alert("Code copied : " + text);
            }).catch(err => {
                console.error('Failed to copy: ', err);
            });
        } else {
            var textArea = document.createElement("textarea");
            textArea.value = text;
            document.body.appendChild(textArea);
            textArea.select();
            document.execCommand("Copy");
            textArea.remove();
            alert("Code copied : " + text);
        }
    }
</script>