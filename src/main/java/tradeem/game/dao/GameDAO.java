//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 21.
//  Time: PM 01:02
//  To change this template use File | Settings | File Templates.
//
package tradeem.game.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import db.DBConnect;
import tradeem.game.dto.Game;

public class GameDAO {
    private static GameDAO instance = new GameDAO();
    private GameDAO() {}
    public static GameDAO getInstance() { return instance; }

    // 1. 총 게임 개수 구하기 (페이징 계산을 위해 필수)
    public int getGameCount(int genreNo) {
        int count = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        // 기본: 전체 개수
        String sql = "SELECT COUNT(*) FROM GAME_PROD";
        
        // 장르 선택 시: 해당 장르 개수만
        if(genreNo > 0) {
            sql += " WHERE GENRE_NO = ?";
        }

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            if(genreNo > 0) {
                ps.setInt(1, genreNo);
            }
            rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); } 
        finally { DBConnect.close(conn, ps, rs); }
        return count;
    }

    // 2. 게임 목록 조회 (페이징 + 장르검색)
    public List<Game> getGameList(int startRow, int endRow, int genreNo) {
        List<Game> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        StringBuilder sb = new StringBuilder();
        
        // [오라클 페이징 쿼리 공식]
        // 1. 최신순 정렬 -> 2. 번호표(ROWNUM) 붙이기 -> 3. 범위 자르기
        sb.append("SELECT * FROM ( ");
        sb.append("    SELECT A.*, ROWNUM AS RNUM FROM ( ");
        sb.append("        SELECT * FROM GAME_PROD ");
        
        // 장르 필터가 있으면 WHERE절 추가
        if(genreNo > 0) {
            sb.append("    WHERE GENRE_NO = ? ");
        }
        
        sb.append("        ORDER BY REL_DATE DESC "); // 최신순
        sb.append("    ) A WHERE ROWNUM <= ? ");      // 끝 번호
        sb.append(") WHERE RNUM >= ?");               // 시작 번호

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sb.toString());
            
            int idx = 1;
            if(genreNo > 0) {
                ps.setInt(idx++, genreNo); // 장르가 있으면 1번 물음표
            }
            ps.setInt(idx++, endRow);      // 끝 번호 매핑
            ps.setInt(idx++, startRow);    // 시작 번호 매핑
            
            rs = ps.executeQuery();

            while (rs.next()) {
                Game game = new Game();
                game.setGameNo(rs.getInt("GAME_NO"));
                game.setGameNm(rs.getString("GAME_NM"));
                game.setGameContent(rs.getString("GAME_CONTENT"));
                game.setCostCoin(rs.getInt("COST_COIN"));
                game.setRelDate(rs.getDate("REL_DATE"));
                game.setGenre(rs.getString("GENRE"));
                game.setGenreNo(rs.getInt("GENRE_NO")); 
                game.setGameVideo(rs.getString("GAME_VIDEO"));
                list.add(game);
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { DBConnect.close(conn, ps, rs); }
        return list;
    }
    // 3. 상세 정보 조회 (게임 번호로 조회)
    public Game getGameDetail(int gameNo) {
        Game game = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        // 번호(PK)로 딱 하나만 가져옵니다.
        String sql = "SELECT * FROM GAME_PROD WHERE GAME_NO = ?";

        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, gameNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                game = setGameFromRs(rs);
            }
        } catch (Exception e) { e.printStackTrace(); } 
        finally { DBConnect.close(conn, ps, rs); }
        return game;
    }

    // [편의 기능] ResultSet에서 값 꺼내기 (중복 제거용)
    private Game setGameFromRs(ResultSet rs) throws Exception {
        Game game = new Game();
        game.setGameNo(rs.getInt("GAME_NO"));
        game.setGameNm(rs.getString("GAME_NM"));
        game.setGameContent(rs.getString("GAME_CONTENT"));
        game.setCostCoin(rs.getInt("COST_COIN"));
        game.setRelDate(rs.getDate("REL_DATE"));
        game.setGenre(rs.getString("GENRE"));
        game.setGenreNo(rs.getInt("GENRE_NO"));
        game.setGameVideo(rs.getString("GAME_VIDEO"));
        return game;
    }

}
