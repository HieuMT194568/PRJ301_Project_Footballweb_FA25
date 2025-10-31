package Dal;

import Model.Player;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlayerDAO {

    private final Connection connection;

    public PlayerDAO(Connection connection) {
        this.connection = connection;
    }

    private Player mapResultSetToPlayer(ResultSet rs) throws SQLException {
        return new Player(
            rs.getInt("PlayerID"),
            rs.getString("FullName"),
            rs.getString("Position"),
            rs.getString("Nationality"),
            rs.getDate("BirthDate"),
            rs.getInt("ShirtNumber"),
            rs.getInt("TeamID")
        );
    }

    public List<Player> getAllPlayers() {
        List<Player> list = new ArrayList<>();
        String sql = "SELECT * FROM Players ORDER BY FullName";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToPlayer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Player> getPlayersByTeam(int teamId) {
        List<Player> list = new ArrayList<>();
        String sql = "SELECT * FROM Players WHERE TeamID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, teamId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToPlayer(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Player getPlayerById(int id) {
        String sql = "SELECT * FROM Players WHERE PlayerID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToPlayer(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addPlayer(Player p) {
        String sql = "INSERT INTO Players (FullName, Position, Nationality, BirthDate, ShirtNumber, TeamID) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, p.getFullName());
            ps.setString(2, p.getPosition());
            ps.setString(3, p.getNationality());
            ps.setDate(4, p.getBirthDate());
            ps.setInt(5, p.getShirtNumber());
            ps.setInt(6, p.getTeamID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePlayer(Player p) {
        String sql = "UPDATE Players SET FullName=?, Position=?, Nationality=?, BirthDate=?, ShirtNumber=?, TeamID=? WHERE PlayerID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, p.getFullName());
            ps.setString(2, p.getPosition());
            ps.setString(3, p.getNationality());
            ps.setDate(4, p.getBirthDate());
            ps.setInt(5, p.getShirtNumber());
            ps.setInt(6, p.getTeamID());
            ps.setInt(7, p.getPlayerID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deletePlayer(int id) {
        String sql = "DELETE FROM Players WHERE PlayerID=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
