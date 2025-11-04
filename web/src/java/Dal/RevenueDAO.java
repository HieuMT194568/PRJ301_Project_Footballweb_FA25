package Dal;

import java.sql.*;
import java.util.*;

public class RevenueDAO extends DBContext {

    // Tổng doanh thu toàn hệ thống
    public double getTotalRevenue() {
        String sql = "SELECT SUM(TotalAmount) AS total FROM Orders WHERE Status = 'PAID'";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble("total");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Doanh thu theo tháng (dùng cho biểu đồ)
    public Map<String, Double> getMonthlyRevenue() {
        Map<String, Double> data = new LinkedHashMap<>();
        String sql = """
            SELECT FORMAT(OrderDate, 'yyyy-MM') AS Month, SUM(TotalAmount) AS Revenue
            FROM Orders
            WHERE Status = 'PAID'
            GROUP BY FORMAT(OrderDate, 'yyyy-MM')
            ORDER BY Month
        """;
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                data.put(rs.getString("Month"), rs.getDouble("Revenue"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

    // Top 5 sản phẩm bán chạy
    public Map<String, Integer> getTopProducts() {
        Map<String, Integer> data = new LinkedHashMap<>();
        String sql = """
            SELECT TOP 5 P.ProductName, SUM(OD.Quantity) AS Sold
            FROM OrderDetails OD
            JOIN Products P ON OD.ProductID = P.ProductID
            GROUP BY P.ProductName
            ORDER BY Sold DESC
        """;
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                data.put(rs.getString("ProductName"), rs.getInt("Sold"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

    // Tổng số đơn hàng trong tháng
    public int getOrdersThisMonth() {
        String sql = """
            SELECT COUNT(*) AS total FROM Orders
            WHERE MONTH(OrderDate) = MONTH(GETDATE())
              AND YEAR(OrderDate) = YEAR(GETDATE())
        """;
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("total");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
