package Controller;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Dal.*;
import Model.RevenueData;

@WebServlet(name = "AdminDataApiServlet", urlPatterns = {"/admin-api-data"})
public class AdminDataApiServlet extends HttpServlet {

    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy tất cả dữ liệu từ DAO
        RevenueDAO revenueDAO = new RevenueDAO();
        int totalUsers = revenueDAO.getTotalUsers();
        int ordersThisMonth = revenueDAO.getOrdersThisMonth();
        double totalRevenue = revenueDAO.getTotalRevenue();
        int totalProducts = revenueDAO.getTotalProducts();

        // Lấy dữ liệu cho biểu đồ (Ví dụ)
        RevenueData revenueData = revenueDAO.getRevenueDataLast7Days();

        // 2. Tạo một Map để chứa tất cả dữ liệu
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("totalUsers", totalUsers);
        dataMap.put("ordersThisMonth", ordersThisMonth);
        dataMap.put("totalRevenue", totalRevenue);
        dataMap.put("totalProducts", totalProducts);

        // Đưa 2 list từ đối tượng RevenueData vào Map
        dataMap.put("chartLabels", revenueData.getLabels());
        dataMap.put("chartData", revenueData.getData());
        // 3. Chuyển Map thành chuỗi JSON
        String jsonData = this.gson.toJson(dataMap);

        // 4. Trả JSON về cho trình duyệt
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.print(jsonData);
            out.flush();
        }
    }
}
