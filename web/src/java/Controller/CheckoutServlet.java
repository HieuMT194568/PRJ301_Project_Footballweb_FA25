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

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("CartServlet?action=view");
            return;
        }

        // Giả sử userID đã lưu trong session
        Integer userId = (Integer) session.getAttribute("userID");
        if (userId == null) userId = 1; // test tạm thời

        double totalAmount = cart.values().stream().mapToDouble(CartItem::getTotalPrice).sum();

        // 1️⃣ Tạo đơn hàng
        Order order = new Order();
        order.setUserID(userId);
        order.setTotalAmount(totalAmount);
        order.setStatus("PAID");

        int orderID = orderDAO.insertOrder(order);

        // 2️⃣ Lưu từng chi tiết đơn hàng
        for (CartItem item : cart.values()) {
            OrderDetail detail = new OrderDetail();
            detail.setOrderID(orderID);
            detail.setProductID(item.getProduct().getProductID());
            detail.setQuantity(item.getQuantity());
            detail.setUnitPrice(item.getProduct().getPrice());
            orderDetailDAO.insertOrderDetail(detail);

            // 3️⃣ Trừ stock
            int newStock = item.getProduct().getStockQuantity() - item.getQuantity();
            productDAO.updateStockQuantity(item.getProduct().getProductID(), newStock);
        }

        // 4️⃣ Xóa giỏ
        session.removeAttribute("cart");
        request.setAttribute("message", "Thanh toán thành công! Mã đơn hàng: " + orderID);
        request.getRequestDispatcher("checkout_success.jsp").forward(request, response);
    }
}
