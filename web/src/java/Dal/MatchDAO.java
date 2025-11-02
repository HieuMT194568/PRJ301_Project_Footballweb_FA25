package Dal;

import static Dal.DBContext.getConnection;
import Model.Match;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatchDAO {
    private final Connection conn;

    public MatchDAO(Connection conn) {
        this.conn = conn;
    }

    // Thêm trận đấu
    public void addMatch(Match match) throws SQLException {
        String sql = """
            INSERT INTO Matches (HomeTeamID, AwayTeamID, HomeScore, AwayScore, MatchDate, Stadium)
            VALUES (?, ?, ?, ?, ?, ?)
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, match.getHomeTeamID());
            ps.setInt(2, match.getAwayTeamID());
            ps.setInt(3, match.getHomeScore());
            ps.setInt(4, match.getAwayScore());
            ps.setDate(5, match.getMatchDate());
            ps.setString(6, match.getStadium());
            ps.executeUpdate();
        }
    }

    // Lấy toàn bộ trận đấu (join để lấy tên đội)
    
    public List<Match> getAllMatches() {
        List<Match> list = new ArrayList<>();
        String sql = """
            SELECT m.*, 
                   th.TeamName AS HomeTeamName, 
                   ta.TeamName AS AwayTeamName
            FROM Matches m
            JOIN Team th ON m.HomeTeamID = th.TeamID
            JOIN Team ta ON m.AwayTeamID = ta.TeamID
            ORDER BY m.MatchDate DESC
        """;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Match m = new Match();
                m.setMatchID(rs.getInt("MatchID"));
                m.setHomeTeamID(rs.getInt("HomeTeamID"));
                m.setAwayTeamID(rs.getInt("AwayTeamID"));
                m.setMatchDate(rs.getDate("MatchDate"));
                m.setStadium(rs.getString("Stadium"));
                m.setHomeScore(rs.getInt("HomeScore"));
                m.setAwayScore(rs.getInt("AwayScore"));
                m.setHomeTeamName(rs.getString("HomeTeamName"));
                m.setAwayTeamName(rs.getString("AwayTeamName"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy 1 trận
    
    public Match getMatchById(int id) {
        Match m = null;
        String sql = """
            SELECT m.*, 
                   th.TeamName AS HomeTeamName, 
                   ta.TeamName AS AwayTeamName
            FROM Matches m
            JOIN Team th ON m.HomeTeamID = th.TeamID
            JOIN Team ta ON m.AwayTeamID = ta.TeamID
            WHERE m.MatchID = ?
        """;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                m = new Match();
                m.setMatchID(rs.getInt("MatchID"));
                m.setHomeTeamID(rs.getInt("HomeTeamID"));
                m.setAwayTeamID(rs.getInt("AwayTeamID"));
                m.setMatchDate(rs.getDate("MatchDate"));
                m.setStadium(rs.getString("Stadium"));
                m.setHomeScore(rs.getInt("HomeScore"));
                m.setAwayScore(rs.getInt("AwayScore"));
                m.setHomeTeamName(rs.getString("HomeTeamName"));
                m.setAwayTeamName(rs.getString("AwayTeamName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return m;
    }

    // Cập nhật
    public void updateMatch(Match match) throws SQLException {
        String sql = """
            UPDATE Matches
            SET HomeTeamID = ?, AwayTeamID = ?, HomeScore = ?, AwayScore = ?, MatchDate = ?, Stadium = ?
            WHERE MatchID = ?
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, match.getHomeTeamID());
            ps.setInt(2, match.getAwayTeamID());
            ps.setInt(3, match.getHomeScore());
            ps.setInt(4, match.getAwayScore());
            ps.setDate(5, match.getMatchDate());
            ps.setString(6, match.getStadium());
            ps.setInt(7, match.getMatchID());
            ps.executeUpdate();
        }
    }

    // Xóa
    public void deleteMatch(int matchID) throws SQLException {
        String sql = "DELETE FROM Matches WHERE MatchID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, matchID);
            ps.executeUpdate();
        }
    }
      public List<Match> getAllMatchesWithTeamNames() {
        List<Match> list = new ArrayList<>();
        String sql = """
            SELECT m.MatchID, 
                   m.HomeTeamID, ht.TeamName AS HomeTeamName,
                   m.AwayTeamID, at.TeamName AS AwayTeamName,
                   m.MatchDate, m.Stadium, m.HomeScore, m.AwayScore
            FROM Matches m
            JOIN Teams ht ON m.HomeTeamID = ht.TeamID
            JOIN Teams at ON m.AwayTeamID = at.TeamID
            ORDER BY m.MatchDate DESC
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Match match = new Match();
                match.setMatchID(rs.getInt("MatchID"));
                match.setHomeTeamID(rs.getInt("HomeTeamID"));
                match.setHomeTeamName(rs.getString("HomeTeamName"));
                match.setAwayTeamID(rs.getInt("AwayTeamID"));
                match.setAwayTeamName(rs.getString("AwayTeamName"));
                match.setMatchDate(rs.getDate("MatchDate"));
                match.setStadium(rs.getString("Stadium"));
                match.setHomeScore(rs.getInt("HomeScore"));
                match.setAwayScore(rs.getInt("AwayScore"));

                list.add(match);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
      
    public double calculateWinRate(int teamID) {
        String totalQuery = "SELECT COUNT(*) AS Total FROM Matches WHERE HomeTeamID = ? OR AwayTeamID = ?";
        String winQuery = "SELECT COUNT(*) AS Wins FROM Matches WHERE (HomeTeamID = ? AND HomeScore > AwayScore) OR (AwayTeamID = ? AND AwayScore > HomeScore)";
        
        int total = 0, wins = 0;

        try (Connection conn = DBContext.getConnection()) {

            // Tổng số trận
            try (PreparedStatement ps = conn.prepareStatement(totalQuery)) {
                ps.setInt(1, teamID);
                ps.setInt(2, teamID);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) total = rs.getInt("Total");
            }

            // Số trận thắng
            try (PreparedStatement ps = conn.prepareStatement(winQuery)) {
                ps.setInt(1, teamID);
                ps.setInt(2, teamID);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) wins = rs.getInt("Wins");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total == 0 ? 0 : (wins * 100.0 / total);
    }
}
