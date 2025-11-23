//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 21.
//  Time: PM 02:08
//  To change this template use File | Settings | File Templates.
//
package tradeem.game.comtroller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tradeem.bill.dto.Bill;
import tradeem.cart.dto.Cart;
import tradeem.game.dto.Game;
import tradeem.game.service.GameService;
import tradeem.member.dto.Member;

// file upload annotation
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 15 // 15MB
)
//파일 업로드시 getParameter가 안 먹힐 수 있으므로, multipart 체크 로직이 필요할 수 있으나 @MultipartConfig를 쓰면 request.getParameter 사용 가능

@WebServlet("/game")
public class GameController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GameService gameService = GameService.getInstance();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		if (action == null || action.equals(""))
			action = "gameList";

		GameService service = GameService.getInstance();
		String viewPage = "/WEB-INF/views/home.jsp";
		String contentPage = "";

		switch (action) {
		case "gameList":
			// 1요청 파라미터 받기 (페이지 번호, 장르 번호)
			int page = 1;
			int genreNo = 0; // 0이면 전체보기
			try {
				String pageStr = request.getParameter("page");
				String genreStr = request.getParameter("genre");

				if (pageStr != null && !pageStr.isEmpty())
					page = Integer.parseInt(pageStr);
				if (genreStr != null && !genreStr.isEmpty())
					genreNo = Integer.parseInt(genreStr);
			} catch (Exception e) {
				page = 1; // 에러나면 1페이지로
			}

			List<Game> list = gameService.getGameList(page, genreNo);
			int totalPage = gameService.getTotalPage(genreNo);

			// 하단 페이지 블록 5개씩 끊는 계산
			int blockLimit = 5;
			int startPage = (((int) (Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
			int endPage = startPage + blockLimit - 1;

			// 마지막 페이지가 총 페이지보다 크면 안되므로 보정
			if (endPage > totalPage)
				endPage = totalPage;
			

			// JSP로 값 전달
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
				no = Integer.parseInt(request.getParameter("no"));
			} catch (Exception e) {
				// 게임 번호 인식불가일때 리로드
				response.sendRedirect("game?action=gameList");
				return;
			}

			Game gameDto = gameService.getGameDetail(no);
			request.setAttribute("game", gameDto);

			contentPage = "/WEB-INF/views/game/gameInfo.jsp";
			break;

		// admin 등록 수정 삭제
		case "registerForm":
			contentPage = "/WEB-INF/views/game/gameRegister.jsp";
			break;

		// 게임 등록 실행 (DB Insert + File Upload)
		case "register":
			try {
				// 폼 데이터 받기
				String gameNm = request.getParameter("gameNm");
				String content = request.getParameter("gameContent");
				int cost = Integer.parseInt(request.getParameter("costCoin"));
				String genre = request.getParameter("genre");
				int genreNoReg = Integer.parseInt(request.getParameter("genreNo"));
				String video = request.getParameter("gameVideo");

				Game g = new Game();
				g.setGameNm(gameNm);
				g.setGameContent(content);
				g.setCostCoin(cost);
				g.setGenre(genre);
				g.setGenreNo(genreNoReg);
				g.setGameVideo(video);

				// ***pk값 먼저
				int newGameNo = service.insertGame(g);

				// 이미지 저장 (assets/img/games/) 저장될땐 gameNo로
				if (newGameNo > 0) {
					Part filePart = request.getPart("gameImg");

					// 파일이 업로드 되었을 때만 실행
					if (filePart != null && filePart.getSize() > 0) {
						String savePath = request.getServletContext().getRealPath("/assets/img/games");
						File fileSaveDir = new File(savePath);
						if (!fileSaveDir.exists())
							fileSaveDir.mkdirs();

						// 원본 확장자 무시하고 무조건 "번호.png"로 저장
						filePart.write(savePath + File.separator + newGameNo + ".png");
					}

					response.sendRedirect("game?action=gameList");
					return;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		// 삭제 실행
		case "delete":
			int delNo = Integer.parseInt(request.getParameter("no"));
			service.deleteGame(delNo);
			response.sendRedirect("game?action=gameList");
			return;

		// 수정 페이지 이동
		case "updateForm":
			try {
				int gameNo = Integer.parseInt(request.getParameter("no"));
				Game dto = service.getGameDetail(gameNo);
				request.setAttribute("game", dto);

				contentPage = "/WEB-INF/views/game/gameModify.jsp";

			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("game?action=gameList");
				return;
			}
			break;
		// 수정 데이터 덮어쓰기
		case "update":
			try {
				int gameNo = Integer.parseInt(request.getParameter("gameNo"));
				String gameNm = request.getParameter("gameNm");
				String content = request.getParameter("gameContent");
				int cost = Integer.parseInt(request.getParameter("costCoin"));
				int genreNoMo = Integer.parseInt(request.getParameter("genreNo"));
				String genreName = request.getParameter("genre"); // hidden input 값
				String video = request.getParameter("gameVideo");

				Game g = new Game();
				g.setGameNo(gameNo);
				g.setGameNm(gameNm);
				g.setGameContent(content);
				g.setCostCoin(cost);
				g.setGenreNo(genreNoMo);
				g.setGenre(genreName);
				g.setGameVideo(video);

				service.updateGame(g);

				Part filePart = request.getPart("gameImg");

				if (filePart != null && filePart.getSize() > 0) {
					String savePath = request.getServletContext().getRealPath("/assets/img/games");
					filePart.write(savePath + File.separator + gameNo + ".png");
				}

				// 상세 페이지로 이동
				response.sendRedirect("game?action=gameDetail&no=" + gameNo);
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		// 장바구 담기
		case "addToCart":
			// 로그인 체크
			if (request.getSession().getAttribute("member") == null) {
				response.sendRedirect("member?action=loginForm");
				return;
			}
			try {
				String memberId = ((Member) request.getSession().getAttribute("member")).getMemberId();
				int gameNo = Integer.parseInt(request.getParameter("no"));

				// 장바구니 추가
				service.insertCart(memberId, gameNo);

				// 장바구니 목록으로 이동
				response.sendRedirect("game?action=cartList");
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		// 전체 리스트
		case "cartList":
			if (request.getSession().getAttribute("member") == null) {
				response.sendRedirect("member?action=loginForm");
				return;
			}
			try {
				String memberId = ((Member) request.getSession().getAttribute("member")).getMemberId();

				// 목록 가져오기 (이미지는 gameNo.png로 처리하므로 별도 이미지 데이터 필요 없음)
				List<Cart> cartList = service.getCartList(memberId);

				request.setAttribute("cartList", cartList);
				contentPage = "/WEB-INF/views/cart/cart.jsp";
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		// 삭제
		case "deleteCart":
			try {
				int cartNo = Integer.parseInt(request.getParameter("cartNo"));
				service.deleteCart(cartNo);

				// 삭제 후 목록 새로고침
				response.sendRedirect("game?action=cartList");
				return;
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		case "buy":
			try {
				// 로그인 체크
				if (request.getSession().getAttribute("member") == null) {
					response.sendRedirect("member?action=loginForm");
					return;
				}

				// 세션에서 현재 사용자 정보 가져오기
				Member loginMember = (Member) request.getSession().getAttribute("member");
				String memberId = loginMember.getMemberId();

				String type = request.getParameter("type"); // "direct" or "cart"
				List<Game> buyGames = new ArrayList<>();
				int totalCost = 0;
				int[] cartNos = null; // 장바구니 구매일 때만 사용

				// A. 바로 구매 (상세페이지에서 Buy Now)
				if ("direct".equals(type)) {
					int gameNo = Integer.parseInt(request.getParameter("no"));
					Game g = service.getGameDetail(gameNo); // 게임 정보 조회
					buyGames.add(g);
					totalCost = g.getCostCoin();
				}
				
				// B. 장바구니 구매 (체크박스 선택 구매)
				else if ("cart".equals(type)) {
					// 체크된 장바구니 번호들 (String 배열)
					String[] selectedCartNos = request.getParameterValues("checkItem");

					if (selectedCartNos != null) {
						cartNos = new int[selectedCartNos.length];
						// 장바구니 전체 목록을 가져와서, 선택된 것만 추려냄 (보안상 DB 가격으로 다시 계산)
						List<Cart> myCartList = service.getCartList(memberId);

						for (int i = 0; i < selectedCartNos.length; i++) {
							int cNo = Integer.parseInt(selectedCartNos[i]);
							cartNos[i] = cNo;

							// 내 장바구니 목록에서 해당 번호 찾기
							for (Cart c : myCartList) {
								if (c.getCartNo() == cNo) {
									buyGames.add(c); // Game 정보를 상속받았으므로 추가 가능
									totalCost += c.getCostCoin();
									break;
								}
							}
						}
					}
				}

				// C. 구매 실행 (Service -> DAO)
				boolean isSuccess = service.buyGames(memberId, buyGames, totalCost, cartNos);

				if (isSuccess) {
					// 결제 성공 시: 세션의 코인 정보도 갱신해줘야 화면에 바로 반영됨
					loginMember.setRdCoin(loginMember.getRdCoin() - totalCost);

					// 구매 내역 페이지로 이동
					response.sendRedirect("game?action=billList");
					return;
				} else {
					// 결제 실패 시 (잔액 부족 등)
					response.setContentType("text/html; charset=UTF-8");
					response.getWriter().write(
							"<script>alert('Purchase Failed.'); history.back();</script>");
					return;
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;

		// 구매 내역
		case "billList":
			if (request.getSession().getAttribute("member") == null) {
				response.sendRedirect("member?action=loginForm");
				return;
			}
			try {
				String memberId = ((Member) request.getSession().getAttribute("member")).getMemberId();

				// 구매 내역 가져오기
				List<Bill> billList = service.getBillList(memberId);

				request.setAttribute("billList", billList);
				contentPage = "/WEB-INF/views/bill/bill.jsp";

			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		}

		request.setAttribute("contentPage", contentPage);
		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}