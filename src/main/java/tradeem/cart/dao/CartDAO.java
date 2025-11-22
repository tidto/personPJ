//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 22.
//  Time: PM 10:30
//  To change this template use File | Settings | File Templates.
//
package tradeem.cart.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db.DBConnect;
import tradeem.cart.dto.Cart;

public class CartDAO {
    private static CartDAO instance = new CartDAO();
    private CartDAO() {}
    public static CartDAO getInstance() { return instance; }

    // 1. 장바구니 담기
    public void insertCart(String memberId, int gameNo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnect.getConnection();
            String sql = "INSERT INTO CART_IN (CART_NO, GAME_NO, MEMBER_ID) VALUES (cart_seq.NEXTVAL, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, gameNo);
            pstmt.setString(2, memberId);
            pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(conn, pstmt, null);
        }
    }

    // 2. 장바구니 목록 조회 (게임 정보 JOIN)
    public List<Cart> getCartList(String memberId) {
        List<Cart> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        // [중요] 이미지는 조인하지 않음. gameNo만 있으면 됨.
        String sql = "SELECT c.CART_NO, c.MEMBER_ID, g.GAME_NO, g.GAME_NM, g.COST_COIN "
                   + "FROM CART_IN c "
                   + "JOIN GAME_PROD g ON c.GAME_NO = g.GAME_NO "
                   + "WHERE c.MEMBER_ID = ? ORDER BY c.CART_NO DESC";

        try {
            conn = DBConnect.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();

            while(rs.next()) {
                Cart c = new Cart();
                c.setCartNo(rs.getInt("CART_NO"));
                c.setMemberId(rs.getString("MEMBER_ID"));
                
                // 부모(Game) 필드에 세팅
                c.setGameNo(rs.getInt("GAME_NO"));     // 이걸로 이미지(번호.png) 찾음
                c.setGameNm(rs.getString("GAME_NM"));
                c.setCostCoin(rs.getInt("COST_COIN"));
                
                list.add(c);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(conn, pstmt, rs);
        }
        return list;
    }

    // 3. 장바구니 개별 삭제
    public void deleteCart(int cartNo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnect.getConnection();
            String sql = "DELETE FROM CART_IN WHERE CART_NO = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, cartNo);
            pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(conn, pstmt, null);
        }
    }
}
