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

	private GameDAO() {
	}

	public static GameDAO getInstance() {
		return instance;
	}

	// 1. 총 게임 개수 구하기 (페이징 계산을 위해 필수)
	public int getGameCount(int genreNo) {
		int count = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		// 기본: 전체 개수
		String sql = "SELECT COUNT(*) FROM GAME_PROD";

		// 장르 선택 시: 해당 장르 개수만
		if (genreNo > 0) {
			sql += " WHERE GENRE_NO = ?";
		}

		try {
			conn = DBConnect.getConnection();
			ps = conn.prepareStatement(sql);
			if (genreNo > 0) {
				ps.setInt(1, genreNo);
			}
			rs = ps.executeQuery();
			if (rs.next())
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnect.close(conn, ps, rs);
		}
		return count;
	}

	// 2. 게임 목록 조회 (페이징 + 장르검색)
	public List<Game> getGameList(int startRow, int endRow, int genreNo) {
		List<Game> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		StringBuilder sb = new StringBuilder();

		// 오라클 페이징 쿼리 
		// order relDate DESC 서브쿼리 - ROWNUM - 범위 자르기
		sb.append("SELECT * FROM ( ");
		sb.append("    SELECT A.*, ROWNUM AS RNUM FROM ( ");
		sb.append("        SELECT * FROM GAME_PROD ");

		// 장르 필터가 있으면 WHERE절 추가
		if (genreNo > 0) {
			sb.append("    WHERE GENRE_NO = ? ");
		}

		sb.append("        ORDER BY REL_DATE DESC "); // 최신순
		sb.append("    ) A WHERE ROWNUM <= ? "); // 끝 번호
		sb.append(") WHERE RNUM >= ?"); // 시작 번호

		try {
			conn = DBConnect.getConnection();
			ps = conn.prepareStatement(sb.toString());

			int idx = 1;
			if (genreNo > 0) {
				ps.setInt(idx++, genreNo); // 장르가 있으면 1번 물음표
			}
			ps.setInt(idx++, endRow); // 끝 번호 매핑
			ps.setInt(idx++, startRow); // 시작 번호 매핑

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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnect.close(conn, ps, rs);
		}
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnect.close(conn, ps, rs);
		}
		return game;
	}

	// 중복 제거용 ResultSet에서 값 꺼내기 ()
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

	// main.jsp
	// 랜덤으로 게임 3개
	public ArrayList<Game> selectRandomGameList() {
		ArrayList<Game> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// DBMS_RANDOM 사용 서브쿼리
		String sql = "SELECT * " + "FROM (SELECT * FROM GAME_PROD ORDER BY DBMS_RANDOM.VALUE) " + "WHERE ROWNUM <= 3";

		try {
			conn = DBConnect.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Game g = new Game();
				g.setGameNo(rs.getInt("GAME_NO"));
				g.setGameNm(rs.getString("GAME_NM"));
				g.setGameContent(rs.getString("GAME_CONTENT"));
				g.setRelDate(rs.getDate("REL_DATE"));
				g.setGenre(rs.getString("GENRE"));
				// 필요한 필드 추가 set...
				list.add(g);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnect.close(conn, pstmt, rs);
		}
		return list;
	}

	// home.jsp
	// 최신 게임 3개
	public ArrayList<Game> selectLatestGameList() {
		ArrayList<Game> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 발매일(REL_DATE) 내림차순 정렬 후 상위 3개
		String sql = "SELECT * " + "FROM (SELECT * FROM GAME_PROD ORDER BY REL_DATE DESC) " + "WHERE ROWNUM <= 3";

		try {
			conn = DBConnect.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Game g = new Game();
				g.setGameNo(rs.getInt("GAME_NO"));
				g.setGameNm(rs.getString("GAME_NM"));
				g.setGameContent(rs.getString("GAME_CONTENT"));
				g.setRelDate(rs.getDate("REL_DATE"));
				g.setGenre(rs.getString("GENRE"));
				list.add(g);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnect.close(conn, pstmt, rs);
		}
		return list;
	}

	// admin author
	// 등록
	public int insertGame(Game g) {
		int resultKey = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnect.getConnection();

			// SQL: PK(GAME_NO)를 반환받기 위한 쿼리 구조
			String[] returnCols = { "GAME_NO" };

			String sql = "INSERT INTO GAME_PROD "
					+ "(GAME_NO, GAME_NM, GAME_CONTENT, COST_COIN, REL_DATE, GENRE, GENRE_NO, GAME_VIDEO) "
					+ "VALUES (gm_seq.NEXTVAL, ?, ?, ?, SYSDATE, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql, returnCols);

			pstmt.setString(1, g.getGameNm());
			pstmt.setString(2, g.getGameContent());
			pstmt.setInt(3, g.getCostCoin());
			pstmt.setString(4, g.getGenre());
			pstmt.setInt(5, g.getGenreNo());
			pstmt.setString(6, g.getGameVideo());

			pstmt.executeUpdate();

			// 생성된 키(GAME_NO) 가져오기
			rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				resultKey = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnect.close(conn, pstmt, rs);
		}
		return resultKey; // 생성된 번호 리턴 (이미지 저장용)
	}

	// 게임 삭제
	public void deleteGame(int gameNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBConnect.getConnection();
			String sql = "DELETE FROM GAME_PROD WHERE GAME_NO = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, gameNo);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	// 수정
	public void updateGame(Game g) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBConnect.getConnection();
			// 이미지 변경 여부는 Service에서 판단하거나 별도 메서드로 뺄 수 있음
			// 여기서는 기본 정보 수정
			String sql = "UPDATE GAME_PROD SET " + "GAME_NM = ?, " + "GAME_CONTENT = ?, " + "COST_COIN = ?, "
					+ "GENRE_NO = ?, " + "GAME_VIDEO = ? " + "WHERE GAME_NO = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, g.getGameNm());
			pstmt.setString(2, g.getGameContent());
			pstmt.setInt(3, g.getCostCoin());
			pstmt.setInt(4, g.getGenreNo());
			pstmt.setString(5, g.getGameVideo());
			pstmt.setInt(6, g.getGameNo()); // WHERE 조건

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	
}