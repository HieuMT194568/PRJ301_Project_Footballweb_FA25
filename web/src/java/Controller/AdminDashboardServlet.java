package Controller;

import Dal.RevenueDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/revenue")
public class AdminDashboardServlet extends HttpServlet {

    private RevenueDAO revenueDAO = new RevenueDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        double totalRevenue = revenueDAO.getTotalRevenue();
        int ordersThisMonth = revenueDAO.getOrdersThisMonth();
        Map<String, Double> monthlyRevenue = revenueDAO.getMonthlyRevenue();
        Map<String, Integer> topProducts = revenueDAO.getTopProducts();

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("ordersThisMonth", ordersThisMonth);
        request.setAttribute("monthlyRevenue", monthlyRevenue);
        request.setAttribute("topProducts", topProducts);

        request.getRequestDispatcher("revenue_dashboard.jsp").forward(request, response);
    }
}
