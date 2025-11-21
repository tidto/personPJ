<%--
  Created by IntelliJ IDEA.
  User: tidto
  Date: 2025. 11. 21.
  Time: AM 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RD Coin Charge</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"/>
<style>
    body { background-color: #212121; color: white; padding: 200px 30px 30px 30px; text-align: center; width: 600;}
    .charge-box { background: #363636; padding: 30px; border-radius: 10px; border: 1px solid #ffb320; }
    h3 { color: #ffb320; margin-bottom: 20px; }
    input { width: 100%; padding: 10px; margin-bottom: 15px; background: #4b4b4b; border: none; color: white; }
    label { display: block; text-align: left; color: #bbb; margin-bottom: 5px; }
    .guide { font-size: 12px; color: #888; margin-bottom: 15px; text-align: left; }
    .highlight { color: #ffb320; font-weight: bold; font-size: 1.1em;}
</style>
</head>
<body>

    <div class="container charge-box" id="cont">
        <h3>RD COIN CHARGE</h3>
        
        <form action="${pageContext.request.contextPath}/member" method="post">
            <input type="hidden" name="action" value="charge">
            
            <div>
                <label>User Name</label>
                <%-- 유저 이름은 자동으로 들어가지만 수정은 가능하게 (검증용) --%>
                <input type="text" name="name" value="${sessionScope.member.memberNm}" readonly style="background:#333; color:#888;">
            </div>
            
            <div>
                <label>Charge Amount (RD)</label>
                <%-- [변경] 자바스크립트에서 감지하기 위해 id="amountInput" 추가 --%>
                <input type="number" name="amount" id="amountInput" placeholder="충전할 금액을 입력하세요" min="100" step="100" required>
            </div>
            
            <div>
                <label>Verification</label>
                <%-- [변경] 실시간으로 변하는 문구가 들어갈 span 태그 추가 --%>
                <p class="guide">
                    * 아래 입력창에 <span id="targetText" class="highlight">${sessionScope.member.memberNm}charge</span> 라고 정확히 입력하세요.
                </p>
                <input type="text" name="checkString" placeholder="위의 문구를 그대로 입력하세요" required>
            </div>
            
            <button type="submit" class="site-btn">CHARGE NOW</button>
        </form>
    </div>

	<script>
	    const amountInput = document.getElementById('amountInput');
	    const targetText = document.getElementById('targetText');
	    
	    // JSP에서 세션에 있는 유저 이름을 가져옴
	    const userName = "${sessionScope.member.memberNm}"; 
	    
	    // [초기 상태 설정] 금액 입력 전에도 형식을 보여줌
	    targetText.innerText = userName + "/(금액)/charge";
	
	    // 금액 입력칸에 값이 변할 때마다 실행
	    amountInput.addEventListener('input', function() {
	        let amount = this.value;
	        
	        if(amount === "") {
	            // 금액이 비어있으면 안내 문구 표시
	            targetText.innerText = userName + "/(금액)/charge";
	        } else {
	            // [변경] 유저이름 + "/" + 금액 + "/" + charge 조합
	            targetText.innerText = userName + "/" + amount + "/charge";
	        }
	    });
	</script>
</body>
</html>