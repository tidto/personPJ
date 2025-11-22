//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 22.
//  Time: PM 10:30
//  To change this template use File | Settings | File Templates.
//
package tradeem.bill.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db.DBConnect;
import tradeem.bill.dto.Bill;
import tradeem.cart.dao.CartDAO;
import tradeem.game.dto.Game;

public class BillDAO {
    private static BillDAO instance = new BillDAO();
    private BillDAO() {}
    public static BillDAO getInstance() { return instance; }

    // ==========================================
    // 1. 구매 트랜잭션 (핵심 로직)
    // ==========================================
    public boolean buyGames(String memberId, List<Game> games, int totalCost, int[] cartNos) {
        Connection conn = null;
        PreparedStatement pstmtUpdate = null; // 코인 차감용
        PreparedStatement pstmtInsert = null; // 영수증 생성용
        PreparedStatement pstmtDelete = null; // 장바구니 삭제용
        
        boolean isSuccess = false;

        try {
            conn = DBConnect.getConnection();
            conn.setAutoCommit(false); // ★ 트랜잭션 시작 (자동 커밋 끔)

            // -----------------------------------------
            // Step 1. 멤버 코인 차감
            // -----------------------------------------
            String sqlUpdate = "UPDATE MEMBER SET RD_COIN = RD_COIN - ? WHERE MEMBER_ID = ? AND RD_COIN >= ?";
            pstmtUpdate = conn.prepareStatement(sqlUpdate);
            pstmtUpdate.setInt(1, totalCost);
            pstmtUpdate.setString(2, memberId);
            pstmtUpdate.setInt(3, totalCost); // 잔액이 충분한지 한 번 더 체크

            int updateCount = pstmtUpdate.executeUpdate();
            if(updateCount == 0) {
                throw new Exception("잔액 부족 또는 회원 정보 오류"); // 강제로 예외 발생시켜서 catch로 보냄
            }

            // -----------------------------------------
            // Step 2. 영수증(Bill) 생성 (리딤코드 랜덤 생성)
            // -----------------------------------------
            // 오라클 DBMS_RANDOM.STRING('X', 15) -> 영문대문자+숫자 15자리
            String sqlInsert = "INSERT INTO GAME_BILL (REDEEM_CODE, MEMBER_ID, GAME_NO, purchase_DATE) "
                             + "VALUES (DBMS_RANDOM.STRING('X', 15), ?, ?, SYSDATE)";
            pstmtInsert = conn.prepareStatement(sqlInsert);

            for(Game g : games) {
                pstmtInsert.setString(1, memberId);
                pstmtInsert.setInt(2, g.getGameNo());
                pstmtInsert.addBatch(); // 여러 게임일 수 있으니 배치 처리
            }
            pstmtInsert.executeBatch();

            // -----------------------------------------
            // Step 3. 장바구니 비우기 (장바구니 구매일 경우에만)
            // -----------------------------------------
            if(cartNos != null && cartNos.length > 0) {
                String sqlDelete = "DELETE FROM CART_IN WHERE CART_NO = ?";
                pstmtDelete = conn.prepareStatement(sqlDelete);
                
                for(int cNo : cartNos) {
                    pstmtDelete.setInt(1, cNo);
                    pstmtDelete.addBatch();
                }
                pstmtDelete.executeBatch();
            }

            // -----------------------------------------
            // 모든 단계 성공 시 커밋
            // -----------------------------------------
            conn.commit();
            isSuccess = true;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if(conn != null) conn.rollback(); // ★ 실패하면 되돌리기
            } catch (SQLException ex) { ex.printStackTrace(); }
        } finally {
            // 자원 해제 (conn은 닫고, pstmt는 각각 닫아줌)
            DBConnect.close(conn, pstmtUpdate, null);
            try { if(pstmtInsert != null) pstmtInsert.close(); } catch(Exception e) {}
            try { if(pstmtDelete != null) pstmtDelete.close(); } catch(Exception e) {}
        }
        
        return isSuccess;
    }

    // ==========================================
    // 2. 구매 내역 조회 (bill.jsp용)
    // ==========================================
    public List<Bill> getBillList(String memberId) {
        List<Bill> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        // 게임 정보(이름, 가격)와 조인
        String sql = "SELECT b.*, g.GAME_NM, g.COST_COIN "
                   + "FROM GAME_BILL b "
                   + "JOIN GAME_PROD g ON b.GAME_NO = g.GAME_NO "
                   + "WHERE b.MEMBER_ID = ? "
                   + "ORDER BY b.purchase_DATE DESC";

        try {
            conn = DBConnect.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                Bill b = new Bill();
                b.setRedeemCode(rs.getString("REDEEM_CODE"));
                b.setMemberId(rs.getString("MEMBER_ID"));
                b.setGameNo(rs.getInt("GAME_NO"));
                b.setPurchaseDate(rs.getDate("purchase_DATE"));
                
                // 조인된 게임 정보
                b.setGameNm(rs.getString("GAME_NM"));
                b.setCostCoin(rs.getInt("COST_COIN"));
                
                list.add(b);
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { DBConnect.close(conn, pstmt, rs); }
        return list;
    }
}