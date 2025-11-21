//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 20.
//  Time: PM 11:30
//  To change this template use File | Settings | File Templates.
//
package tradeem.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tradeem.member.dto.Member;
import tradeem.member.service.MemberService;

@WebServlet("/member")
public class MemberController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MemberService memberService = MemberService.getInstance();

    public MemberController() { super(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        
        String action = request.getParameter("action");
        
        // action 없이 /member 로만 들어왔을 때 main으로
        if(action == null || action.equals("")) {
            action = "main"; 
        }
        
        String viewPage = "/WEB-INF/views/home.jsp"; 
        String contentPage = ""; 
        String contextPath = request.getContextPath();
        
        HttpSession session = request.getSession();
        boolean isRedirect = false;
        String redirectUrl = "";

        switch (action) {
            case "main":

            	isRedirect = true;
                redirectUrl = contextPath + "/home.do";
                break;

            // 로그인
            case "loginForm": // action=loginForm
                contentPage = "/WEB-INF/views/member/login.jsp";
                break;
                
            case "login": 
                String loginId = request.getParameter("id");
                String loginPw = request.getParameter("password");
                
                Member loginMember = memberService.login(loginId, loginPw);
                
                if (loginMember != null) {
                    session.setAttribute("loginState", true);    
                    session.setAttribute("member", loginMember); 
                    isRedirect = true;
                    redirectUrl = contextPath + "/home.do"; 
                } else {
                    request.setAttribute("msg", "ID/PW Error!");
                    contentPage = "/WEB-INF/views/member/login.jsp";
                }
                break;
                
            case "logout": // action=logout
                session.invalidate();
                isRedirect = true;
                redirectUrl = contextPath + "/home.do";
                break;

            // 회원가입
            case "joinForm": // action=joinForm
                contentPage = "/WEB-INF/views/member/signin.jsp";
                break;
                
            case "join": // action=join
                String joinId = request.getParameter("id");
                String joinPw = request.getParameter("password");
                String joinNm = request.getParameter("name");
                
                // dao id 단일검색 t/f 
                boolean isExist = memberService.isIdExist(joinId);
                
                if(isExist) {
                    // 
                    request.setAttribute("msg", "이미 존재하는 아이디입니다.");
                    contentPage = "/WEB-INF/views/member/signin.jsp";
                    
                    // request.setAttribute("id", joinId);
                    // request.setAttribute("name", joinNm);
                } 
                else {
                    // 아이디가 없을 때만 가입 진행
                    Member joinDto = new Member(joinId, joinPw, joinNm);
                    int joinResult = memberService.join(joinDto);
                    
                    if (joinResult > 0) {
                        session.setAttribute("msg", "Welcome! Successfully signed up!"); 
                        isRedirect = true;
                        redirectUrl = contextPath + "/member?action=loginForm"; 
                    } else {
                        request.setAttribute("msg", "가입 실패 (member_id 무결성 오류)");
                        contentPage = "/WEB-INF/views/member/signin.jsp"; 
                    }
                }
                break;
            case "checkId":
                String checkId = request.getParameter("id");
                boolean isIdExist = memberService.isIdExist(checkId);
                
                response.setContentType("text/plain; charset=UTF-8");
                
                if(isIdExist) {
                    // 중복됨
                    response.getWriter().write("fail");
                } else {
                    // 사용가능
                    response.getWriter().write("success");
                }
                return; 
                
            case "chargeForm":
                contentPage = "/WEB-INF/views/member/charge.jsp";
                break;

            case "charge":
                String inputName = request.getParameter("name");
                String inputAmount = request.getParameter("amount");
                String inputCheck = request.getParameter("checkString"); 
                
                // 멤버 정보 조회
                Member currentMember = (Member) session.getAttribute("member");
                response.setContentType("text/html; charset=UTF-8");
                java.io.PrintWriter out = response.getWriter();
                
                // 세션 종료 시 처리
                if(currentMember == null) {
                    out.print("<script>alert('로그인 필요'); window.close();</script>");
                    return;
                }

                String expectedString = currentMember.getMemberNm() + "/" + inputAmount + "/charge";
                
                // 확인 문구 체크
                boolean isCorrect = expectedString.equals(inputCheck);
                
                if(isCorrect) {

                	int amount = Integer.parseInt(inputAmount);
                    int result = memberService.chargeCoin(currentMember.getMemberId(), amount);
                    
                    if(result > 0) {

                    	Member updatedMember = memberService.getMember(currentMember.getMemberId());
                        session.setAttribute("member", updatedMember);
                        out.print("<script>alert('충전 완료!'); opener.location.reload(); window.close();</script>");
                    } else {
                        out.print("<script>alert('DB 오류'); history.back();</script>");
                    }
                } else {
                    // 검증 실패 메시지
                    out.print("<script>alert('입력하신 문구가 일치하지 않습니다.\\n(" + expectedString + ")을 입력해야 합니다.'); history.back();</script>");
                }
                return;

            default:
                contentPage = "/WEB-INF/views/error/404.jsp";
                break;
        }
        
        request.setAttribute("contentPage", contentPage);

        if (isRedirect) {
            response.sendRedirect(redirectUrl);
        } else {
            request.getRequestDispatcher(viewPage).forward(request, response);
        }
    }
}