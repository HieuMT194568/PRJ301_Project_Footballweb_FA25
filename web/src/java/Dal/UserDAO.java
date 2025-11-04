package Dal;

import Model.User;
import java.sql.*;



public class UserDAO {
    private final Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }
    public User login(String username, String password) {
        String sql = "SELECT * FROM Users WHERE Username=? AND PasswordHash=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("FullName"),
                    rs.getString("Email"),
                    rs.getString("Role")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void register(User u) {
        String sql = "INSERT INTO Users (Username, PasswordHash, FullName, Email, Role) VALUES (?,?,?,?,?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPasswordHash());
            ps.setString(3, u.getFullName());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getRole());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
    public int countUsers() throws SQLException {
    String sql = "SELECT COUNT(*) FROM Users";
    Connection conn = DBContext.getConnection();
    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) return rs.getInt(1);
    return 0;
}
}
