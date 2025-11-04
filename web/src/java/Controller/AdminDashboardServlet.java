package Controller;

import Dal.OrderDAO;
import Dal.RevenueDAO;
import Model.Order;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "admin", urlPatterns = {"/admin"})
public class AdminDashboardServlet extends HttpServlet {

    private RevenueDAO revenueDAO = new RevenueDAO();
    private OrderDAO OrderDAO = new OrderDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Order> orderList = OrderDAO.getRecentOrders();
            double totalRevenue = revenueDAO.getTotalRevenue();
            int ordersThisMonth = revenueDAO.getOrdersThisMonth();
            int totalUsers = revenueDAO.getTotalUsers();
            int totalProducts = revenueDAO.getTotalProducts();
            Map<String, Double> monthlyRevenue = revenueDAO.getMonthlyRevenue();
            
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("ordersThisMonth", ordersThisMonth);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("monthlyRevenue", monthlyRevenue);

            // Forward đến trang dashboard
            request.setAttribute("orderList", orderList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/admin_dashboard.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi DB hoặc DAO
            request.setAttribute("errorMessage", "Không thể tải dữ liệu Dashboard: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
