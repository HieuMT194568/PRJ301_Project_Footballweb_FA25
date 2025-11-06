package Dal;

import Model.OrderDetail;
import Model.Product;
import java.sql.*;
import java.util.*;

public class OrderDetailDAO extends DBContext {

    public void insertOrderDetail(OrderDetail detail, Connection conn) {
        String sql = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, detail.getOrderID());
            ps.setInt(2, detail.getProductID());
            ps.setInt(3, detail.getQuantity());
            ps.setDouble(4, detail.getUnitPrice());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

   public List<OrderDetail> getOrderDetailsByOrderId(int orderID) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT d.*, p.productName, p.price FROM OrderDetail d "
                   + "JOIN Product p ON d.productID = p.productID "
                   + "WHERE d.orderID = ?";

        try (Connection conn = getConnection();
             PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, orderID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail();
                od.setOrderDetailID(rs.getInt("orderDetailID"));
                od.setOrderID(rs.getInt("orderID"));
                od.setProductID(rs.getInt("productID"));
                od.setQuantity(rs.getInt("quantity"));
                od.setUnitPrice(rs.getDouble("unitPrice"));
                
                Product p = new Product();
                p.setProductID(rs.getInt("productID"));
                p.setProductName(rs.getString("productName"));
                p.setPrice(rs.getDouble("price"));
                list.add(od);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
