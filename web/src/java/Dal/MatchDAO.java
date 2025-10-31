package Dal;

import Model.Match;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatchDAO {

    private final Connection connection;

    public MatchDAO(Connection connection) {
        this.connection = connection;
    }

    private Match mapResultSetToMatch(ResultSet rs) throws SQLException {
        return new Match(
            rs.getInt("MatchID"),
            rs.getInt("HomeTeamID"),
            rs.getInt("AwayTeamID"),
            rs.getTimestamp("MatchDate"),
            rs.getString("Stadium"),
            rs.getInt("HomeScore"),
            rs.getInt("AwayScore")
        );
    }

    /* ==================== CRUD CƠ BẢN ==================== */

    // Lấy toàn bộ trận đấu
    public List<Match> getAllMatches() {
        List<Match> list = new ArrayList<>();
        String sql = "SELECT * FROM Matches ORDER BY MatchDate DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToMatch(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy trận đấu theo ID
    public Match getMatchById(int id) {
        String sql = "SELECT * FROM Matches WHERE MatchID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToMatch(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm trận đấu mới
    public boolean addMatch(Match m) {
        String sql = "INSERT INTO Matches (HomeTeamID, AwayTeamID, MatchDate, Stadium, HomeScore, AwayScore) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, m.getHomeTeamID());
            ps.setInt(2, m.getAwayTeamID());
            ps.setTimestamp(3, m.getMatchDate());
            ps.setString(4, m.getStadium());
            ps.setInt(5, m.getHomeScore());
            ps.setInt(6, m.getAwayScore());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật trận đấu
    public boolean updateMatch(Match m) {
        String sql = "UPDATE Matches SET HomeTeamID=?, AwayTeamID=?, MatchDate=?, Stadium=?, HomeScore=?, AwayScore=? WHERE MatchID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, m.getHomeTeamID());
            ps.setInt(2, m.getAwayTeamID());
            ps.setTimestamp(3, m.getMatchDate());
            ps.setString(4, m.getStadium());
            ps.setInt(5, m.getHomeScore());
            ps.setInt(6, m.getAwayScore());
            ps.setInt(7, m.getMatchID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa trận đấu
    public boolean deleteMatch(int id) {
        String sql = "DELETE FROM Matches WHERE MatchID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /* ==================== TRUY VẤN PHÂN TÍCH ==================== */

    // Lấy tất cả trận đấu của một đội (home hoặc away)
    public List<Match> getMatchesByTeam(int teamID) {
        List<Match> list = new ArrayList<>();
        String sql = "SELECT * FROM Matches WHERE HomeTeamID = ? OR AwayTeamID = ? ORDER BY MatchDate DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teamID);
            ps.setInt(2, teamID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapResultSetToMatch(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tính số trận thắng của một đội
    public int countWins(int teamID) {
        String sql = """
            SELECT COUNT(*) AS Wins
            FROM Matches
            WHERE (HomeTeamID = ? AND HomeScore > AwayScore)
               OR (AwayTeamID = ? AND AwayScore > HomeScore)
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teamID);
            ps.setInt(2, teamID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("Wins");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Tính số trận hòa
    public int countDraws(int teamID) {
        String sql = """
            SELECT COUNT(*) AS Draws
            FROM Matches
            WHERE (HomeTeamID = ? OR AwayTeamID = ?) AND HomeScore = AwayScore
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teamID);
            ps.setInt(2, teamID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("Draws");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Tính số trận thua
    public int countLosses(int teamID) {
        String sql = """
            SELECT COUNT(*) AS Losses
            FROM Matches
            WHERE (HomeTeamID = ? AND HomeScore < AwayScore)
               OR (AwayTeamID = ? AND AwayScore < HomeScore)
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teamID);
            ps.setInt(2, teamID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("Losses");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
