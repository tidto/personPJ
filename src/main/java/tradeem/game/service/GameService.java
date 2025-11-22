//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 21.
//  Time: PM 01:30
//  To change this template use File | Settings | File Templates.
//
package tradeem.game.service;

import java.util.List;

import tradeem.bill.dao.BillDAO;
import tradeem.bill.dto.Bill;
import tradeem.cart.dao.CartDAO;
import tradeem.cart.dto.Cart;
import tradeem.game.dao.GameDAO;
import tradeem.game.dto.Game;

public class GameService {
    private static GameService instance = new GameService();
    private GameService() {}
    public static GameService getInstance() { return instance; }

    private GameDAO gameDao = GameDAO.getInstance();
    
    // 한 페이지에 보여줄 게임 수 (12개)
    private static final int PAGE_SIZE = 12; 

    // 리스트 가져오기 (페이지 번호를 받아서 DB의 행 번호로 변환)
    public List<Game> getGameList(int page, int genreNo) {
        // 공식: 시작행 = (현재페이지 - 1) * 12 + 1
        int startRow = (page - 1) * PAGE_SIZE + 1;
        int endRow = startRow + PAGE_SIZE - 1;
        
        return gameDao.getGameList(startRow, endRow, genreNo);
    }

    // 전체 페이지 수 계산 (총 데이터 60개면 -> 5페이지)
    public int getTotalPage(int genreNo) {
        int count = gameDao.getGameCount(genreNo);
        
        // 무조건 올림 처리 (데이터가 1개라도 남으면 다음 페이지 필요)
        return (int) Math.ceil((double) count / PAGE_SIZE);
    }
    
    // 게임 단건조회
    public Game getGameDetail(int gameNo) {
        return gameDao.getGameDetail(gameNo);
    }
    
    // home.jsp
    // 랜덤 게임 리스트
    public List<Game> getRandomGameList() {
        return gameDao.selectRandomGameList();
    }

    // 최신 게임 리스트 
    public List<Game> getLatestGameList() {
        return gameDao.selectLatestGameList();
    }
    
    // admin author
    // 게임 추가
    public int insertGame(Game g) {
        return gameDao.insertGame(g);
    }
    // 삭제
    public void deleteGame(int gameNo) {
        gameDao.deleteGame(gameNo);
    }

    // 수정
    public void updateGame(Game g) {
        gameDao.updateGame(g);
    }
    
    // cart
    // 장바구니 추가
    public void insertCart(String memberId, int gameNo) {
        CartDAO.getInstance().insertCart(memberId, gameNo);
    }

    // 목록
    public List<Cart> getCartList(String memberId) {
        return CartDAO.getInstance().getCartList(memberId);
    }

    // 삭제
    public void deleteCart(int cartNo) {
        CartDAO.getInstance().deleteCart(cartNo);
    }
    
    // bill
	// 구매 처리
	public boolean buyGames(String memberId, List<Game> games, int totalCost, int[] cartNos) {
	    return BillDAO.getInstance().buyGames(memberId, games, totalCost, cartNos);
	}
	
	// 구매 내역 조회
	public List<Bill> getBillList(String memberId) {
	    return BillDAO.getInstance().getBillList(memberId);
	}
}
