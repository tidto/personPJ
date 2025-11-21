//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 21.
//  Time: PM 02:08
//  To change this template use File | Settings | File Templates.
//
package tradeem.game.comtroller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tradeem.game.dto.Game;
import tradeem.game.service.GameService;

@WebServlet("/game")
public class GameController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private GameService gameService = GameService.getInstance();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doProcess(request, response);
    }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null || action.equals("")) action = "gameList";

        String viewPage = "/WEB-INF/views/home.jsp";
        String contentPage = "";

        switch (action) {
            case "gameList":
                // 1. 요청 파라미터 받기 (페이지 번호, 장르 번호)
                int page = 1;
                int genreNo = 0; // 0이면 전체보기
                try {
                    String pageStr = request.getParameter("page");
                    String genreStr = request.getParameter("genre");
                    
                    if(pageStr != null && !pageStr.isEmpty()) page = Integer.parseInt(pageStr);
                    if(genreStr != null && !genreStr.isEmpty()) genreNo = Integer.parseInt(genreStr);
                } catch(Exception e) {
                    page = 1; // 에러나면 1페이지로
                }

                // 2. DB에서 데이터 가져오기
                List<Game> list = gameService.getGameList(page, genreNo);
                int totalPage = gameService.getTotalPage(genreNo);

                // 3. 하단 페이지 블록 계산 (프레젠테이션 설명 포인트)
                // 예: 1~5페이지, 6~10페이지 ... 이렇게 5개씩 끊어서 보여줌
                int blockLimit = 5; 
                int startPage = (((int)(Math.ceil((double)page / blockLimit))) - 1) * blockLimit + 1;
                int endPage = startPage + blockLimit - 1;
                
                // 마지막 페이지가 총 페이지보다 크면 안되므로 보정
                if (endPage > totalPage) endPage = totalPage;
                
                // 4. JSP로 값 전달
                request.setAttribute("gameList", list);
                request.setAttribute("curPage", page);
                request.setAttribute("totalPage", totalPage);
                request.setAttribute("startPage", startPage);
                request.setAttribute("endPage", endPage);
                request.setAttribute("selectedGenre", genreNo); // 페이지 이동시 장르 유지용

                contentPage = "/WEB-INF/views/game/gameList.jsp";
                break;
                
            case "gameDetail":
                int no = 0;
                try {
                    // URL의 ?no=숫자 파라미터를 받습니다.
                    no = Integer.parseInt(request.getParameter("no"));
                } catch (Exception e) {
                    // 번호가 이상하면 목록으로 쫓아냅니다.
                    response.sendRedirect("game?action=gameList");
                    return;
                }

                // DB에서 게임 정보 하나를 가져옵니다.
                Game gameDto = gameService.getGameDetail(no);

                // JSP로 'game'이라는 이름으로 보냅니다.
                request.setAttribute("game", gameDto);
                
                // 상세 페이지로 이동
                contentPage = "/WEB-INF/views/game/gameInfo.jsp";
                break;
        }
        
        request.setAttribute("contentPage", contentPage);
        request.getRequestDispatcher(viewPage).forward(request, response);
    }
}