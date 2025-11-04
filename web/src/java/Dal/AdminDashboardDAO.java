/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dal;
import java.sql.*;
import java.util.*;
import Model.*;

public class AdminDashboardDAO extends DBContext {

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM Users";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM Orders";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public double getTotalRevenue() {
        String sql = "SELECT SUM(TotalAmount) FROM Orders";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public List<Map<String, Object>> getTopSellingProducts() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = """
            SELECT TOP 5 p.ProductName, SUM(oi.Quantity) AS TotalSold
            FROM OrderItems oi
            JOIN Products p ON oi.ProductID = p.ProductID
            GROUP BY p.ProductName
            ORDER BY TotalSold DESC
        """;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", rs.getString("ProductName"));
                map.put("sold", rs.getInt("TotalSold"));
                list.add(map);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}