package Dal;

import Model.Team;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeamDAO {

    private final Connection connection;

    public TeamDAO(Connection connection) {
        this.connection = connection;
    }

    private Team mapResultSetToTeam(ResultSet rs) throws SQLException {
        return new Team(
            rs.getInt("TeamID"),
            rs.getString("TeamName"),
            rs.getString("Coach"),
            rs.getString("Stadium"),
            rs.getInt("FoundedYear"),
            rs.getString("Country")
        );
    }

    public List<Team> getAllTeams() {
        List<Team> list = new ArrayList<>();
        String sql = "SELECT * FROM Teams ORDER BY TeamName";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToTeam(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Team getTeamById(int id) {
        String sql = "SELECT * FROM Teams WHERE TeamID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToTeam(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addTeam(Team t) {
        String sql = "INSERT INTO Teams (TeamName, Coach, Stadium, FoundedYear, Country) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, t.getTeamName());
            ps.setString(2, t.getCoach());
            ps.setString(3, t.getStadium());
            ps.setInt(4, t.getFoundedYear());
            ps.setString(5, t.getCountry());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateTeam(Team t) {
        String sql = "UPDATE Teams SET TeamName=?, Coach=?, Stadium=?, FoundedYear=?, Country=? WHERE TeamID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, t.getTeamName());
            ps.setString(2, t.getCoach());
            ps.setString(3, t.getStadium());
            ps.setInt(4, t.getFoundedYear());
            ps.setString(5, t.getCountry());
            ps.setInt(6, t.getTeamID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteTeam(int id) {
        String sql = "DELETE FROM Teams WHERE TeamID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
