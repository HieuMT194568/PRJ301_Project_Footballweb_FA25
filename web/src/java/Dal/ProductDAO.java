package Dal;

import static Dal.DBContext.getConnection;
import java.sql.*;
import java.util.*;
import Model.Product;

public class ProductDAO extends DBContext {

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getInt("StockQuantity"),
                        rs.getString("ImageUrl"),
                        rs.getString("Category")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

   public boolean updateStockQuantity(int productID, int quantityToDecrease, Connection conn) {
    
    // Câu lệnh SQL "thần kỳ"
    // Chỉ UPDATE nếu (số lượng hiện tại - số lượng giảm) >= 0
    String sql = "UPDATE Products SET " + 
                 "stockQuantity = stockQuantity - ? " + 
                 "WHERE ProductID = ? AND stockQuantity >= ?";
    
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, quantityToDecrease);
        ps.setInt(2, productID);
        ps.setInt(3, quantityToDecrease); // Điều kiện "stockQuantity >= quantityToDecrease"
        
        int rowsAffected = ps.executeUpdate();
        
        // Nếu rowsAffected > 0, nghĩa là update thành công (đủ hàng)
        // Nếu rowsAffected == 0, nghĩa là update thất bại (không đủ hàng)
        return rowsAffected > 0; 
        
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

    public void addProduct(Product p) {
        String sql = "INSERT INTO Products (ProductName, Description, Price, StockQuantity, ImageUrl, Category) VALUES (?,?,?,?,?,?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getStockQuantity());
            ps.setString(5, p.getImageUrl());
            ps.setString(6, p.getCategory());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Product p) {
        String sql = "UPDATE Products SET ProductName=?, Description=?, Price=?, StockQuantity=?, ImageUrl=?, Category=? WHERE ProductID=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getProductName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getStockQuantity());
            ps.setString(5, p.getImageUrl());
            ps.setString(6, p.getCategory());
            ps.setInt(7, p.getProductID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int id) {
        String sql = "DELETE FROM Products WHERE ProductID=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM Products WHERE ProductID=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getInt("StockQuantity"),
                        rs.getString("ImageUrl"),
                        rs.getString("Category")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Tăng lại tồn kho (khi hủy đơn)
    public void restoreStockQuantity(int productID, int quantityRestored) {
        String sql = "UPDATE Product SET stockQuantity = stockQuantity + ? WHERE productID = ?";
        try (Connection conn = getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, quantityRestored);
            st.setInt(2, productID);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
