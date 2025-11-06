package Controller;

import Dal.OrderDAO;
import Dal.OrderDetailDAO;
import Dal.ProductDAO;
import Model.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import java.sql.Connection;
import Dal.DBContext; // Import DBContext của bạn để lấy connection
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private ProductDAO productDAO = new ProductDAO();

   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user"); // Lấy đối tượng User

    // 1. KIỂM TRA ĐĂNG NHẬP
    if (user == null) {
        // CHƯA ĐĂNG NHẬP
        // Ghi nhớ nơi người dùng muốn đến
        session.setAttribute("returnUrl", "CheckoutServlet");
        // Đưa về trang login
        response.sendRedirect("login.jsp");
    } else {
        // ĐÃ ĐĂNG NHẬP
        // Lấy giỏ hàng ra để kiểm tra
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        // 2. KIỂM TRA GIỎ HÀNG
        if (cart == null || cart.isEmpty()) {
            // Nếu giỏ hàng rỗng, quay về trang giỏ hàng
            response.sendRedirect("CartServlet?action=view");
        } else {
            // Mọi thứ OK, chuyển đến trang điền thông tin thanh toán
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}
// Sửa lại hàm doPost trong CheckoutServlet.java

// Cần import 2 cái này


@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession();
    Connection conn = null; // Khởi tạo connection

    try {
        // 1. KIỂM TRA LẠI THÔNG TIN
        User user = (User) session.getAttribute("user");
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        // Nếu session hết hạn hoặc giỏ hàng rỗng
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("CartServlet?action=view");
            return;
        }

        // Lấy connection từ DBContext
        // Giả sử DBContext của bạn có phương thức getConnection()
        conn = new DBContext().getConnection(); 
        
        // === BẮT ĐẦU TRANSACTION ===
        conn.setAutoCommit(false);

        // 2. TẠO ĐƠN HÀNG (ORDER)
        double totalAmount = cart.values().stream().mapToDouble(CartItem::getTotalPrice).sum();
        Order order = new Order();
        order.setUserID(user.getUserID()); // Lấy ID từ user thật
        order.setTotalAmount(totalAmount);
        order.setStatus("Pending"); // Mới tạo nên là Pending
        
        // Sửa OrderDAO để nhận 'conn' và trả về OrderID
        int orderID = orderDAO.insertOrder(order, conn);

        // 3. KIỂM TRA TỒN KHO VÀ LƯU CHI TIẾT (ORDER DETAIL)
        for (CartItem item : cart.values()) {
            // Lấy thông tin tồn kho mới nhất từ CSDL
            Product pInDB = productDAO.getProductById(item.getProduct().getProductID());
            
            // 3a. KIỂM TRA TỒN KHO
            if (pInDB.getStockQuantity() < item.getQuantity()) {
                // Nếu không đủ hàng, HỦY TOÀN BỘ GIAO DỊCH
                conn.rollback(); // Hoàn tác lại việc insertOrder ở trên
                request.setAttribute("error", "Sản phẩm " + pInDB.getProductName() + " không đủ hàng!");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return; // Dừng servlet
            }

            // 3b. LƯU ORDER DETAIL
            OrderDetail detail = new OrderDetail();
            detail.setOrderID(orderID);
            detail.setProductID(item.getProduct().getProductID());
            detail.setQuantity(item.getQuantity());
            detail.setUnitPrice(item.getProduct().getPrice());
            
            // Sửa OrderDetailDAO để nhận 'conn'
            orderDetailDAO.insertOrderDetail(detail, conn);

            // 3c. TRỪ SỐ LƯỢNG TỒN KHO
            // Sửa ProductDAO để nhận 'conn'
            productDAO.updateStockQuantity(item.getProduct().getProductID(), item.getQuantity(), conn);
        }

        // === KẾT THÚC TRANSACTION ===
        conn.commit(); // Nếu mọi thứ thành công, lưu tất cả thay đổi vào CSDL

        // 4. XÓA GIỎ HÀNG VÀ CHUYỂN HƯỚNG
        session.removeAttribute("cart");
        request.setAttribute("message", "Đặt hàng thành công! Mã đơn hàng của bạn là: " + orderID);
        request.getRequestDispatcher("checkout_success.jsp").forward(request, response);

    } catch (Exception e) {
        // 5. XỬ LÝ LỖI
        if (conn != null) {
            try {
                conn.rollback(); // Nếu có bất kỳ lỗi nào, rollback tất cả
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        e.printStackTrace();
        response.sendRedirect("CartServlet?action=view&error=checkout_failed");
    } finally {
        // Luôn đóng connection
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
}
