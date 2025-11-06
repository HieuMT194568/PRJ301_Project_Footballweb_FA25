package Dal;

import Model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class UserDAO {
    private final Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    public UserDAO() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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
    public boolean deleteUser(int userID) {
    String sql = "DELETE FROM Users WHERE UserID = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userID);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
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
    public List<User> getAllUsers() {
    List<User> list = new ArrayList<>();
    String sql = "SELECT UserID, Username, FullName, Email, Role FROM Users";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            User u = new User();
            u.setUserID(rs.getInt("UserID"));
            u.setUsername(rs.getString("Username"));
            u.setFullName(rs.getString("FullName"));
            u.setEmail(rs.getString("Email"));
            u.setRole(rs.getString("Role"));
            list.add(u);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
 
    // Đây là code để thêm vào bên trong class UserDAO của bạn
// (Giả sử bạn đã có biến 'connection' từ class DBContext)

public boolean updateUserRole(int userID, String newRole) {
    String sql = "UPDATE Users SET role = ? WHERE userID = ?";
    
    try (Connection conn = DBContext.getConnection(); // Lấy connection từ DBContext
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, newRole);
        ps.setInt(2, userID);
        
        int rowsAffected = ps.executeUpdate();
        
        return rowsAffected > 0; // Trả về true nếu cập nhật thành công (1 hàng bị ảnh hưởng)
        
    } catch (Exception e) {
        e.printStackTrace();
        return false; // Trả về false nếu có lỗi
    }
}
}
