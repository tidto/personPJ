<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 2025. 11. 23.
  Time: AM 1:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
    /* 장바구니 섹션 배경 투명화 및 글자색 흰색 고정 */
    .cart-section, .cart-table, .cart-total {
        background: transparent !important;
    }
    
    /* 테이블 테두리 색상 조정 (어두운 테마에 맞게) */
    .cart-table table, .cart-table th, .cart-table td {
        border-color: rgba(255, 255, 255, 0.1) !important;
    }
    
    /* 수량/가격 폰트 크기 및 색상 */
    .price-col {
        color: #e74c3c !important; /* 포인트 컬러(빨강) 유지 */
        font-size: 18px;
        font-weight: 700;
    }
</style>

<section class="page-top-section set-bg" data-setbg="${pageContext.request.contextPath}/assets/img/page-top-bg/3.jpg">
    <div class="page-info">
        <h2>Your Cart</h2>
        <div class="site-breadcrumb">
            <a href="${pageContext.request.contextPath}/home.do">Home</a>  /
            <span>Cart</span>
        </div>
    </div>
</section>

<section class="games-section spad text-white">
    <div class="container">
        <form action="${pageContext.request.contextPath}/game?action=buy&type=cart" method="post" id="cartForm">
            
            <div class="cart-table">
                <table>
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="checkAll" checked></th>
                            <th class="product-th text-white"><h2>Product</h2></th>
                            <th class="text-white"><h3>Price</h3></th>
                            <th class="text-white" style="text-align: center;"><h3>Del</h3></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cart" items="${cartList}">
                            <tr>
                                <td>
                                    <input type="checkbox" name="checkItem" class="cart-item-check" 
                                           value="${cart.cartNo}" data-price="${cart.costCoin}" checked>
                                </td>
                                <td class="product-col"> 
                                    <img src="${pageContext.request.contextPath}/assets/img/games/${cart.gameNo}.png" alt=""
                                         onerror="this.src='${pageContext.request.contextPath}/assets/img/games/default.png'"
                                         style="width: 80px; height: 80px; object-fit: cover; border-radius: 5px;">
                                    <div class="pc-title">
                                        <h4 class="text-white">${cart.gameNm}</h4>
                                    </div>
                                </td>
                                <td class="price-col" style="padding-right:30px;">${cart.costCoin} C</td>
                                <td class="product-close">
                                    <a href="${pageContext.request.contextPath}/game?action=deleteCart&cartNo=${cart.cartNo}" 
                                       class="site-btn btn-sm" style="background:#ff5555;  padding: 5px 0; color: #000; ">X</a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty cartList}">
                            <tr><td colspan="4" class="text-center text-white" style="padding: 50px; margin-left: 30px;">Your cart is empty.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
            <div class="row">
                <div class="col-lg-4 offset-lg-8">
                    <div class="cart-total">
                        <h3 class="text-white">Cart Total</h3>
                        <ul style="padding: 0; list-style: none;">
                            <li class="d-flex justify-content-between text-white mb-2">
                                <span>My Coin</span>
                                <span style="color: #2ecc71; font-weight: bold;">${sessionScope.member.rdCoin} C</span>
                            </li>
                            <li class="d-flex justify-content-between text-white" style="font-size: 1.2em; font-weight: bold;">
                                <span>Total Cost</span>
                                <span style="color: #e74c3c;"><span id="totalPrice">0</span> C</span>
                            </li>
                        </ul>
                        
                        <button type="submit" id="checkoutBtn" class="site-btn" style="width: 100%; margin-top: 20px;">CHECKOUT</button>
                        
                        <div id="balanceMsg" style="display:none; margin-top: 15px; text-align: center;">
                            <p style="color: #ff5555; font-size: 13px;">*  Lost, your RD Coin! </p>
                            <button type="button" onclick="openCharge()" class="site-btn btn-sm" style="background: #2ecc71; width: 100%;">CHARGE COIN</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>

<script>
    function openCharge() {
        var width = 500; var height = 600;
        var left = (window.screen.width - width) / 2;
        var top = (window.screen.height - height) / 2;
        window.open('${pageContext.request.contextPath}/member?action=chargeForm', 'ChargeCoin', 
                    'width='+width+', height='+height+', top='+top+', left='+left);
    }

    document.addEventListener("DOMContentLoaded", function() {
        const checkAll = document.getElementById('checkAll');
        const checkItems = document.querySelectorAll('.cart-item-check');
        const totalPriceEl = document.getElementById('totalPrice');
        const checkoutBtn = document.getElementById('checkoutBtn');
        const balanceMsg = document.getElementById('balanceMsg');
        
        const myCoin = ${sessionScope.member.rdCoin};

        function calcTotal() {
            let total = 0;
            let checkedCount = 0;
            
            checkItems.forEach(function(cb) {
                if(cb.checked) {
                    total += parseInt(cb.getAttribute('data-price'));
                    checkedCount++;
                }
            });

            totalPriceEl.innerText = total;

            // 버튼 상태 제어
            if(checkedCount === 0) {
                checkoutBtn.disabled = true;
                checkoutBtn.style.opacity = "0.5";
                checkoutBtn.style.cursor = "not-allowed";
                balanceMsg.style.display = 'none';
            } else if(total > myCoin) {
                checkoutBtn.disabled = true;
                checkoutBtn.style.opacity = "0.5";
                checkoutBtn.style.cursor = "not-allowed";
                balanceMsg.style.display = 'block';
            } else {
                checkoutBtn.disabled = false;
                checkoutBtn.style.opacity = "1";
                checkoutBtn.style.cursor = "pointer";
                balanceMsg.style.display = 'none';
            }
        }

        if(checkAll) {
            checkAll.addEventListener('change', function() {
                checkItems.forEach(cb => cb.checked = this.checked);
                calcTotal();
            });
        }

        checkItems.forEach(cb => {
            cb.addEventListener('change', function() {
                if(!this.checked && checkAll) checkAll.checked = false;
                calcTotal();
            });
        });

        calcTotal();
    });
</script>