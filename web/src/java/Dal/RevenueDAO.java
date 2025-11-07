package Dal;

import Model.RevenueData;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
public RevenueData getRevenueDataLast7Days() {
        // 1. Sử dụng LinkedHashMap để giữ thứ tự 7 ngày
        // và khởi tạo doanh thu mặc định là 0.0
        Map<String, Double> revenueMap = new LinkedHashMap<>();
        
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM");
        
        for (int i = 6; i >= 0; i--) {
            LocalDate date = today.minusDays(i);
            String formattedDate = date.format(formatter);
            revenueMap.put(formattedDate, 0.0); // Khởi tạo 7 ngày với doanh thu 0
        }

        // 2. Viết câu SQL
        // Giả sử bạn dùng MySQL. 
        // CURDATE() - INTERVAL 6 DAY nghĩa là 7 ngày tính cả hôm nay.
        // CHỈ TÍNH doanh thu từ đơn hàng đã 'Completed'
        String sql = "SELECT \n" +
                     "    DATE_FORMAT(orderDate, '%d/%m') AS orderDay,\n" +
                     "    SUM(totalAmount) AS dailyRevenue\n" +
                     "FROM \n" +
                     "    Orders\n" + // Tên bảng Orders của bạn
                     "WHERE \n" +
                     "    orderDate >= CURDATE() - INTERVAL 6 DAY\n" +
                     "    AND status = 'Completed' \n" + // Rất quan trọng!
                     "GROUP BY \n" +
                     "    DATE(orderDate)\n" +
                     "ORDER BY \n" +
                     "    DATE(orderDate);";

        try {
            Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql); 
            ResultSet rs = ps.executeQuery();

            // 3. Cập nhật doanh thu thật từ DB vào Map
            while (rs.next()) {
                String orderDay = rs.getString("orderDay");
                double dailyRevenue = rs.getDouble("dailyRevenue");
                
                // Ghi đè doanh thu 0.0 bằng doanh thu thật
                if (revenueMap.containsKey(orderDay)) {
                    revenueMap.put(orderDay, dailyRevenue);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi ra console
        }
        


        // 4. Tách Map thành 2 List (Labels và Data)
        List<String> labels = new ArrayList<>(revenueMap.keySet());
        List<Double> data = new ArrayList<>(revenueMap.values());
        
        return new RevenueData(labels, data);
    }
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM Users";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    } 
     public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM Products";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
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
