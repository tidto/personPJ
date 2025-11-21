package db;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnect {

    private static HikariDataSource dataSource;

    static {
        try {
            Properties props = loadProperties();
            HikariConfig config = new HikariConfig();

            // 1. 기본 접속 정보 설정
            config.setDriverClassName(props.getProperty("jdbc.driver"));
            config.setJdbcUrl(props.getProperty("jdbc.url"));
            config.setUsername(props.getProperty("jdbc.username"));
            config.setPassword(props.getProperty("jdbc.password"));

            // 2. HikariCP 풀 설정
            config.setMaximumPoolSize(Integer.parseInt(props.getProperty("hikari.maximumPoolSize")));
            config.setMinimumIdle(Integer.parseInt(props.getProperty("hikari.minimumIdle")));
            config.setConnectionTimeout(Long.parseLong(props.getProperty("hikari.connectionTimeout")));
            config.setIdleTimeout(Long.parseLong(props.getProperty("hikari.idleTimeout")));
            config.setMaxLifetime(Long.parseLong(props.getProperty("hikari.maxLifetime")));

            if (props.getProperty("hikari.poolName") != null) {
                config.setPoolName(props.getProperty("hikari.poolName"));
            }

            // 3. Oracle 성능 최적화 옵션 (수정됨)
            // MySQL의 cachePrepStmts 대신 Oracle은 implicitStatementCacheSize를 사용합니다.
            config.addDataSourceProperty("implicitStatementCacheSize", "250"); 
            
            dataSource = new HikariDataSource(config);
            System.out.println("✅ HikariCP Oracle Connection Pool 초기화 성공! (User: " + props.getProperty("jdbc.username") + ")");

        } catch (Exception e) {
            System.err.println("❌ HikariCP 초기화 실패: " + e.getMessage());
            e.printStackTrace();
            // 초기화 실패 시 애플리케이션이 오동작하지 않도록 예외를 던지거나 처리
        }
    }

    // 프로퍼티 로드 (변경 없음)
    private static Properties loadProperties() {
        Properties props = new Properties();
        // Maven 프로젝트에서는 src/main/resources가 클래스패스 루트(/)로 복사됩니다.
        try (InputStream is = DBConnect.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (is == null) {
                throw new RuntimeException("db.properties 파일을 찾을 수 없습니다. (src/main/resources 위치 확인 필요)");
            }
            props.load(is);
            return props;
        } catch (IOException e) {
            throw new RuntimeException("db.properties 로드 중 오류 발생", e);
        }
    }

    // Connection 제공
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("DataSource가 초기화되지 않았습니다.");
        }
        return dataSource.getConnection();
    }

    // Pool 종료 (앱 종료 시 호출 추천)
    public static void close() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("HikariCP Connection Pool 종료됨");
        }
    }
 // 자원 해제 (SELECT 문 사용 시 - ResultSet 있음)
    public static void close(Connection conn, AutoCloseable ps, AutoCloseable rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close(); // 연결이 끊기는 게 아니라 Pool로 반납됨
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 자원 해제 (INSERT, UPDATE, DELETE 사용 시 - ResultSet 없음)
    public static void close(Connection conn, AutoCloseable ps) {
        close(conn, ps, null);
    }
}