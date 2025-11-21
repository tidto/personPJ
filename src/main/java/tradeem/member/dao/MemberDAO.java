//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 20.
//  Time: PM 10:48
//  To change this template use File | Settings | File Templates.
//
package tradeem.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import db.DBConnect; // 아까 만드신 커넥션 풀 클래스 import
import tradeem.member.dto.Member;

public class MemberDAO {
    
    private static MemberDAO instance = new MemberDAO();
    public static MemberDAO getInstance() { return instance; }
    private MemberDAO() {}

    // 1. 로그인 확인 (성공 시 DTO 리턴, 실패 시 null)
    public Member checkLogin(String id, String pw) {
    	Member member = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT member_id, member_nm, rd_coin FROM MEMBER WHERE member_id = ? AND member_pw = ?";

        try {
            conn = DBConnect.getConnection(); // HikariCP에서 빌려오기
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, pw);
            rs = ps.executeQuery();

            if (rs.next()) {
                member = new Member();
                member.setMemberId(rs.getString("member_id"));
                member.setMemberNm(rs.getString("member_nm"));
                member.setRdCoin(rs.getInt("rd_coin"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(conn, ps, rs); // HikariCP로 반납
        }
        return member;
    }

    // 2. 회원가입 (성공 시 1, 실패 시 0)
    // 회원가입 (INSERT)
    public int insertMember(Member member) {
        int result = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        
        String sql = "INSERT INTO MEMBER "
                   + "(MEMBER_ID, MEMBER_PW, MEMBER_NM) "
                   + "VALUES (?, ?, ?)"; 
                   // RD_COIN은 0으로 초기화, CREATE_DATE는 현재시간(SYSDATE)

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            
            // DTO의 바뀐 변수명(getMemberId 등) 사용
            ps.setString(1, member.getMemberId());
            ps.setString(2, member.getMemberPw());
            ps.setString(3, member.getMemberNm());
            
            result = ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("⚠ 회원가입 INSERT 중 오류 발생: " + e.getMessage());
        } finally {
            DBConnect.close(conn, ps);
        }
        return result;
    }

    // 아이디 중복 확인 (SELECT)
    public boolean isIdExist(String id) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        // 컬럼명 MEMBER_ID 확인
        String sql = "SELECT COUNT(MEMBER_ID) FROM MEMBER WHERE MEMBER_ID = ?";
        
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            
            if(rs.next() && rs.getInt(1) > 0) {
                result = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(conn, ps, rs);
        }
        return result;
    }
    
    // 로그인 (SELECT)
    public Member login(String id, String pw) {
        Member member = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM MEMBER WHERE MEMBER_ID = ? AND MEMBER_PW = ?";
        
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, pw);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                member = new Member();
                member.setMemberId(rs.getString("MEMBER_ID"));
                member.setMemberPw(rs.getString("MEMBER_PW"));
                member.setMemberNm(rs.getString("MEMBER_NM"));
                member.setRdCoin(rs.getInt("RD_COIN"));
                member.setCreateDate(rs.getDate("CREATE_DATE"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(conn, ps, rs);
        }
        return member;
    }
    
    
 // 코인 충전 메서드
    public int updateCoin(String id, int amount) {
        int result = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        
        // 기존 코인 + 충전할 코인
        String sql = "UPDATE MEMBER SET RD_COIN = RD_COIN + ? WHERE MEMBER_ID = ?";
        
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, amount); // 충전 금액
            ps.setString(2, id);  // 아이디
            
            result = ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(conn, ps);
        }
        return result;
    }

    // (중요) 충전 후 세션 최신화를 위해 회원 정보 다시 가져오기
    public Member getMember(String id) {
        Member m = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM MEMBER WHERE MEMBER_ID = ?";
        
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                m = new Member();
                m.setMemberId(rs.getString("MEMBER_ID"));
                m.setMemberPw(rs.getString("MEMBER_PW"));
                m.setMemberNm(rs.getString("MEMBER_NM"));
                m.setRdCoin(rs.getInt("RD_COIN")); // 여기가 갱신된 값
                m.setCreateDate(rs.getDate("CREATE_DATE"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(conn, ps, rs);
        }
        return m;
    }
}