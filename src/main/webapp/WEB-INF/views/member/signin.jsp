<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 2025. 11. 19.
  Time: AM 9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="page-top-section set-bg" data-setbg="${pageContext.request.contextPath}/assets/img/page-top-bg/4.jpg">
    <div class="page-info">
        <h2>JOIN US</h2>
        <div class="site-breadcrumb">
            <a href="${pageContext.request.contextPath}/home.do">Home</a>  /
            <span>Register</span>
        </div>
    </div>
</section>
<section class="contact-page">
    <div class="container">
    
    <div class="row">
            <div class="col-lg-7 order-2 order-lg-1">
            
            	<%-- Register form --%>            	
                <form class="contact-form" action="${pageContext.request.contextPath}/member" method="post">
                    
                    <input type="text" name="id" id="userId" placeholder="Create ID" required>
                    <div id="idCheckMsg" style="margin-top: -20px; margin-bottom: 20px; font-size: 14px; font-weight: bold; min-height: 20px;"></div>
                    <input type="password"  name="password" placeholder="Create PASSWORD" required>
                    <input type="text"      name="name"     placeholder="Your Nickname" required>
                    <input type="hidden" 	name="action" 	value="join">
                    <button type="submit" id="submitBtn" class="site-btn" disabled>
                        SIGN-UP
                        <img src="${pageContext.request.contextPath}/assets/img/icons/double-arrow.png" alt="#"/>
                    </button>
                    
                </form>
            </div>
            
            <div class="col-lg-5 order-1 order-lg-2 contact-text text-white">
                <h3 id="joinMsg">REGISTER</h3>
                <p>Join our community today! Create an account to manage your games, bills, and enjoy exclusive content. It only takes a few seconds.</p>
            </div>
        </div>
    </div>
</section>

<script>
    // [통합 스크립트]
    
    // 1. 변수 선언
    const idInput = document.getElementById('userId');
    const msgDiv = document.getElementById('idCheckMsg');
    const submitBtn = document.getElementById('submitBtn');

    // 2. 아이디 입력 시 실시간 AJAX 체크 (keyup 이벤트)
    idInput.addEventListener('keyup', function() {
        let idValue = idInput.value;

        // 2-1. 아이디가 너무 짧으면(4글자 미만) 검사 중단
        if(idValue.length < 4) {
            msgDiv.innerText = "⚠ 아이디는 4글자 이상 입력해주세요.";
            msgDiv.style.color = "#ff5555"; // 빨간색
            submitBtn.disabled = true;      // 버튼 잠금
            return;
        }

        // 2-2. AJAX 비동기 요청 보내기
        fetch('${pageContext.request.contextPath}/member?action=checkId&id=' + idValue)
            .then(response => response.text())
            .then(result => {
                // Controller가 "fail" 혹은 "success" 문자열을 보낸다고 가정
                if(result.trim() === 'fail') {
                    // [중복]
                    msgDiv.innerText = "❌ 이미 사용 중인 아이디입니다.";
                    msgDiv.style.color = "#ff5555"; // 빨간색
                    submitBtn.disabled = true;      // 버튼 잠금
                } else {
                    // [사용 가능]
                    msgDiv.innerText = "✅ 사용 가능한 아이디입니다.";
                    msgDiv.style.color = "#4cd137"; // 녹색
                    submitBtn.disabled = false;     // 버튼 잠금 해제!
                }
            })
            .catch(err => console.error(err));
    });

    // 3. 페이지 로드 시 실행
    window.onload = function() {
        // (1) 페이지 열리자마자 ID 입력창에 포커스
        if(idInput) idInput.focus();

        // (2) Controller에서 보낸 실패 메시지(msg) 확인
        // 성공 시에는 로그인 페이지로 이동하므로, 이 페이지에 msg가 있다는 건 "실패"했다는 뜻입니다.
        var msg = "${msg}";
        
        if(msg !== "") {
            var titleElement = document.getElementById("joinMsg");
            
            // 원래 텍스트("REGISTER") 저장
            var originalText = titleElement.innerText;
            
            // 에러 메시지로 변경 및 빨간색 효과
            titleElement.innerText = msg;
            titleElement.style.color = "#ff7f50 "; 
            titleElement.style.transition = "0.3s"; 
            
            // 2초 뒤에 원래 텍스트("REGISTER")와 원래 색상으로 복구
            setTimeout(function() {
                titleElement.innerText = originalText;
                titleElement.style.color = ""; 
            }, 2000);
        }
    };
</script>